import 'package:app/di/di.dart';
import 'package:app/feature/profile/profile.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/detail/details_item.dart';
import 'package:app/generated/generated.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

/// Widget, that displays base information for deploying wallet and let user
/// confirm transaction by entering password.
class WalletDeployConfirmView extends StatelessWidget {
  const WalletDeployConfirmView({
    required this.publicKey,
    this.balance,
    this.fee,
    this.feeError,
    this.custodians,
    this.requireConfirmations,
    super.key,
  });

  final BigInt? balance;
  final BigInt? fee;
  final String? feeError;
  final PublicKey publicKey;
  final List<PublicKey>? custodians;
  final int? requireConfirmations;

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
              padding: const EdgeInsets.symmetric(
                vertical: DimensSizeV2.d16,
                horizontal: DimensSizeV2.d16,
              ),
              color: theme.colors.background1,
              mainAxisSize: MainAxisSize.min,
              separator: const Padding(
                padding: EdgeInsets.symmetric(vertical: DimensSizeV2.d8),
                child: CommonDivider(),
              ),
              children: [
                Text(
                  LocaleKeys.fundsDebitedToDeploy.tr(),
                  style: theme.textStyles.labelMedium,
                ),
                WalletTransactionDetailsItem(
                  title: LocaleKeys.accountBalance.tr(),
                  valueWidget: AmountWidget.fromMoney(
                    amount: Money.fromBigIntWithCurrency(
                      balance ?? BigInt.zero,
                      Currencies()[inject<NekotonRepository>()
                          .currentTransport
                          .nativeTokenTicker]!,
                    ),
                  ),
                ),
                WalletTransactionDetailsItem(
                  title: LocaleKeys.networkFee.tr(),
                  valueWidget: AmountWidget.fromMoney(
                    amount: Money.fromBigIntWithCurrency(
                      fee ?? BigInt.zero,
                      Currencies()[inject<NekotonRepository>()
                          .currentTransport
                          .nativeTokenTicker]!,
                    ),
                    sign: '${LocaleKeys.approximatelySign.tr()} ',
                    useDefaultFormat: false,
                  ),
                  subtitle: feeError,
                  isSubtitleError: true,
                ),
                ...?custodians?.mapIndexed(
                  (index, e) => _info(
                    title: LocaleKeys.custodianNumber.tr(
                      args: [(index + 1).toString()],
                    ),
                    value: e.publicKey,
                  ),
                ),
                if (requireConfirmations != null)
                  _info(
                    title: LocaleKeys.requiredConfirms.tr(),
                    value: LocaleKeys.requireConfirmsCount.tr(
                      args: [
                        requireConfirmations!.toString(),
                        custodians!.length.toString(),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(DimensSize.d16),
          child: PrimaryButton(
            isLoading: isLoading,
            title: LocaleKeys.sendWord.tr(),
            onPressed: feeError != null || fee == null
                ? null
                : () {
                    showCommonBottomSheet<void>(
                      context: context,
                      title: LocaleKeys.enterPasswordTo.tr(
                        args: [LocaleKeys.deployWallet.tr().toLowerCase()],
                      ),
                      useAppBackgroundColor: true,
                      body: (_, __) => Builder(
                        builder: (c) {
                          return EnterPasswordWidget(
                            // ignore: prefer-extracting-callbacks
                            onPasswordEntered: (value) {
                              Navigator.of(c).pop();
                              context
                                  .read<WalletDeployBloc>()
                                  .add(WalletDeployEvent.confirmDeploy(value));
                            },
                            publicKey: publicKey,
                          );
                        },
                      ),
                    );
                  },
            buttonShape: ButtonShape.pill,
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
