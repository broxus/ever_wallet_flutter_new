// ignore_for_file: inference_failure_on_function_return_type
// ignore_for_file: lines_longer_than_80_chars
import 'package:app/utils/utils.dart';
import 'package:app/widgets/widgets.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class PublicKeyItemWidget extends StatefulWidget {
  const PublicKeyItemWidget({
    required this.accounts,
    required this.currentAccount,
    required this.onTap,
    required this.getBalanceEntity,
    required this.scrollController,
    required this.isScrollToAccount,
    super.key,
  });

  final List<KeyAccount> accounts;
  final KeyAccount? currentAccount;
  final Function(KeyAccount) onTap;
  final ListenableState<Money?> Function(KeyAccount) getBalanceEntity;
  final ScrollController scrollController;
  final bool isScrollToAccount;

  @override
  State<PublicKeyItemWidget> createState() => _PublicKeyItemWidgetState();
}

class _PublicKeyItemWidgetState extends State<PublicKeyItemWidget> {
  late final itemKeys = <KeyAccount, GlobalKey>{
    for (final account in widget.accounts) account: GlobalKey(),
  };

  @override
  void initState() {
    super.initState();
    if (widget.isScrollToAccount) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToCurrentAccount(itemKeys);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return Column(
      children: [
        for (var i = 0; i < widget.accounts.length; i++)
          GestureDetector(
            key: itemKeys[widget.accounts[i]],
            onTap: () => widget.onTap(widget.accounts[i]),
            child: Container(
              decoration: BoxDecoration(
                color: widget.accounts[i] == widget.currentAccount
                    ? theme.colors.background3
                    : theme.colors.background2,
              ),
              padding: EdgeInsets.only(
                top: (i != 0 || widget.accounts[i] == widget.currentAccount)
                    ? DimensSizeV2.d12
                    : 0,
                bottom: (i < widget.accounts.length - 1 ||
                        widget.accounts[i] == widget.currentAccount)
                    ? DimensSizeV2.d12
                    : 0,
              ),
              child: Row(
                children: [
                  const SizedBox(width: DimensSizeV2.d24),
                  UserAvatar(
                    address: widget.accounts[i].address.address,
                    size: DimensSizeV2.d28,
                    borderRadius: DimensRadiusV2.radius6,
                  ),
                  const SizedBox(width: DimensSizeV2.d12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.accounts[i].name,
                        style: theme.textStyles.labelMedium,
                      ),
                      const SizedBox(height: DimensSizeV2.d4),
                      Row(
                        children: [
                          Text(
                            '${widget.accounts[i].address.toEllipseString()} • ',
                            style: theme.textStyles.labelXSmall.copyWith(
                              color: theme.colors.content3,
                            ),
                          ),
                          StateNotifierBuilder(
                            listenableState:
                                widget.getBalanceEntity(widget.accounts[i]),
                            builder: (_, balance) =>
                                widget.getBalanceEntity(widget.accounts[i]).let(
                                      (value) => value.value != null
                                          ? AmountWidget.fromMoney(
                                              amount: value.value!,
                                              style: theme
                                                  .textStyles.labelXSmall
                                                  .copyWith(
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
                  if (widget.accounts[i] == widget.currentAccount)
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
    if (widget.currentAccount == null ||
        !itemKeys.containsKey(widget.currentAccount)) {
      return;
    }

    final currentKey = itemKeys[widget.currentAccount]!;
    final context = currentKey.currentContext;

    final renderBox = context?.findRenderObject();
    if (renderBox is RenderBox) {
      final ancestorRenderObject = widget
          .scrollController.position.context.storageContext
          .findRenderObject();
      final offset = renderBox
          .localToGlobal(Offset.zero, ancestor: ancestorRenderObject)
          .dy;

      widget.scrollController.animateTo(
        offset - DimensSizeV2.d16,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      );
    }
  }
}
