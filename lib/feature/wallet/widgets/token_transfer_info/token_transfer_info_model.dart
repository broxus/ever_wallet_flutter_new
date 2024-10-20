import 'package:app/app/service/service.dart';
import 'package:app/data/models/models.dart';
import 'package:collection/collection.dart';
import 'package:elementary/elementary.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

class TokenTransferInfoModel extends ElementaryModel {
  TokenTransferInfoModel(
    ErrorHandler errorHandler,
    this._nekotonRepository,
    this._currenciesService,
    this._assetsService,
  ) : super(errorHandler: errorHandler);

  final NekotonRepository _nekotonRepository;
  final CurrenciesService _currenciesService;
  final AssetsService _assetsService;

  TransportStrategy get transport => _nekotonRepository.currentTransport;

  Future<CustomCurrency?> getCurrencyForNativeToken() async =>
      _currenciesService
          .currencies(transport.networkType)
          .firstWhereOrNull((c) => c.address == transport.nativeTokenAddress) ??
      await _currenciesService.getCurrencyForNativeToken(transport);

  Future<CustomCurrency?> getCurrencyForContract(Address address) async =>
      _currenciesService
          .currencies(transport.networkType)
          .firstWhereOrNull((c) => c.address == address) ??
      await _currenciesService.getCurrencyForContract(transport, address);

  Future<TokenContractAsset?> getTokenAsset(Address address) =>
      _assetsService.getTokenContractAsset(address, transport);
}
