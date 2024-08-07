import 'package:app/di/di.dart';
import 'package:app/feature/profile/profile.dart';
import 'package:app/generated/generated.dart';
import 'package:app/v2/feature/wallet/wallet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

/// View that allows confirm send transaction by entering password
class TonWalletSendConfirmView extends StatelessWidget {
  const TonWalletSendConfirmView({
    required this.recipient,
    required this.amount,
    required this.comment,
    required this.publicKey,
    this.fee,
    this.attachedAmount,
    this.feeError,
    super.key,
  });

  final Address recipient;
  final BigInt amount;
  final BigInt? attachedAmount;
  final BigInt? fee;
  final String? comment;
  final String? feeError;
  final PublicKey publicKey;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<TonWalletSendBloc>();
    final transport = inject<NekotonRepository>().currentTransport;
    final iconPath = transport.nativeTokenIcon;
    final theme = context.themeStyleV2;
    final isLoading = fee == null && feeError == null;
    final currency = Currencies()[transport.nativeTokenTicker]!;

    final price = Fixed.parse(bloc.currency?.price ?? '0');
    final amountMoney = Money.fromBigIntWithCurrency(amount, currency);
    final feeMoney = Money.fromBigIntWithCurrency(fee ?? BigInt.zero, currency);
    final aaMoney = Money.fromBigIntWithCurrency(
      attachedAmount ?? BigInt.zero,
      currency,
    );

    return SeparatedColumn(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: SeparatedColumn(
              separatorSize: DimensSize.d16,
              children: [
                if (bloc.account != null)
                  AccountInfo(account: bloc.account!),

                PrimaryCard(
                  padding: const EdgeInsets.symmetric(
                    horizontal: DimensSizeV2.d16,
                    vertical: DimensSizeV2.d24,
                  ),
                  borderRadius: BorderRadius.circular(DimensRadiusV2.radius16),
                  child: SeparatedColumn(
                    separatorSize: DimensSizeV2.d16,
                    children: [
                      SeparatedRow(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _label(theme, LocaleKeys.amountWord.tr()),
                          SeparatedColumn(
                            separatorSize: DimensSizeV2.d4,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              AmountWidget.fromMoney(
                                amount: amountMoney,
                                icon: TonWalletIconWidget(
                                  path: iconPath,
                                  size: DimensSizeV2.d20,
                                ),
                              ),
                              if (!price.isZero)
                                AmountWidget.fromMoney(
                                  amount: amountMoney.exchangeToUSD(price),
                                  style: theme.textStyles.labelXSmall.copyWith(
                                    color: theme.colors.content3,
                                  ),
                                  sign: '~ ',
                                ),
                            ],
                          ),
                        ],
                      ),
                      if (attachedAmount != null)
                        SeparatedRow(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _label(theme, LocaleKeys.attachedAmount.tr()),
                            SeparatedColumn(
                              separatorSize: DimensSizeV2.d4,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                AmountWidget.fromMoney(
                                  amount: aaMoney,
                                  icon: TonWalletIconWidget(
                                    path: iconPath,
                                    size: DimensSizeV2.d20,
                                  ),
                                ),
                                if (!price.isZero)
                                  AmountWidget.fromMoney(
                                    amount: aaMoney.exchangeToUSD(price),
                                    style: theme.textStyles.labelXSmall.copyWith(
                                      color: theme.colors.content3,
                                    ),
                                    sign: '~ ',
                                  ),
                              ],
                            ),
                          ],
                        ),
                      SeparatedRow(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _label(theme, LocaleKeys.networkFee.tr()),
                          SeparatedColumn(
                            separatorSize: DimensSizeV2.d4,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              AmountWidget.fromMoney(
                                amount: feeMoney,
                                sign: '~ ',
                              ),
                              if (feeError != null)
                                _error(theme, feeError!),
                            ],
                          ),
                        ],
                      ),
                      SeparatedColumn(
                        separatorSize: DimensSizeV2.d4,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _label(theme, LocaleKeys.recipientWord.tr()),
                          _value(theme, recipient.address),
                        ],
                      ),
                      if (comment != null)
                        SeparatedColumn(
                          separatorSize: DimensSizeV2.d4,
                          children: [
                            _label(theme, LocaleKeys.commentWord.tr()),
                            _value(theme, comment!),
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        EnterPasswordWidgetV2(
          publicKey: publicKey,
          title: LocaleKeys.confirmTransaction.tr(),
          isLoading: isLoading,
          onPasswordEntered: (pwd) => bloc.add(TonWalletSendEvent.send(pwd)),
        ),
        const SizedBox(height: DimensSize.d16),
      ],
    );
  }

  Widget _label(ThemeStyleV2 theme, String text) => Text(text,
    style: theme.textStyles.labelSmall.copyWith(
      color: theme.colors.content3,
    ),
  );

  Widget _value(ThemeStyleV2 theme, String text) => Text(text,
    style: theme.textStyles.paragraphSmall.copyWith(
      color: theme.colors.content0,
    ),
  );

  Widget _hint(ThemeStyleV2 theme, String text) => Text(text,
    style: theme.textStyles.labelXSmall.copyWith(
      color: theme.colors.content3,
    ),
  );

  Widget _error(ThemeStyleV2 theme, String text) => Text(text,
    style: theme.textStyles.labelSmall.copyWith(
      color: theme.colors.negative,
    ),
  );
}

extension on Money {
  Money exchangeToUSD(Fixed price) => exchangeTo(
        ExchangeRate.fromFixed(
          price,
          fromCode: currency.code,
          toCode: 'USD',
          toScale: 2,
        ),
      );
}
