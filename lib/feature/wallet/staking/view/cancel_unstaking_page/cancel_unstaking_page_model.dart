import 'package:app/app/service/service.dart';
import 'package:app/data/models/models.dart';
import 'package:app/utils/utils.dart';
import 'package:elementary/elementary.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

class CancelUnstakingPageModel extends ElementaryModel {
  CancelUnstakingPageModel(
    ErrorHandler errorHandler,
    this._nekotonRepository,
    this._stakingService,
    this._assetsService,
    this._gasPriceService,
  ) : super(errorHandler: errorHandler);

  final NekotonRepository _nekotonRepository;
  final StakingService _stakingService;
  final AssetsService _assetsService;
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

  Future<TokenContractAsset?> getTokenContractAsset() =>
      _assetsService.getTokenContractAsset(
        _staking.stakingRootContractAddress,
        transport,
      );

  Future<String> getPayload(String nonce) =>
      _stakingService.removeWithdrawPayload(nonce);

  void acceptCancelledWithdraw(StEverWithdrawRequest request) =>
      _stakingService.acceptCancelledWithdraw(request);
}
