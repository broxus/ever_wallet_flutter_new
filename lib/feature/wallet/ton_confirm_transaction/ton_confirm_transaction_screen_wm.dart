import 'package:app/app/router/router.dart';
import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/wallet/ton_confirm_transaction/data/ton_confirm_transaction_state.dart';
import 'package:app/feature/wallet/ton_confirm_transaction/ton_confirm_transaction_screen.dart';
import 'package:app/feature/wallet/ton_confirm_transaction/ton_confirm_transaction_screen_model.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// Factory method for creating [TonConfirmTransactionScreenWidgetModel]
TonConfirmTransactionScreenWidgetModel
    defaultTonConfirmTransactionScreenWidgetModelFactory(
  BuildContext context, {
  required Address walletAddress,
  required BigInt amount,
  required String transactionId,
}) {
  return TonConfirmTransactionScreenWidgetModel(
    TonConfirmTransactionScreenModel(
      createPrimaryErrorHandler(context),
      inject(),
      inject(),
      walletAddress,
      amount,
      transactionId,
    ),
  );
}

/// [WidgetModel] для [TonConfirmTransactionScreen]
class TonConfirmTransactionScreenWidgetModel extends CustomWidgetModel<
    TonConfirmTransactionScreen, TonConfirmTransactionScreenModel> {
  TonConfirmTransactionScreenWidgetModel(
    super.model,
  );

  late final screenState = createNotifier<TonConfirmTransactionState>(
    _localCustodians.length > 1
        ? const TonConfirmTransactionState.prepare()
        : TonConfirmTransactionState.loading(_localCustodians.first),
  );

  late PublicKey selectedCustodian;

  /// Fee for transaction after calculating it in [_handlePrepare]
  BigInt? _fees;

  final _logger = Logger('TonConfirmTransaction');

  KeyAccount? get account => model.account;

  Money? get money => model.money;

  BigInt get amount => model.amount;

  List<PublicKey> get _localCustodians => widget.localCustodians;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _init();
  }

  void onPasswordEntered(String value) {
    _handleSend(value);
  }

  void onPressedPrepare(PublicKey key) {
    _handlePrepare(key);
  }

  void _init() {
    if (widget.localCustodians.length == 1) {
      _handlePrepare(widget.localCustodians.first);
    }
  }

  Future<void> _handlePrepare(PublicKey custodian) async {
    UnsignedMessage? unsignedMessage;
    try {
      selectedCustodian = custodian;
      unsignedMessage = await model.prepareConfirmTransaction(
        selectedCustodian,
      );
      _fees = await model.estimateFees(unsignedMessage);

      final walletState = await model.walletState;

      if (walletState.hasError) {
        screenState.accept(
          TonConfirmTransactionState.subscribeError(walletState.error!),
        );
        return;
      }

      final wallet = walletState.wallet!;

      final balance = wallet.contractState.balance;

      final isPossibleToSendMessage = balance > (_fees! + model.amount);

      if (!isPossibleToSendMessage) {
        screenState.accept(
          TonConfirmTransactionState.calculatingError(
            LocaleKeys.insufficientFunds.tr(),
            selectedCustodian,
            _fees,
          ),
        );
        return;
      }

      screenState.accept(
        TonConfirmTransactionState.readyToSend(_fees!, selectedCustodian),
      );
    } catch (e, t) {
      _logger.severe('_handlePrepare:', e, t);
      screenState.accept(
        TonConfirmTransactionState.calculatingError(
          e.toString(),
          selectedCustodian,
        ),
      );
    } finally {
      unsignedMessage?.dispose();
    }
  }

  Future<void> _handleSend(String password) async {
    UnsignedMessage? unsignedMessage;

    if (_fees == null) {
      return;
    }

    try {
      screenState.accept(
        const TonConfirmTransactionState.sending(canClose: false),
      );
      unsignedMessage = await model.prepareConfirmTransaction(
        selectedCustodian,
      );

      final signedMessage = await model.createSignedMessage(
        hash: unsignedMessage.hash,
        selectedCustodian: selectedCustodian,
        password: password,
        unsignedMessage: unsignedMessage,
      );

      screenState.accept(
        const TonConfirmTransactionState.sending(canClose: true),
      );

      final transaction = await model.send(
        signedMessage: signedMessage,
        destination: widget.destination,
      );

      model.showSuccessful(contextSafe);

      screenState.accept(
        TonConfirmTransactionState.sent(
          _fees!,
          transaction,
          selectedCustodian,
        ),
      );

      _goToWallet();
    } on OperationCanceledException catch (_) {
    } catch (e, t) {
      _logger.severe('_handleSend', e, t);
      model.showError(contextSafe, e.toString());
      screenState.accept(
        TonConfirmTransactionState.readyToSend(_fees!, selectedCustodian),
      );
    } finally {
      unsignedMessage?.dispose();
    }
  }

  void _goToWallet() {
    context.goNamed(AppRoute.wallet.name);
  }
}
