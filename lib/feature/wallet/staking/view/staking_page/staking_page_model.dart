import 'package:app/app/service/service.dart';
import 'package:app/data/models/models.dart';
import 'package:elementary/elementary.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

class StakingPageModel extends ElementaryModel {
  StakingPageModel(
    ErrorHandler errorHandler,
    this._nekotonRepository,
    this._currenciesService,
    this._stakingService,
    this._assetsService,
  ) : super(errorHandler: errorHandler) {
    _stakingService.resetCache();
  }

  final NekotonRepository _nekotonRepository;
  final CurrenciesService _currenciesService;
  final StakingService _stakingService;
  final AssetsService _assetsService;

  TransportStrategy get transport => _nekotonRepository.currentTransport;

  Currency get nativeCurrency => Currencies()[transport.nativeTokenTicker]!;

  StakingInformation get staking {
    if (transport.stakeInformation == null) {
      throw Exception('Stake information is not available');
    }
    return transport.stakeInformation!;
  }

  Stream<List<StEverWithdrawRequest>> getWithdrawRequests(Address address) =>
      _stakingService.withdrawRequestsStream(address);

  Future<TonWalletState> getWallet(Address address) =>
      _nekotonRepository.getWallet(address);

  Future<TokenWalletState> getTokenWallet(Address owner) =>
      _nekotonRepository.getTokenWallet(
        owner,
        staking.stakingRootContractAddress,
      );

  Future<CustomCurrency?> getTokenCurrency() =>
      _currenciesService.getOrFetchCurrency(
        transport,
        staking.stakingRootContractAddress,
      );

  Future<CustomCurrency?> getEverCurrency() =>
      _currenciesService.getOrFetchNativeCurrency(transport);

  Future<double> getAverageAPYPercent() =>
      _stakingService.getAverageAPYPercent();

  Future<StEverDetails> getStEverDetails() =>
      _stakingService.getStEverDetails();

  Future<TokenContractAsset?> getTokenContractAsset() =>
      _assetsService.getTokenContractAsset(
        staking.stakingRootContractAddress,
        transport,
      );

  Future<BigInt> getDepositTokenAmount(BigInt value) =>
      _stakingService.getDepositStEverAmount(value);

  Future<BigInt> getWithdrawEverAmount(BigInt value) =>
      _stakingService.getWithdrawEverAmount(value);
}
