import 'package:app/feature/wallet/widgets/select_account/select_account_data.dart';
import 'package:app/feature/wallet/widgets/select_account/select_account_wm.dart';
import 'package:app/feature/wallet/widgets/select_account/widgets/private_key_item_widget.dart';
import 'package:app/feature/wallet/widgets/select_account/widgets/seed_phrase_item_widget.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
import 'package:app/widgets/user_avatar/user_avatar.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class SelectAccountWidget extends ElementaryWidget<SelectAccountWidgetModel> {
  const SelectAccountWidget({
    required this.scrollController,
    Key? key,
    WidgetModelFactory wmFactory = defaultSelectAccountWidgetModelFactory,
  }) : super(wmFactory, key: key);

  final ScrollController scrollController;

  @override
  Widget build(SelectAccountWidgetModel wm) {
    return Column(
      children: [
        PrimaryTextField(
          textEditingController: wm.searchController,
          hintText: LocaleKeys.searchWord.tr(),
          onChanged: (_) => wm.onSearch(),
          onSubmit: (_) => wm.onSearch(),
        ),
        const SizedBox(height: DimensSizeV2.d24),
        Expanded(
          child: DoubleSourceBuilder(
            firstSource: wm.list,
            secondSource: wm.currentAccount,
            builder: (_, list, currentAccount) => ListView.separated(
              itemCount: list?.length ?? 0,
              separatorBuilder: (_, __) =>
                  const SizedBox(height: DimensSizeV2.d8),
              itemBuilder: (_, index) => list?.let(
                (list) {
                  final data = list[index];
                  return _SeedItem(
                    data: data,
                    isExpanded: data.hasCurrentAccount(currentAccount),
                    key: ValueKey(data),
                    currentAccount: currentAccount,
                    onTapAccount: (item) => wm.onSelect(item),
                    getBalanceEntity: wm.getBalanceEntity,
                  );
                },
              ),
            ),
          ),
        ),
        const SizedBox(height: DimensSizeV2.d16),
        SeparatedColumn(
          children: [
            AccentButton(
              buttonShape: ButtonShape.pill,
              title: LocaleKeys.addAccount.tr(),
              postfixIcon: LucideIcons.plus,
              onPressed: wm.onAddAccount,
            ),
            PrimaryButton(
              buttonShape: ButtonShape.pill,
              title: LocaleKeys.manageSeedsAndAccounts.tr(),
              onPressed: wm.onManageSeedsAndAccounts,
            ),
          ],
        ),
      ],
    );
  }
}

class _SeedItem extends StatefulWidget {
  const _SeedItem({
    required this.data,
    required this.isExpanded,
    required this.currentAccount,
    required this.onTapAccount,
    required this.getBalanceEntity,
    super.key,
  });

  final SelectAccountData data;
  final bool isExpanded;
  final KeyAccount? currentAccount;
  final Function(KeyAccount) onTapAccount;
  final ListenableState<Money> Function(KeyAccount) getBalanceEntity;

  @override
  State<_SeedItem> createState() => _SeedItemState();
}

class _SeedItemState extends State<_SeedItem> {
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.isExpanded;
  }

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

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
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
    /*
    final address = account.address.toEllipseString();
    final pk = account.publicKey.toEllipseString();
    final textStyle = theme.textStyles.labelXSmall.copyWith(
      color: theme.colors.content3,
    );

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: DimensSizeV2.d12),
        child: SeparatedRow(
          children: [
            UserAvatar(
              address: account.address.address,
            ),
            Expanded(
              child: SeparatedColumn(
                separatorSize: DimensSizeV2.d4,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    account.name,
                    style: theme.textStyles.labelMedium,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    maxLines: 1,
                  ),
                  Row(
                    children: [
                      Text('$address • $pk • ', style: textStyle),
                      StateNotifierBuilder(
                        listenableState: balance,
                        builder: (_, balance) =>
                            balance?.let(
                              (value) => Expanded(
                                child: AmountWidget.fromMoney(
                                  amount: balance,
                                  style: textStyle,
                                ),
                              ),
                            ) ??
                            ProgressIndicatorWidget(
                              size: DimensSizeV2.d16,
                              color: theme.colors.content3,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (active) const Icon(LucideIcons.check, size: DimensSizeV2.d20),
          ],
        ),
      ),
    );*/
  }
}
