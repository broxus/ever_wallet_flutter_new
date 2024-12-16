import 'package:app/http/api/ton/ton_api.dart';
import 'package:app/http/dto/ton_token_info/ton_token_info_dto.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

const _baseUrl = 'https://ton-tokens-api.bf.works';

@singleton
class TonRepository {
  TonRepository(
    this.dio,
  ) : api = TonApi(dio, baseUrl: _baseUrl);

  final Dio dio;
  final TonApi api;

  Future<TonTokenInfoDto> getTokenInfo({
    required Address address,
  }) =>
      api.getTokenInfo(address.address);
}
