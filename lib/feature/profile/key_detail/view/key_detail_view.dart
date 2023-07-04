import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/profile/profile.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:ui_components_lib/ui_components_lib.dart';

class KeyDetailView extends StatelessWidget {
  KeyDetailView({
    required this.seedName,
    required this.seedKey,
    required this.tab,
    super.key,
  });

  final String seedName;
  final SeedKey seedKey;
  final KeyDetailAccountsTab tab;

  late final accountTabItems = [
    CommonTabSwitcherItem(
      title: LocaleKeys.myAccounts.tr(),
      value: KeyDetailAccountsTab.local,
    ),
    CommonTabSwitcherItem(
      title: LocaleKeys.externalAccounts.tr(),
      value: KeyDetailAccountsTab.external,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyle.colors;

    final currentAccounts = tab == KeyDetailAccountsTab.local
        ? seedKey.accountList.localAccounts
        : seedKey.accountList.externalAccounts;

    return SeparatedColumn(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: SeparatedColumn(
              separatorSize: DimensSize.d16,
              children: [
                SeparatedColumn(
                  separatorSize: DimensSize.d4,
                  children: [
                    Text(
                      LocaleKeys.publicKey.tr(),
                      style: StyleRes.addRegular
                          .copyWith(color: colors.textSecondary),
                    ),
                    Text(
                      seedKey.name,
                      style: StyleRes.h1.copyWith(color: colors.textPrimary),
                    ),
                  ],
                ),
                ShapedContainerColumn(
                  separatorSize: DimensSize.d16,
                  children: [
                    _headerItem(
                      title: LocaleKeys.currentSeed.tr(),
                      subtitle: seedName,
                    ),
                    const CommonDivider(),
                    _headerItem(
                      title: LocaleKeys.publicKey.tr(),
                      subtitle: seedKey.publicKey.publicKey,
                      isPrimary: false,
                      action: CommonIconButton.svg(
                        svg: Assets.images.copy.path,
                        buttonType: EverButtonType.ghost,
                        outerPadding: EdgeInsets.zero,
                        innerPadding: const EdgeInsets.all(DimensSize.d4),
                        color: colors.textSecondary,
                        onPressed: () {
                          Clipboard.setData(
                            ClipboardData(text: seedKey.publicKey.publicKey),
                          );
                          inject<MessengerService>().show(
                            Message.successful(
                              message: LocaleKeys.valueCopiedExclamation.tr(
                                args: [seedKey.publicKey.toEllipseString()],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                ShapedContainerColumn(
                  mainAxisSize: MainAxisSize.min,
                  separatorSize: DimensSize.d16,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CommonTabSwitcher(
                      onTabChanged: context.read<KeyDetailCubit>().changeTab,
                      values: accountTabItems,
                      currentValue: tab,
                    ),
                    if (currentAccounts.isEmpty)
                      Text(
                        LocaleKeys.noAccountsYet.tr(),
                        style: StyleRes.addRegular.copyWith(
                          color: colors.textSecondary,
                        ),
                      )
                    else
                      SeparatedColumn(
                        separator: const Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: DimensSize.d16,
                          ),
                          child: CommonDivider(),
                        ),
                        children: currentAccounts.map(_accountItem).toList(),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: DimensSize.d16),
          child: CommonButton.primary(
            fillWidth: true,
            leading: CommonButtonIconWidget.svg(svg: Assets.images.plus.path),
            text: LocaleKeys.addNewAccount.tr(),
            onPressed: () {
              switch (tab) {
                case KeyDetailAccountsTab.local:
                  showAddNewLocalAccountSheet(
                    context: context,
                    publicKey: seedKey.publicKey,
                  );
                case KeyDetailAccountsTab.external:
                  showAddNewExternalAccountSheet(
                    context: context,
                    publicKey: seedKey.publicKey,
                  );
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _headerItem({
    required String title,
    required String subtitle,
    bool isPrimary = true,
    Widget? action,
  }) {
    return Builder(
      builder: (context) {
        final colors = context.themeStyle.colors;

        return SeparatedColumn(
          separatorSize: DimensSize.d4,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonListTile(
              height: null,
              titleChild: Text(
                title,
                style:
                    StyleRes.addRegular.copyWith(color: colors.textSecondary),
              ),
              subtitleChild: Text(
                subtitle,
                style: (isPrimary ? StyleRes.primaryBold : StyleRes.addBold)
                    .copyWith(
                  color: colors.textPrimary,
                ),
              ),
              trailing: action,
              backgroundColor: Colors.transparent,
            ),
          ],
        );
      },
    );
  }

  Widget _accountItem(KeyAccount account) {
    return Builder(
      builder: (context) {
        final colors = context.themeStyle.colors;

        return CommonListTile(
          padding: EdgeInsets.zero,
          leading: CommonBackgroundedIconWidget.svg(
            svg: Assets.images.person.path,
          ),
          titleText: account.name,
          subtitleText: account.address.toEllipseString(),
          trailing: SeparatedRow(
            separatorSize: DimensSize.d4,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (account.isHidden)
                CommonIconWidget.svg(svg: Assets.images.closedEye.path),
              CommonIconButton.svg(
                svg: Assets.images.settings.path,
                buttonType: EverButtonType.ghost,
                color: colors.textSecondary,
                innerPadding: const EdgeInsets.all(DimensSize.d8),
                onPressed: () => showAccountSettingsSheet(
                  context: context,
                  address: account.address,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
