// ignore_for_file: inference_failure_on_function_return_type
import 'package:app/feature/wallet/widgets/select_account'
    '/select_account_data.dart';
import 'package:app/feature/wallet/widgets/select_account/widgets/private_key_item_widget.dart';
import 'package:app/feature/wallet/widgets/select_account/widgets/seed_phrase_item_widget.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class SeedItem extends StatefulWidget {
  const SeedItem({
    required this.data,
    required this.isExpanded,
    required this.currentAccount,
    required this.onTapAccount,
    required this.getBalanceEntity,
    required this.scrollController,
    super.key,
  });

  final SelectAccountData data;
  final bool isExpanded;
  final KeyAccount? currentAccount;
  final Function(KeyAccount) onTapAccount;
  final ListenableState<Money?> Function(KeyAccount) getBalanceEntity;
  final ScrollController scrollController;

  @override
  State<SeedItem> createState() => SeedItemState();
}

class SeedItemState extends State<SeedItem> {
  late bool _isExpanded = widget.isExpanded;
  late bool _isScrollToAccount = true;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    return GestureDetector(
      onTap: _toggleExpand,
      child: Container(
        padding: EdgeInsets.only(
          top: DimensSizeV2.d16,
          bottom: _isExpanded ? 0 : DimensSize.d16,
        ),
        decoration: BoxDecoration(
          color: theme.colors.background2,
          borderRadius: BorderRadius.circular(DimensRadiusV2.radius12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SeedPhraseItemWidget(
              name: widget.data.name,
              isExpanded: _isExpanded,
            ),
            if (_isExpanded) const SizedBox(height: DimensSizeV2.d16),
            if (_isExpanded) const CommonDivider(),
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: _isExpanded
                  ? PrivateKeyItemWidget(
                      seedWithInfo: widget.data.privateKeys,
                      currentAccount: widget.currentAccount,
                      onTap: widget.onTapAccount,
                      getBalanceEntity: widget.getBalanceEntity,
                      scrollController: widget.scrollController,
                      isScrollToAccount: _isScrollToAccount,
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }

  void _toggleExpand() {
    if (!_isExpanded && _isScrollToAccount) {
      _isScrollToAccount = false;
    }
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }
}
