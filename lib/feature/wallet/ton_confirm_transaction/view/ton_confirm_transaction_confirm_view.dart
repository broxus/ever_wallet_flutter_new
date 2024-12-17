import 'package:app/di/di.dart';
import 'package:app/feature/profile/profile.dart';
import 'package:app/feature/wallet/ton_confirm_transaction/bloc/bloc.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

/// View that allows confirm confirming transaction transaction by entering
/// password
class TonWalletConfirmTransactionConfirmView extends StatelessWidget {
  const TonWalletConfirmTransactionConfirmView({
    required this.recipient,
    required this.amount,
    required this.comment,
    required this.publicKey,
    this.fee,
    this.feeError,
    super.key,
  });

  final Address recipient;
  final BigInt amount;
  final BigInt? fee;
  final String? comment;

  final String? feeError;

  final PublicKey publicKey;

  @override
  Widget build(BuildContext context) {
    final isLoading = fee == null && feeError == null;
    final theme = context.themeStyleV2;

    return SeparatedColumn(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: ShapedContainerColumn(
              color: theme.colors.background1,
              mainAxisSize: MainAxisSize.min,
              separator: const Padding(
                padding: EdgeInsets.symmetric(vertical: DimensSize.d8),
                child: CommonDivider(),
              ),
              children: [
                _info(
                  title: LocaleKeys.recipientWord.tr(),
                  value: recipient.address,
                ),
                _info(
                  title: LocaleKeys.amountWord.tr(),
                  valueChild: MoneyWidget(
                    money: Money.fromBigIntWithCurrency(
                      amount,
                      Currencies()[inject<NekotonRepository>()
                          .currentTransport
                          .nativeTokenTicker]!,
                    ),
                    style: MoneyWidgetStyle.primary,
                  ),
                ),
                _info(
                  title: LocaleKeys.blockchainFee.tr(),
                  valueChild: MoneyWidget(
                    money: Money.fromBigIntWithCurrency(
                      fee ?? BigInt.zero,
                      Currencies()[inject<NekotonRepository>()
                          .currentTransport
                          .nativeTokenTicker]!,
                    ),
                    signValue: '~',
                    style: MoneyWidgetStyle.primary,
                  ),
                  subtitleError: feeError,
                ),
                if (comment != null)
                  _info(
                    title: LocaleKeys.commentWord.tr(),
                    value: comment,
                  ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: DimensSizeV2.d16),
          child: EnterPasswordWidgetV2(
            publicKey: publicKey,
            title: LocaleKeys.confirm.tr(),
            isLoading: isLoading,
            isDisabled: feeError != null || fee == null,
              onPasswordEntered: (value) {
                Navigator.of(context).pop();
                context
                    .read<TonConfirmTransactionBloc>()
                    .add(TonConfirmTransactionEvent.send(value));
              },
          ),
        ),
        const SizedBox(height: DimensSize.d16),
      ],
    );
  }

  Widget _info({
    required String title,
    String? value,
    Widget? valueChild,
    String? subtitleError,
  }) {
    return Builder(
      builder: (context) {
        final theme = context.themeStyleV2;

        return SeparatedColumn(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: theme.textStyles.labelXSmall
                  .copyWith(color: theme.colors.content2),
            ),
            if (value != null)
              Text(
                value,
                style: theme.textStyles.paragraphSmall
                    .copyWith(color: theme.colors.content0),
              ),
            if (valueChild != null) valueChild,
            if (subtitleError != null)
              Text(
                subtitleError,
                style: theme.textStyles.paragraphXSmall
                    .copyWith(color: theme.colors.contentNegative),
              ),
          ],
        );
      },
    );
  }
}
