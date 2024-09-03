import 'package:app/feature/wallet/add_account/add_account_confirm/add_new_account_confirm_sheet.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

/// This is a helper method to display AddNewAccountSheet.
Future<void> showAddNewAccountSheet({
  required BuildContext context,
  required PublicKey publicKey,
}) {
  return showCommonBottomSheet(
    context: context,
    title: LocaleKeys.addNewAccount.tr(),
    centerTitle: true,
    body: (_, __) => AddNewAccountSheet(
      publicKey: publicKey,
    ),
  );
}

class AddNewAccountSheet extends StatelessWidget {
  const AddNewAccountSheet({
    required this.publicKey,
    super.key,
  });

  final PublicKey publicKey;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return PrimaryCard(
      color: theme.colors.background2,
      borderRadius: BorderRadius.circular(DimensRadiusV2.radius16),
      padding: EdgeInsets.zero,
      margin: const EdgeInsets.only(top: DimensSizeV2.d16),
      child: SeparatedColumn(
        mainAxisSize: MainAxisSize.min,
        separator: const CommonDivider(),
        children: [
          GestureDetector(
            onTap: () => _addLocal(context),
            behavior: HitTestBehavior.translucent,
            child: SizedBox(
              height: DimensSizeV2.d64,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: DimensSizeV2.d16,
                ),
                child: SeparatedRow(
                  separatorSize: DimensSizeV2.d12,
                  children: [
                    const Icon(LucideIcons.plus, size: DimensSizeV2.d20),
                    Expanded(
                      child: Text(
                        LocaleKeys.createNewAccount.tr(),
                        style: theme.textStyles.labelMedium,
                      ),
                    ),
                    const Icon(
                      LucideIcons.chevronRight,
                      size: DimensSizeV2.d20,
                    ),
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            child: SizedBox(
              height: DimensSizeV2.d64,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: DimensSizeV2.d16,
                ),
                child: SeparatedRow(
                  separatorSize: DimensSizeV2.d12,
                  children: [
                    Icon(
                      LucideIcons.import,
                      size: DimensSizeV2.d20,
                      color: theme.colors.content0.withOpacity(0.2),
                    ),
                    Expanded(
                      child: Text(
                        LocaleKeys.addExternalAccount.tr(),
                        style: theme.textStyles.labelMedium.copyWith(
                          color: theme.colors.content0.withOpacity(0.2),
                        ),
                      ),
                    ),
                    Icon(
                      LucideIcons.chevronRight,
                      size: DimensSizeV2.d20,
                      color: theme.colors.content0.withOpacity(0.2),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _addLocal(BuildContext context) {
    Navigator.of(context).pop();
    showAddAccountConfirmSheet(
      context: context,
      publicKey: publicKey,
    );
  }
}
