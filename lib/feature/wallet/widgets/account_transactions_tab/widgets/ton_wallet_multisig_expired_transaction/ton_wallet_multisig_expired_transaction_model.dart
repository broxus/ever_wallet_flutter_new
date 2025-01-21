import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_multisig_expired_transaction/ton_wallet_multisig_expired_transaction_widget.dart';
import 'package:elementary/elementary.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// [ElementaryModel] for [TonWalletMultisigExpiredTransactionWidget]
class TonWalletMultisigExpiredTransactionModel extends ElementaryModel {
  TonWalletMultisigExpiredTransactionModel(
    ErrorHandler errorHandler,
    this._nekotonRepository,
  ) : super(errorHandler: errorHandler);

  final NekotonRepository _nekotonRepository;

  late final nativeTokenTicker =
      _nekotonRepository.currentTransport.nativeTokenTicker;

  late final tonIconPath = _nekotonRepository.currentTransport.nativeTokenIcon;

  String getTransactionExplorerLink(String hash) {
    return _nekotonRepository.currentTransport.transactionExplorerLink(hash);
  }
}
