import 'package:app/di/di.dart';
import 'package:app/feature/profile/profile.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

/// Helper method that shows the [DeleteAccountSheet] bottom sheet.
ModalRoute<void> deleteAccountSheetRoute(
  BuildContext context,
  KeyAccount account,
) {
  final name = inject<NekotonRepository>()
      .currentTransport
      .defaultAccountName(account.account.tonWallet.contract);

  return commonBottomSheetRoute<void>(
    titleTextStyle: context.themeStyleV2.textStyles.headingLarge,
    title: LocaleKeys.deleteAccountWithName.tr(args: [name.toUpperCase()]),
    subtitle: LocaleKeys.deleteAccountDescription.tr(),
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
    final colors = context.themeStyleV2.colors;

    return SeparatedColumn(
      mainAxisSize: MainAxisSize.min,
      children: [
        ShapedContainerColumn(
          margin: EdgeInsets.zero,
          color: colors.background2,
          mainAxisSize: MainAxisSize.min,
          separator: const CommonDivider(),
          children: [
            BlocProvider<AccountDetailCubit>(
              create: (_) => AccountDetailCubit(
                address: account.address,
                nekotonRepository: inject<NekotonRepository>(),
                balanceService: inject(),
                convertService: inject(),
              )..init(),
              child: BlocBuilder<AccountDetailCubit, AccountDetailState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () => CommonListTile(
                      titleText: LocaleKeys.totalBalance.tr(),
                      subtitleChild: const CommonLoader(
                        width: DimensSizeV2.d64,
                        height: DimensSizeV2.d24,
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
              height: DimensSizeV2.d80,
              invertTitleSubtitleStyles: true,
              subtitleChild: Text(account.address.address),
              titleText: LocaleKeys.addressWord.tr(),
              subtitleText: account.address.address,
              padding: EdgeInsets.zero,
            ),
          ],
        ),
        const SizedBox(height: DimensSizeV2.d8),
        DestructiveButton(
          buttonShape: ButtonShape.pill,
          title: LocaleKeys.deleteWord.tr(),
          onPressed: () {
            Navigator.of(context).pop();
            account.remove();
          },
        ),
        PrimaryButton(
          buttonShape: ButtonShape.pill,
          title: LocaleKeys.cancelWord.tr(),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}
