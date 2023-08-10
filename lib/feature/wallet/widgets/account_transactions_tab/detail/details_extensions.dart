import 'package:app/di/di.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:app/generated/generated.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Returns Money instance for native currency with [value].
Money _getNativeMoney(BigInt value) => Money.fromBigIntWithCurrency(
      value,
      Currencies()[
          inject<NekotonRepository>().currentTransport.nativeTokenTicker]!,
    );

extension KnownPayloadX on KnownPayload {
  /// Returns pair, where 1-st item is title of section,
  /// 2-nd item list of content specified for payload
  // ignore: long-method
  (String, List<TonWalletTransactionDetailsItem>)? toRepresentableData() =>
      when(
        comment: (data) => data.isNotEmpty
            ? (
                LocaleKeys.commentWord.tr(),
                [
                  TonWalletTransactionDetailsItem(
                    title: LocaleKeys.commentWord.tr(),
                    content: data,
                  ),
                ]
              )
            : null,
        tokenOutgoingTransfer: (data) => (
          LocaleKeys.tokenIncomingTransfer.tr(),
          [
            data.to.when(
              ownerWallet: (data) => TonWalletTransactionDetailsItem(
                title: LocaleKeys.ownerWallet.tr(),
                content: data.address,
              ),
              tokenWallet: (data) => TonWalletTransactionDetailsItem(
                title: LocaleKeys.tokenWallet.tr(),
                content: data.address,
              ),
            ),
            TonWalletTransactionDetailsItem(
              title: LocaleKeys.tokensWord.tr(),
              contentChild: MoneyWidget(
                money: _getNativeMoney(data.tokens),
                style: MoneyWidgetStyle.primary,
              ),
            ),
          ],
        ),
        tokenSwapBack: (data) => (
          LocaleKeys.tokenSwapBack.tr(),
          [
            TonWalletTransactionDetailsItem(
              title: LocaleKeys.tokensWord.tr(),
              contentChild: MoneyWidget(
                money: _getNativeMoney(data.tokens),
                style: MoneyWidgetStyle.primary,
              ),
            ),
            TonWalletTransactionDetailsItem(
              title: LocaleKeys.callbackAddress.tr(),
              content: data.callbackAddress.address,
            ),
            TonWalletTransactionDetailsItem(
              title: LocaleKeys.callbackPayload.tr(),
              content: data.callbackPayload,
            ),
          ],
        ),
      );
}

extension WalletInteractionMethodX on WalletInteractionMethod {
  /// Returns pair, where 1-st item is title of section,
  /// 2-nd item list of content specified for interaction method
  // ignore: long-method
  (String, List<TonWalletTransactionDetailsItem>) toRepresentableData() => when(
        walletV3Transfer: () => (
          LocaleKeys.walletV3Transfer.tr(),
          [],
        ),
        multisig: (data) => data.when(
          send: (data) => (
            LocaleKeys.multisigSendTransaction.tr(),
            [
              TonWalletTransactionDetailsItem(
                title: LocaleKeys.destinationWord.tr(),
                content: data.dest.address,
              ),
              TonWalletTransactionDetailsItem(
                title: LocaleKeys.valueWord.tr(),
                contentChild: MoneyWidget(
                  money: _getNativeMoney(data.value),
                  style: MoneyWidgetStyle.primary,
                ),
              ),
              TonWalletTransactionDetailsItem(
                title: LocaleKeys.bounceWord.tr(),
                content: data.bounce
                    ? LocaleKeys.yesWord.tr()
                    : LocaleKeys.noWord.tr(),
              ),
              TonWalletTransactionDetailsItem(
                title: LocaleKeys.flagsWord.tr(),
                content: data.flags.toString(),
              ),
              TonWalletTransactionDetailsItem(
                title: LocaleKeys.payloadWord.tr(),
                content: data.payload,
              ),
            ],
          ),
          submit: (data) => (
            LocaleKeys.multisigSubmitTransaction.tr(),
            [
              TonWalletTransactionDetailsItem(
                title: LocaleKeys.custodianWord.tr(),
                content: data.custodian.publicKey,
              ),
              TonWalletTransactionDetailsItem(
                title: LocaleKeys.destinationWord.tr(),
                content: data.dest.address,
              ),
              TonWalletTransactionDetailsItem(
                title: LocaleKeys.valueWord.tr(),
                contentChild: MoneyWidget(
                  money: _getNativeMoney(data.value),
                  style: MoneyWidgetStyle.primary,
                ),
              ),
              TonWalletTransactionDetailsItem(
                title: LocaleKeys.bounceWord.tr(),
                content: data.bounce
                    ? LocaleKeys.yesWord.tr()
                    : LocaleKeys.noWord.tr(),
              ),
              TonWalletTransactionDetailsItem(
                title: LocaleKeys.allBalance.tr(),
                content: data.allBalance
                    ? LocaleKeys.yesWord.tr()
                    : LocaleKeys.noWord.tr(),
              ),
              TonWalletTransactionDetailsItem(
                title: LocaleKeys.payloadWord.tr(),
                content: data.payload,
              ),
              TonWalletTransactionDetailsItem(
                title: LocaleKeys.transactionId.tr(),
                content: data.transId,
              ),
            ],
          ),
          confirm: (data) => (
            LocaleKeys.multisigConfirmTransaction.tr(),
            [
              TonWalletTransactionDetailsItem(
                title: LocaleKeys.custodianWord.tr(),
                content: data.custodian.publicKey,
              ),
              TonWalletTransactionDetailsItem(
                title: LocaleKeys.transactionId.tr(),
                content: data.transactionId,
              ),
            ],
          ),
        ),
      );
}

