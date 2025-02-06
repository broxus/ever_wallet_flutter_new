import 'package:app/feature/wallet/wallet.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/detail/details_item.dart';
import 'package:app/feature/wallet/widgets/token_transfer_info/token_transfer_info_wm.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class TokenTransferInfoWidget
    extends ElementaryWidget<TokenTransferInfoWidgetModel> {
  const TokenTransferInfoWidget({
    required this.recipient,
    required this.fee,
    this.margin = EdgeInsets.zero,
    this.amount,
    this.attachedAmount,
    this.rootTokenContract,
    this.transactionIdHash,
    this.comment,
    this.feeError,
    this.color,
    this.numberUnconfirmedTransactions,
    Key? key,
    WidgetModelFactory wmFactory = defaultTokenTransferInfoWidgetModelFactory,
  }) : super(wmFactory, key: key);

  final EdgeInsets margin;
  final Money? amount;
  final Address recipient;
  final BigInt? fee;
  final BigInt? attachedAmount;
  final Address? rootTokenContract;
  final String? transactionIdHash;
  final String? comment;
  final String? feeError;
  final Color? color;
  final int? numberUnconfirmedTransactions;

  @override
  Widget build(TokenTransferInfoWidgetModel wm) {
    final theme = wm.theme;
    final labelSmallContent3 = theme.textStyles.labelSmall.copyWith(
      color: theme.colors.content3,
    );

    return PrimaryCard(
      padding: const EdgeInsets.all(DimensSizeV2.d16),
      margin: margin,
      borderRadius: BorderRadius.circular(DimensRadiusV2.radius16),
      color: color,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (amount != null)
            _InfoRow(
              label: LocaleKeys.token.tr(),
              child: Text(
                amount!.currency.symbol,
                style: theme.textStyles.labelSmall,
              ),
            ),
          const SizedBox(height: DimensSizeV2.d16),
          if (amount != null)
            _InfoRow(
              label: LocaleKeys.amountWord.tr(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  StateNotifierBuilder(
                    listenableState: wm.tokenAsset,
                    builder: (_, asset) {
                      final icon = asset?.let(
                            (asset) => TokenWalletIconWidget(
                              address: asset.address,
                              logoURI: asset.logoURI,
                              version: asset.version,
                              size: DimensSizeV2.d20,
                            ),
                          ) ??
                          TonWalletIconWidget(
                            path: wm.isNative
                                ? wm.nativeTokenIcon
                                : Assets.images.tokenDefaultIcon.path,
                            size: DimensSizeV2.d20,
                          );

                      return AmountWidget.fromMoney(
                        amount: amount!,
                        icon: icon,
                        includeSymbol: false,
                      );
                    },
                  ),
                  StateNotifierBuilder(
                    listenableState: wm.amountPrice,
                    builder: (_, value) => value != null
                        ? Padding(
                            padding:
                                const EdgeInsets.only(top: DimensSizeV2.d4),
                            child: AmountWidget.dollars(
                              amount: value,
                              style: theme.textStyles.labelXSmall.copyWith(
                                color: theme.colors.content3,
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                ],
              ),
            ),
          DoubleSourceBuilder(
            firstSource: wm.attachedAmount,
            secondSource: wm.attachedAmountPrice,
            builder: (_, attachedAmount, attachedAmountPrice) {
              if (attachedAmount == null) return const SizedBox.shrink();

              final child = _InfoRow(
                label: LocaleKeys.attachedAmount.tr(),
                child: SeparatedColumn(
                  separatorSize: DimensSize.d4,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    AmountWidget.fromMoney(
                      amount: Money.fromBigIntWithCurrency(
                        attachedAmount,
                        wm.nativeCurrency,
                      ),
                      icon: TonWalletIconWidget(
                        path: wm.nativeTokenIcon,
                        size: DimensSizeV2.d20,
                      ),
                      includeSymbol: false,
                    ),
                    if (attachedAmountPrice != null)
                      AmountWidget.dollars(
                        amount: attachedAmountPrice,
                        style: theme.textStyles.labelXSmall.copyWith(
                          color: theme.colors.content3,
                        ),
                      ),
                  ],
                ),
              );

              return Padding(
                padding: const EdgeInsets.only(top: DimensSizeV2.d16),
                child: child,
              );
            },
          ),
          const SizedBox(height: DimensSizeV2.d16),
          TripleSourceBuilder(
            firstSource: wm.fee,
            secondSource: wm.feeError,
            thirdSource: wm.customCurrency,
            builder: (
              _,
              fee,
              feeError,
              customCurrency,
            ) {
              return SeparatedColumn(
                separatorSize: DimensSizeV2.d4,
                children: [
                  WalletTransactionDetailsItem(
                    title: LocaleKeys.networkFee.tr(),
                    valueWidget: AmountWidget.fromMoney(
                      amount: Money.fromBigIntWithCurrency(
                        fee ?? BigInt.zero,
                        wm.nativeCurrency,
                      ),
                      sign: '~ ',
                      includeSymbol: false,
                    ),
                    iconPath: wm.nativeTokenIcon,
                    convertedValueWidget: AmountWidget.dollars(
                      amount: Money.fromBigIntWithCurrency(
                        fee ?? BigInt.zero,
                        wm.nativeCurrency,
                      ).exchangeToUSD(
                        Fixed.parse(customCurrency?.price ?? '0'),
                        5,
                      ),
                      style: theme.textStyles.labelXSmall.copyWith(
                        color: theme.colors.content3,
                      ),
                    ),
                  ),
                  if ((numberUnconfirmedTransactions ?? 0) >= 5)
                    Text(
                      LocaleKeys.errorMessageMaxUnconfirmedTransactions.tr(),
                      style: theme.textStyles.labelSmall.copyWith(
                        color: theme.colors.negative,
                      ),
                    )
                  else if (feeError != null)
                    Text(
                      feeError,
                      style: theme.textStyles.labelSmall.copyWith(
                        color: theme.colors.negative,
                      ),
                    ),
                ],
              );
            },
          ),
          const SizedBox(height: DimensSizeV2.d16),
          SeparatedColumn(
            separatorSize: DimensSizeV2.d2,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.recipientWord.tr(),
                style: labelSmallContent3,
              ),
              Text(
                recipient.address,
                style: theme.textStyles.labelSmall,
              ),
            ],
          ),
          if (transactionIdHash != null)
            Padding(
              padding: const EdgeInsets.only(top: DimensSizeV2.d16),
              child: SeparatedColumn(
                separatorSize: DimensSizeV2.d2,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleKeys.transactionId.tr(),
                    style: labelSmallContent3,
                  ),
                  Text(
                    transactionIdHash!,
                    style: theme.textStyles.labelSmall,
                  ),
                ],
              ),
            ),
          if (comment != null)
            Padding(
              padding: const EdgeInsets.only(top: DimensSizeV2.d16),
              child: SeparatedColumn(
                separatorSize: DimensSizeV2.d2,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleKeys.commentWord.tr(),
                    style: labelSmallContent3,
                  ),
                  Text(
                    comment!,
                    style: theme.textStyles.labelSmall,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.label,
    required this.child,
  });

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return SeparatedRow(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textStyles.labelSmall.copyWith(
            color: theme.colors.content3,
          ),
        ),
        Flexible(child: child),
      ],
    );
  }
}
