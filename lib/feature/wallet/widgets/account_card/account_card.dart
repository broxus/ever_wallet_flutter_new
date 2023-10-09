import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/profile/profile.dart';
import 'package:app/feature/wallet/widgets/account_card/account_card_cubit.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:ui_components_lib/ui_components_lib.dart';

/// Card widget that displays information about account.
class AccountCard extends StatelessWidget {
  const AccountCard({
    required this.account,
    required this.height,
    super.key,
  });

  final KeyAccount account;

  /// Height of card, just to sync with 'AddNewAccountCard'
  final double height;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AccountCardCubit(
        inject<NekotonRepository>(),
        account,
        inject<BalanceService>(),
        inject<CurrencyConvertService>(),
      ),
      child: BlocBuilder<AccountCardCubit, AccountCardState>(
        builder: (context, state) {
          return state.when<Widget>(
            data: (account, walletName, balance, custodians) {
              return ShapedContainerColumn(
                squircleRadius: DimensRadius.large,
                height: height,
                width: double.infinity,
                margin: EdgeInsets.zero,
                padding: EdgeInsets.zero,
                separator: const CommonDivider(),
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _walletDescriptionTile(walletName, custodians),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: DimensSize.d16,
                            ),
                            child: Center(
                              child: balance == null
                                  ? const SizedBox.shrink()
                                  : MoneyWidget(
                                      money: balance,
                                      style: MoneyWidgetStyle.primary,
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  _addressTile(),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget _addressTile() {
    return Builder(
      builder: (context) {
        final colors = context.themeStyle.colors;

        return CommonListTile(
          height: DimensSize.d64,
          padding: const EdgeInsets.symmetric(
            horizontal: DimensSize.d16,
            vertical: DimensSize.d8,
          ),
          contentColor: colors.blue,
          titleChild: Text(
            LocaleKeys.addressWord.tr(),
            style: StyleRes.addRegular.copyWith(color: colors.blueSecond),
          ),
          subtitleChild: Text(
            account.address.toEllipseString(),
            style: StyleRes.addBold.copyWith(color: colors.blue),
          ),
          trailing: CommonIconWidget.svg(svg: Assets.images.copy.path),
          onPressed: () {
            Clipboard.setData(
              ClipboardData(text: account.address.address),
            );
            inject<MessengerService>().show(
              Message.successful(
                message: LocaleKeys.valueCopiedExclamation.tr(
                  args: [account.address.toEllipseString()],
                ),
              ),
            );
          },
        );
      },
    );
  }

  // ignore: long-method
  Widget _walletDescriptionTile(String walletName, String? custodians) {
    return Builder(
      builder: (context) {
        final colors = context.themeStyle.colors;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                      horizontal: DimensSize.d16,
                    ) +
                    const EdgeInsets.only(top: DimensSize.d16),
                child: SeparatedColumn(
                  separatorSize: DimensSize.d4,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      account.name,
                      style:
                          StyleRes.button.copyWith(color: colors.textPrimary),
                    ),
                    SeparatedRow(
                      separatorSize: DimensSize.d4,
                      children: [
                        CommonIconWidget.svg(
                          svg: Assets.images.accountType.path,
                          color: colors.textSecondary,
                        ),
                        Text(
                          walletName,
                          style: StyleRes.addRegular.copyWith(
                            color: colors.textSecondary,
                          ),
                        ),
                        if (custodians != null) ...[
                          const SizedBox(width: DimensSize.d12),
                          CommonIconWidget.svg(
                            svg: Assets.images.persons.path,
                            color: colors.textSecondary,
                          ),
                          const SizedBox(width: DimensSize.d4),
                          Text(
                            custodians,
                            style: StyleRes.addRegular
                                .copyWith(color: colors.textSecondary),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(DimensSize.d4),
              child: CommonIconButton.svg(
                svg: Assets.images.settings.path,
                buttonType: EverButtonType.ghost,
                color: colors.textSecondary,
                size: CommonIconButtonSize.small,
                onPressed: () => showAccountSettingsSheet(
                  context: context,
                  address: account.address,
                  showHiding: false,
                  seeInExplorer: true,
                  showCopyAddress: true,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
