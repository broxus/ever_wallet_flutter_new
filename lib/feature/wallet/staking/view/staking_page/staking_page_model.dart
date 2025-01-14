import 'package:app/app/service/service.dart';
import 'package:app/data/models/models.dart';
import 'package:app/utils/utils.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/widgets.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

class StakingPageModel extends ElementaryModel {
  StakingPageModel(
    ErrorHandler errorHandler,
    this._nekotonRepository,
    this._currenciesService,
    this._stakingService,
    this._assetsService,
    this._messengerService,
    this._gasPriceService,
  ) : super(errorHandler: errorHandler) {
    _stakingService.resetCache();
  }

  final NekotonRepository _nekotonRepository;
  final CurrenciesService _currenciesService;
  final StakingService _stakingService;
  final AssetsService _assetsService;
  final MessengerService _messengerService;
  final GasPriceService _gasPriceService;

  TransportStrategy get transport => _nekotonRepository.currentTransport;

  Currency get nativeCurrency => Currencies()[transport.nativeTokenTicker]!;

  StakingInformation get _staking {
    if (transport.stakeInformation == null) {
      throw Exception('Stake information is not available');
    }
    return transport.stakeInformation!;
  }

  Future<StakingInformation> getStakingInformation() async {
    final prices = await _gasPriceService.getGasPriceParams();
    final (deposit, withdraw, removePendingWithdraw) = await FutureExt.wait3(
      _gasPriceService.computeGas(_staking.stakeDepositAttachedFee, prices),
      _gasPriceService.computeGas(_staking.stakeWithdrawAttachedFee, prices),
      _gasPriceService.computeGas(
        _staking.stakeRemovePendingWithdrawAttachedFee,
        prices,
      ),
    );

    return StakingInformation(
      stakingAPYLink: _staking.stakingAPYLink,
      stakingRootContractAddress: _staking.stakingRootContractAddress,
      stakingValutAddress: _staking.stakingValutAddress,
      stakeDepositAttachedFee: deposit,
      stakeWithdrawAttachedFee: withdraw,
      stakeRemovePendingWithdrawAttachedFee: removePendingWithdraw,
    );
  }

  Stream<List<StEverWithdrawRequest>> getWithdrawRequests(Address address) =>
      _stakingService.withdrawRequestsStream(address);

  Future<TonWalletState> getWallet(Address address) =>
      _nekotonRepository.getWallet(address);

  Future<TokenWalletState> getTokenWallet(Address owner) =>
      _nekotonRepository.getTokenWallet(
        owner,
        _staking.stakingRootContractAddress,
      );

  Future<CustomCurrency?> getTokenCurrency() =>
      _currenciesService.getOrFetchCurrency(
        transport,
        _staking.stakingRootContractAddress,
      );

  Future<CustomCurrency?> getEverCurrency() =>
      _currenciesService.getOrFetchNativeCurrency(transport);

  Future<double> getAverageAPYPercent() =>
      _stakingService.getAverageAPYPercent();

  Future<StEverDetails> getStEverDetails() =>
      _stakingService.getStEverDetails();

  Future<TokenContractAsset?> getTokenContractAsset() =>
      _assetsService.getTokenContractAsset(
        _staking.stakingRootContractAddress,
        transport,
      );

  Future<BigInt> getDepositTokenAmount(BigInt value) =>
      _stakingService.getDepositStEverAmount(value);

  Future<BigInt> getWithdrawEverAmount(BigInt value) =>
      _stakingService.getWithdrawEverAmount(value);

  void showError(BuildContext context, String message) {
    _messengerService.show(
      Message.error(context: context, message: message),
    );
  }
}
