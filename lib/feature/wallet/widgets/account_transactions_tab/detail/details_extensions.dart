import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/detail/details_item.dart';
import 'package:app/generated/generated.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Returns Money instance for native currency with [value].
Money _getNativeMoney(BigInt value) => Money.fromBigIntWithCurrency(
      value,
      Currencies()[
          inject<NekotonRepository>().currentTransport.nativeTokenTicker]!,
    );

/// Returns Money instance for token currency with [tokenAddress] if found
/// with [value] or do not display token symbol.
Money _getTokenMoney(BigInt value, Address tokenAddress) {
  final possibleTokenSymbol = inject<AssetsService>()
      .maybeGetTokenContract(
        tokenAddress,
        inject<NekotonRepository>().currentTransport,
      )
      ?.symbol;
  final currency =
      possibleTokenSymbol == null ? null : Currencies()[possibleTokenSymbol];

  return Money.fromBigIntWithCurrency(
    value,
    currency ?? Currency.create('.', 0, symbol: '.', pattern: moneyPattern(0)),
  );
}

/// Pair, where 1-st item is title of section,
/// 2-nd item list of content specified for payload
typedef DetailsTitleAndBody = (String, List<TonWalletTransactionDetailsItem>);

extension KnownPayloadX on KnownPayload {
  // ignore: long-method
  DetailsTitleAndBody? toRepresentableData() => when(
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
                copyValue: data.address,
                copyMessage: LocaleKeys.valueCopiedExclamation.tr(
                  args: [data.toEllipseString()],
                ),
              ),
              tokenWallet: (data) => TonWalletTransactionDetailsItem(
                title: LocaleKeys.tokenWallet.tr(),
                content: data.address,
                copyValue: data.address,
                copyMessage: LocaleKeys.valueCopiedExclamation.tr(
                  args: [data.toEllipseString()],
                ),
              ),
            ),
            TonWalletTransactionDetailsItem(
              title: LocaleKeys.tokensWord.tr(),
              contentChild: MoneyWidget(
                money: _getTokenMoney(
                  data.tokens,
                  data.to.when(
                    ownerWallet: (data) => data,
                    tokenWallet: (data) => data,
                  ),
                ),
                style: MoneyWidgetStyle.primary,
                showSymbol: false,
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
                money: _getTokenMoney(
                  data.tokens,
                  data.callbackAddress,
                ),
                style: MoneyWidgetStyle.primary,
                showSymbol: false,
              ),
            ),
            TonWalletTransactionDetailsItem(
              title: LocaleKeys.callbackAddress.tr(),
              content: data.callbackAddress.address,
              copyValue: data.callbackAddress.address,
              copyMessage: LocaleKeys.valueCopiedExclamation.tr(
                args: [data.callbackAddress.toEllipseString()],
              ),
            ),
            TonWalletTransactionDetailsItem(
              title: LocaleKeys.callbackPayload.tr(),
              content: data.callbackPayload,
            ),
          ],
        ),
        jettonOutgoingTransfer: (data) => (
          LocaleKeys.tokenIncomingTransfer.tr(),
          [
            TonWalletTransactionDetailsItem(
              title: LocaleKeys.tokenWallet.tr(),
              content: data.to.address,
              copyValue: data.to.address,
              copyMessage: LocaleKeys.valueCopiedExclamation.tr(
                args: [data.to.toEllipseString()],
              ),
            ),
            TonWalletTransactionDetailsItem(
              title: LocaleKeys.tokensWord.tr(),
              contentChild: MoneyWidget(
                money: _getTokenMoney(data.tokens, data.to),
                style: MoneyWidgetStyle.primary,
                showSymbol: false,
              ),
            ),
          ],
        ),
      );
}

extension WalletInteractionMethodX on WalletInteractionMethod {
  /// Returns pair, where 1-st item is title of section,
  /// 2-nd item list of content specified for interaction method
  // ignore: long-method
  DetailsTitleAndBody toRepresentableData() => when(
        walletV3Transfer: () => (
          LocaleKeys.walletV3Transfer.tr(),
          [],
        ),
        tonWalletTransfer: () => (
          LocaleKeys.tonWalletTransfer.tr(),
          [],
        ),
        multisig: (data) => data.when(
          send: (data) => (
            LocaleKeys.multisigSendTransaction.tr(),
            [
              TonWalletTransactionDetailsItem(
                title: LocaleKeys.destinationWord.tr(),
                content: data.dest.address,
                copyValue: data.dest.address,
                copyMessage: LocaleKeys.valueCopiedExclamation.tr(
                  args: [data.dest.toEllipseString()],
                ),
              ),
              TonWalletTransactionDetailsItem(
                title: LocaleKeys.valueWord.tr(),
                contentChild: MoneyWidget(
                  money: _getTokenMoney(data.value, data.dest),
                  style: MoneyWidgetStyle.primary,
                  showSymbol: false,
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
                copyValue: data.custodian.publicKey,
                copyMessage: LocaleKeys.valueCopiedExclamation.tr(
                  args: [data.custodian.toEllipseString()],
                ),
              ),
              TonWalletTransactionDetailsItem(
                title: LocaleKeys.destinationWord.tr(),
                content: data.dest.address,
                copyValue: data.dest.address,
                copyMessage: LocaleKeys.valueCopiedExclamation.tr(
                  args: [data.dest.toEllipseString()],
                ),
              ),
              TonWalletTransactionDetailsItem(
                title: LocaleKeys.valueWord.tr(),
                contentChild: MoneyWidget(
                  money: _getTokenMoney(data.value, data.dest),
                  style: MoneyWidgetStyle.primary,
                  showSymbol: false,
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
                copyValue: data.transId,
                copyMessage: LocaleKeys.valueCopiedExclamation.tr(
                  args: [data.transId],
                ),
              ),
            ],
          ),
          confirm: (data) => (
            LocaleKeys.multisigConfirmTransaction.tr(),
            [
              TonWalletTransactionDetailsItem(
                title: LocaleKeys.custodianWord.tr(),
                content: data.custodian.publicKey,
                copyValue: data.custodian.publicKey,
                copyMessage: LocaleKeys.valueCopiedExclamation.tr(
                  args: [data.custodian.toEllipseString()],
                ),
              ),
              TonWalletTransactionDetailsItem(
                title: LocaleKeys.transactionId.tr(),
                content: data.transactionId,
                copyValue: data.transactionId,
                copyMessage: LocaleKeys.valueCopiedExclamation.tr(
                  args: [data.transactionId],
                ),
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
          copyValue: recipient!.address,
          copyMessage: LocaleKeys.valueCopiedExclamation.tr(
            args: [recipient!.toEllipseString()],
          ),
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
        copyValue: rootTokenContract.address,
        copyMessage: LocaleKeys.valueCopiedExclamation.tr(
          args: [rootTokenContract.toEllipseString()],
        ),
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