extension WalletInteractionInfoX on WalletInteractionInfo {
  /// Returns list of content specified for interaction info
  List<TonWalletTransactionDetailsItem> toRepresentableData() {
    final knownPayloadData = knownPayload?.toRepresentableData();
    final methodData = method.toRepresentableData();

    return [
      if (recipient != null)
        TonWalletTransactionDetailsItem(
          title: LocaleKeys.recipientWord.tr(),
          content: recipient!.address,
        ),
      if (knownPayloadData != null) ...[
        TonWalletTransactionDetailsItem(
          title: LocaleKeys.knownPayload.tr(),
          content: knownPayloadData.$1,
        ),
        ...knownPayloadData.$2,
      ],
      TonWalletTransactionDetailsItem(
        title: LocaleKeys.methodWord.tr(),
        content: methodData.$1,
      ),
      ...methodData.$2,
    ];
  }
}

extension TokenWalletDeployedNotificationX on TokenWalletDeployedNotification {
  /// Returns content, specified for deploy notification
  TonWalletTransactionDetailsItem toRepresentableData() =>
      TonWalletTransactionDetailsItem(
        title: LocaleKeys.rootTokenContract.tr(),
        content: rootTokenContract.address,
      );
}

extension DePoolReceiveAnswerNotificationX on DePoolReceiveAnswerNotification {
  /// Returns content, specified for answer notification
  List<TonWalletTransactionDetailsItem> toRepresentableData() => [
        TonWalletTransactionDetailsItem(
          title: LocaleKeys.errorCode.tr(),
          content: '$errorCode',
        ),
        TonWalletTransactionDetailsItem(
          title: LocaleKeys.commentWord.tr(),
          content: comment,
        ),
      ];
}

extension DePoolOnRoundCompleteNotificationX
    on DePoolOnRoundCompleteNotification {
  /// Returns content, specified for complete notification
  List<TonWalletTransactionDetailsItem> toRepresentableData() => [
        TonWalletTransactionDetailsItem(
          title: LocaleKeys.roundId.tr(),
          content: roundId,
        ),
        TonWalletTransactionDetailsItem(
          title: LocaleKeys.rewardWord.tr(),
          contentChild: MoneyWidget(
            money: _getNativeMoney(reward),
            style: MoneyWidgetStyle.primary,
          ),
        ),
        TonWalletTransactionDetailsItem(
          title: LocaleKeys.ordinaryStake.tr(),
          contentChild: MoneyWidget(
            money: _getNativeMoney(ordinaryStake),
            style: MoneyWidgetStyle.primary,
          ),
        ),
        TonWalletTransactionDetailsItem(
          title: LocaleKeys.vestingStake.tr(),
          contentChild: MoneyWidget(
            money: _getNativeMoney(vestingStake),
            style: MoneyWidgetStyle.primary,
          ),
        ),
        TonWalletTransactionDetailsItem(
          title: LocaleKeys.lockStake.tr(),
          contentChild: MoneyWidget(
            money: _getNativeMoney(lockStake),
            style: MoneyWidgetStyle.primary,
          ),
        ),
        TonWalletTransactionDetailsItem(
          title: LocaleKeys.reinvestWord.tr(),
          content: reinvest ? LocaleKeys.yesWord.tr() : LocaleKeys.noWord.tr(),
        ),
        TonWalletTransactionDetailsItem(
          title: LocaleKeys.reasonWord.tr(),
          content: reason.toString(),
        ),
      ];
}
