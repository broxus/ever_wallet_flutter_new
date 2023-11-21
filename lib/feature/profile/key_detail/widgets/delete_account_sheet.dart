import 'package:app/di/di.dart';
import 'package:app/feature/profile/profile.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Helper method that shows the [DeleteAccountSheet] bottom sheet.
ModalRoute<void> deleteAccountSheetRoute(KeyAccount account) {
  final name = inject<NekotonRepository>()
      .currentTransport
      .defaultAccountName(account.account.tonWallet.contract);

  return commonBottomSheetRoute<void>(
    title: LocaleKeys.deleteAccountWithName.tr(args: [name.toUpperCase()]),
    subtitle: LocaleKeys.deleteAccountDescription.tr(),
    useAppBackgroundColor: true,
    body: (_, __) => DeleteAccountSheet(account: account),
  );
}

/// Widget that allows to delete account.
class DeleteAccountSheet extends StatelessWidget {
  const DeleteAccountSheet({
    required this.account,
    super.key,
  });

  /// Account that should be deleted
  final KeyAccount account;

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyle.colors;

    return SeparatedColumn(
      mainAxisSize: MainAxisSize.min,
      children: [
        ShapedContainerColumn(
          margin: EdgeInsets.zero,
          mainAxisSize: MainAxisSize.min,
          separator: const CommonDivider(),
          children: [
            BlocProvider<AccountDetailCubit>(
              create: (_) => AccountDetailCubit(
                address: account.address,
                nekotonRepository: inject<NekotonRepository>(),
                balanceService: inject(),
                convertService: inject(),
                currentAccountsService: inject(),
              )..init(),
              child: BlocBuilder<AccountDetailCubit, AccountDetailState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () => CommonListTile(
                      titleText: LocaleKeys.totalBalance.tr(),
                      subtitleChild: const CommonLoader(
                        width: DimensSize.d64,
                        height: DimensSize.d24,
                      ),
                      padding: EdgeInsets.zero,
                    ),
                    data: (account, balance, _) {
                      return CommonListTile(
                        invertTitleSubtitleStyles: true,
                        titleText: LocaleKeys.totalBalance.tr(),
                        subtitleChild: MoneyWidget(
                          money: balance,
                          style: MoneyWidgetStyle.primary,
                        ),
                        padding: EdgeInsets.zero,
                      );
                    },
                  );
                },
              ),
            ),
            CommonListTile(
              invertTitleSubtitleStyles: true,
              titleText: LocaleKeys.addressWord.tr(),
              subtitleText: account.address.address,
              padding: EdgeInsets.zero,
            ),
          ],
        ),
        const SizedBox(height: DimensSize.d8),
        CommonButton(
          buttonType: EverButtonType.secondary,
          contentColor: colors.alert,
          text: LocaleKeys.deleteWord.tr(),
          onPressed: () {
            Navigator.of(context).pop();
            account.remove();
          },
        ),
        CommonButton.primary(
          fillWidth: true,
          text: LocaleKeys.cancelWord.tr(),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}
