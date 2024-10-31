// ignore_for_file: inference_failure_on_function_return_type
import 'package:app/feature/wallet/widgets/select_account/select_account_data.dart';
import 'package:app/feature/wallet/widgets/select_account/widgets/public_key_item_widget.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class PrivateKeyItemWidget extends StatelessWidget {
  const PrivateKeyItemWidget({
    required this.seedWithInfo,
    required this.currentAccount,
    required this.onTap,
    required this.getBalanceEntity,
    super.key,
  });

  final List<SeedWithInfo> seedWithInfo;
  final KeyAccount? currentAccount;
  final Function(KeyAccount) onTap;
  final ListenableState<Money> Function(KeyAccount) getBalanceEntity;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    return Column(
      children: [
        for (final privateKey in seedWithInfo)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: DimensSize.d12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const SizedBox(width: DimensSizeV2.d16),
                    Icon(
                      LucideIcons.keyRound,
                      color: theme.colors.content0,
                      size: DimensSizeV2.d20,
                    ),
                    const SizedBox(width: DimensSizeV2.d12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  privateKey.keyName,
                                  style: theme.textStyles.labelMedium,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: DimensSizeV2.d4),
                          Text(
                            privateKey.key,
                            style: theme.textStyles.labelXSmall.copyWith(
                              color: theme.colors.content3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: DimensSizeV2.d12),
                PublicKeyItemWidget(
                  accounts: privateKey.accounts,
                  currentAccount: currentAccount,
                  onTap: onTap,
                  getBalanceEntity: getBalanceEntity,
                ),
              ],
            ),
          ),
      ],
    );
  }
}
