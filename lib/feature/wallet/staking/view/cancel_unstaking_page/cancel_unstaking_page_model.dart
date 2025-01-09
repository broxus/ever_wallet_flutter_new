import 'package:app/app/service/service.dart';
import 'package:app/data/models/models.dart';
import 'package:elementary/elementary.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

class CancelUnstakingPageModel extends ElementaryModel {
  CancelUnstakingPageModel(
    ErrorHandler errorHandler,
    this._nekotonRepository,
    this._stakingService,
    this._assetsService,
  ) : super(errorHandler: errorHandler);

  final NekotonRepository _nekotonRepository;
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

  Future<TokenContractAsset?> getTokenContractAsset() =>
      _assetsService.getTokenContractAsset(
        staking.stakingRootContractAddress,
        transport,
      );

  Future<String> getPayload(String nonce) =>
      _stakingService.removeWithdrawPayload(nonce);

  void acceptCancelledWithdraw(StEverWithdrawRequest request) =>
      _stakingService.acceptCancelledWithdraw(request);
}
