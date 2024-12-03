// ignore_for_file: inference_failure_on_function_return_type
import 'package:app/utils/utils.dart';
import 'package:app/widgets/widgets.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class PublicKeyItemWidget extends StatelessWidget {
  const PublicKeyItemWidget({
    required this.accounts,
    required this.currentAccount,
    required this.onTap,
    required this.getBalanceEntity,
    required this.scrollController,
    super.key,
  });

  final List<KeyAccount> accounts;
  final KeyAccount? currentAccount;
  final Function(KeyAccount) onTap;
  final ListenableState<Money> Function(KeyAccount) getBalanceEntity;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    final itemKeys = <KeyAccount, GlobalKey>{
      for (final account in accounts) account: GlobalKey(),
    };

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToCurrentAccount(itemKeys);
    });

    return Column(
      children: [
        for (var i = 0; i < accounts.length; i++)
          GestureDetector(
            key: itemKeys[accounts[i]],
            onTap: () => onTap(accounts[i]),
            child: Container(
              decoration: BoxDecoration(
                color: accounts[i] == currentAccount
                    ? theme.colors.background3
                    : theme.colors.background2,
              ),
              padding: EdgeInsets.only(
                top: (i != 0 || accounts[i] == currentAccount)
                    ? DimensSizeV2.d12
                    : 0,
                bottom:
                    (i < accounts.length - 1 || accounts[i] == currentAccount)
                        ? DimensSizeV2.d12
                        : 0,
              ),
              child: Row(
                children: [
                  const SizedBox(width: DimensSizeV2.d24),
                  UserAvatar(
                    address: accounts[i].address.address,
                    size: DimensSizeV2.d28,
                    borderRadius: DimensRadiusV2.radius6,
                  ),
                  const SizedBox(width: DimensSizeV2.d12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        accounts[i].name,
                        style: theme.textStyles.labelMedium,
                      ),
                      const SizedBox(height: DimensSizeV2.d4),
                      Row(
                        children: [
                          Text(
                            '${accounts[i].address.toEllipseString()} • ',
                            style: theme.textStyles.labelXSmall.copyWith(
                              color: theme.colors.content3,
                            ),
                          ),
                          StateNotifierBuilder(
                            listenableState: getBalanceEntity(accounts[i]),
                            builder: (_, balance) =>
                                getBalanceEntity(accounts[i]).let(
                              (value) => value.value != null
                                  ? AmountWidget.fromMoney(
                                      amount: value.value!,
                                      style:
                                          theme.textStyles.labelXSmall.copyWith(
                                        color: theme.colors.content3,
                                      ),
                                    )
                                  : ProgressIndicatorWidget(
                                      size: DimensSizeV2.d16,
                                      color: theme.colors.content3,
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                  if (accounts[i] == currentAccount)
                    Padding(
                      padding: const EdgeInsets.only(right: DimensSizeV2.d16),
                      child: Icon(
                        LucideIcons.check,
                        size: DimensSizeV2.d20,
                        color: theme.colors.content0,
                      ),
                    ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  void _scrollToCurrentAccount(Map<KeyAccount, GlobalKey> itemKeys) {
    if (currentAccount == null || !itemKeys.containsKey(currentAccount)) {
      return;
    }

    final currentKey = itemKeys[currentAccount]!;
    final context = currentKey.currentContext;

    if (context?.findRenderObject() is RenderBox) {
      final renderBox = context!.findRenderObject()! as RenderBox;
      final offset = renderBox.localToGlobal(Offset.zero);
      final scrollOffset = scrollController.offset + offset.dy;

      scrollController.animateTo(
        scrollOffset,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeInOut,
      );
    }
  }
}
