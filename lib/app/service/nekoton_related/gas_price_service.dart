import 'dart:convert';
import 'dart:math';

import 'package:app/data/models/models.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

@singleton
class GasPriceService {
  GasPriceService(
    this._nekotonRepository,
  );

  final NekotonRepository _nekotonRepository;

  Transport get _transport => _nekotonRepository.currentTransport.transport;

  Future<GasPriceParams?> getGasPriceParams() async {
    try {
      final (fields, state) = await _transport.getContractFields(
        address: _address,
        contractAbi: _configAbi,
      );
      final (nonEmptyMap, hash) = await packIntoCell(
        abiVersion: '2.2',
        params: const [
          AbiParam(name: 'flag', type: 'bool'),
          AbiParam(name: 'root', type: 'cell'),
        ],
        tokens: {
          'flag': true,
          'root': fields!['paramsRoot'],
        },
      );
      final rawParams = await unpackFromCell(
        abiVersion: '2.2',
        params: const [AbiParam(name: 'params', type: 'map(uint32,cell)')],
        boc: nonEmptyMap,
        allowPartial: true,
      );
      final entries = (rawParams['params'] as List<dynamic>)
          .cast<List<dynamic>>()
          .map((e) => MapEntry(int.parse(e[0] as String), e[1] as String));
      final params = Map.fromEntries(entries);
      final data = await unpackFromCell(
        abiVersion: '2.2',
        params: (jsonDecode(_pricesParamAbi) as List<dynamic>)
            .map(
              (json) => AbiParam.fromJson(json as Map<String, dynamic>),
            )
            .toList(),
        boc: params[21]!, // 20 for masterchain
        allowPartial: true,
      );

      return GasPriceParams.fromJson(
        data['value'] as Map<String, dynamic>,
      );
    } catch (_) {
      return null;
    }
  }

  Future<BigInt> computeGas({
    required BigInt dynamicGas,
    required BigInt fixedGas,
    GasPriceParams? params,
  }) async {
    final p = params ?? await getGasPriceParams();
    final gasPrice = BigInt.from(
      (p?.gasPrice ?? _evrscaleGasPrice).toDouble() / pow(2, 16),
    );

    return dynamicGas * gasPrice + fixedGas;
  }
}

final _evrscaleGasPrice = BigInt.parse('65536000');
const _address = Address(
  address:
      '-1:5555555555555555555555555555555555555555555555555555555555555555',
);
const _configAbi = '''
{
  "ABI version": 2,
  "version": "2.2",
  "header": [],
  "functions": [],
  "events": [],
  "fields": [
    {
      "name": "paramsRoot",
      "type": "cell"
    }
  ]
}''';
const _pricesParamAbi = '''
[
  {
    "name": "value",
    "type": "tuple",
    "components": [
      { "name": "tag1", "type": "uint8" },
      { "name": "flatGasLimit", "type": "uint64" },
      { "name": "flatGasPrice", "type": "uint64" },
      { "name": "tag2", "type": "uint8" },
      { "name": "gasPrice", "type": "uint64" },
      { "name": "gasLimit", "type": "uint64" },
      { "name": "specialGasLimit", "type": "uint64" },
      { "name": "gasCredit", "type": "uint64" },
      { "name": "blockGasLimit", "type": "uint64" },
      { "name": "freezeDueLimit", "type": "uint64" },
      { "name": "deleteDueLimit", "type": "uint64" }
    ]
  }
]
''';
