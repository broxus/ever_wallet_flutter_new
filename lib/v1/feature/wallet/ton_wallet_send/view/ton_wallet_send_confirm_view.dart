import 'package:app/di/di.dart';
import 'package:app/feature/profile/profile.dart';
import 'package:app/v1/feature/wallet/ton_wallet_send/bloc/ton_wallet_send_bloc.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

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
    final isLoading = fee == null && feeError == null;

    return SeparatedColumn(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: ShapedContainerColumn(
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
                if (attachedAmount != null)
                  _info(
                    title: LocaleKeys.attachedAmount.tr(),
                    valueChild: MoneyWidget(
                      money: Money.fromBigIntWithCurrency(
                        attachedAmount!,
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
          padding: const EdgeInsets.all(DimensSize.d16),
          child: CommonButton.primary(
            fillWidth: true,
            isLoading: isLoading,
            text: LocaleKeys.sendWord.tr(),
            onPressed: feeError != null || fee == null
                ? null
                : () {
                    showCommonBottomSheet<void>(
                      context: context,
                      title: LocaleKeys.enterPasswordTo.tr(
                        args: [LocaleKeys.sendYourFunds.tr().toLowerCase()],
                      ),
                      useAppBackgroundColor: true,
                      body: (_, __) => Builder(
                        builder: (c) {
                          return EnterPasswordWidget(
                            // ignore: prefer-extracting-callbacks
                            onPasswordEntered: (value) {
                              Navigator.of(c).pop();
                              context
                                  .read<TonWalletSendBloc>()
                                  .add(TonWalletSendEvent.send(value));
                            },
                            publicKey: publicKey,
                          );
                        },
                      ),
                    );
                  },
          ),
        ),
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
        final colors = context.themeStyle.colors;

        return SeparatedColumn(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: StyleRes.addRegular.copyWith(color: colors.textSecondary),
            ),
            if (value != null)
              Text(
                value,
                style: StyleRes.primaryBold.copyWith(
                  color: colors.textPrimary,
                ),
              ),
            if (valueChild != null) valueChild,
            if (subtitleError != null)
              Text(
                subtitleError,
                style: StyleRes.addRegular.copyWith(color: colors.alert),
              ),
          ],
        );
      },
    );
  }
}
