import 'dart:async';

import 'package:app/app/service/service.dart';
import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/browser/approvals_listener/actions/send_message/send_message_model.dart';
import 'package:app/feature/browser/approvals_listener/actions/send_message/send_message_widget.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class TransferData {
  TransferData({
    required this.amount,
    this.attachedAmount,
    this.rootTokenContract,
  });

  final Money amount;
  final BigInt? attachedAmount;
  final Address? rootTokenContract;
}

SendMessageWidgetModel defaultSendMessageWidgetModelFactory(
  BuildContext context,
) =>
    SendMessageWidgetModel(
      SendMessageModel(
        createPrimaryErrorHandler(context),
        inject(),
      ),
    );

class SendMessageWidgetModel
    extends CustomWidgetModel<SendMessageWidget, SendMessageModel> {
  SendMessageWidgetModel(super.model);

  late final account = model.getAccount(widget.sender);

  late final _data = createNotifier<TransferData>();
  late final _fee = createNotifier<BigInt>();
  late final _feeError = createNotifier<String>();
  late final _publicKey = createNotifier(account?.publicKey);
  late final _custodians = createNotifier<List<PublicKey>>();
  late final _balance = createNotifier<Money>();
  late final StreamSubscription<Money> _subscription;

  ListenableState<TransferData> get data => _data;

  ListenableState<BigInt> get fee => _fee;

  ListenableState<String> get feeError => _feeError;

  ListenableState<PublicKey> get publicKey => _publicKey;

  ListenableState<List<PublicKey>> get custodians => _custodians;

  ListenableState<Money?> get balance => _balance;

  Currency get nativeCurrency =>
      Currencies()[model.transport.nativeTokenTicker]!;

  ThemeStyleV2 get theme => context.themeStyleV2;

  @override
  void initWidgetModel() {
    super.initWidgetModel();

    final tokens = widget.knownPayload?.whenOrNull(
      tokenOutgoingTransfer: (data) => data.tokens,
      tokenSwapBack: (data) => data.tokens,
    );

    if (tokens == null) {
      _data.accept(
        TransferData(
          amount: Money.fromBigIntWithCurrency(widget.amount, nativeCurrency),
        ),
      );
    } else {
      _getTokenTransferData(tokens);
    }

    _subscription =
        model.getBalanceStream(widget.sender).listen(_balance.accept);

    _getCustodians();
    _estimateFees();
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  String? getSeedName(PublicKey custodian) => model.getSeedName(custodian);

  void onChangedCustodian(PublicKey custodian) => _publicKey.accept(custodian);

  void onSubmit(String password) =>
      Navigator.of(context).pop((publicKey.value, password));

  Future<void> _getTokenTransferData(BigInt tokens) async {
    final (rootTokenContract, details) =
        await model.getTokenRootDetailsFromTokenWallet(widget.recipient);
    final pattern = details.decimals > 0 ? moneyPattern(details.decimals) : '0';
    final currency = Currency.create(
      details.symbol,
      details.decimals,
      symbol: details.symbol,
      pattern: pattern,
    );

    _data.accept(
      TransferData(
        amount: Money.fromBigIntWithCurrency(tokens, currency),
        attachedAmount: widget.amount,
        rootTokenContract: rootTokenContract,
      ),
    );
  }

  Future<void> _getCustodians() async {
    final custodians = await model.getLocalCustodiansAsync(widget.sender);
    _custodians.accept(custodians);
  }

  Future<void> _estimateFees() async {
    try {
      final fee = await model.estimateFees(
        address: widget.sender,
        destination: widget.recipient,
        publicKey: account?.publicKey,
        amount: widget.amount,
        payload: widget.payload,
        bounce: widget.bounce,
      );

      _fee.accept(fee);
    } on FfiException catch (e) {
      _feeError.accept(e.message);
    } on Exception catch (e) {
      _feeError.accept(e.toString());
    }
  }
}
