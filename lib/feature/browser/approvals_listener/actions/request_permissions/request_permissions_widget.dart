import 'package:app/data/models/models.dart';
import 'package:app/feature/browser/approvals_listener/actions/request_permissions/account_list_item.dart';
import 'package:app/feature/browser/approvals_listener/actions/request_permissions/request_permissions_wm.dart';
import 'package:app/feature/browser/approvals_listener/actions/widgets/widgets.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

import '../../../../wallet/widgets/select_account/select_account_data.dart';
import '../../../../wallet/widgets/select_account/widgets/private_key_item_widget.dart';
import '../../../../wallet/widgets/select_account/widgets/seed_phrase_item_widget.dart';

/// Widget that allows choose account that should be used for browser tab with
/// url=[origin].
/// This widget firstly asks to choose account via [_SelectAccountWidget]
/// and then opens [_ConfirmPermissionsWidget] to check permissions.
class RequestPermissionsWidget
    extends ElementaryWidget<RequestPermissionsWidgetModel> {
  const RequestPermissionsWidget({
    required this.origin,
    required this.permissions,
    required this.scrollController,
    required this.previousSelectedAccount,
    Key? key,
    WidgetModelFactory wmFactory = defaultRequestPermissionsWidgetModelFactory,
  }) : super(wmFactory, key: key);

  final Uri origin;
  final List<Permission> permissions;
  final ScrollController scrollController;
  final Address? previousSelectedAccount;

  @override
  Widget build(RequestPermissionsWidgetModel wm) => ValueListenableBuilder(
        valueListenable: wm.step,
        builder: (context, value, child) => switch (value) {
          RequestPermissionsStep.account =>
            _SelectAccountWidget(wm, scrollController),
          RequestPermissionsStep.confirm => _ConfirmPermissionsWidget(wm),
        },
      );
}

class _SelectAccountWidget extends StatelessWidget {
  const _SelectAccountWidget(this.wm, this.scrollController);

  final RequestPermissionsWidgetModel wm;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return SeparatedColumn(
      separatorSize: DimensSizeV2.d12,
      children: [
        Expanded(
          child: SeparatedColumn(
            separatorSize: DimensSizeV2.d12,
            children: [
              WebsiteInfoWidget(uri: wm.origin),
              PrimaryTextField(
                textEditingController: wm.searchController,
                hintText: LocaleKeys.searchWord.tr(),
                onChanged: (_) => wm.onSearch(),
                onSubmit: (_) => wm.onSearch(),
              ),
              Flexible(
                child: Container(
                  width: double.maxFinite,
                  child: DoubleSourceBuilder(
                    firstSource: wm.accounts,
                    secondSource: wm.selected,
                    builder: (_, list, selected) {
                      /*WidgetsBinding.instance.addPostFrameCallback((_) {
                        _scrollToActiveAccount(accounts, selected);
                      });*/
                      return SingleChildScrollView(
                        controller: scrollController,
                        physics: const ClampingScrollPhysics(),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: List.generate(
                            list?.length ?? 0,
                                (index) {
                              final data = list![index];
                              print("selected = ${selected}");
                              final isExpanded = data.hasCurrentAccount(selected);
                              print("isExpanded = $isExpanded");
                              return Padding(
                                padding: const EdgeInsets.only(bottom: DimensSizeV2.d8),
                                child: _SeedItem(
                                  data: data,
                                  isExpanded: isExpanded,
                                  key: ValueKey(data.name),
                                  currentAccount: selected,
                                  onTapAccount: (item) => wm
                                      .onSelectedChanged(item),
                                  getBalanceEntity: wm.getBalanceEntity,
                                  scrollController: scrollController,
                                ),
                              );
                            },
                          ),
                        ),
                      );
                      /*return ListView.separated(
                        controller: scrollController,
                        physics: const ClampingScrollPhysics(),
                        itemCount: accounts?.length ?? 0,
                        itemBuilder: (_, index) {
                          final account = accounts?[index];
                          return account == null
                              ? const SizedBox.shrink()
                              : AccountListItem(
                                  key: ValueKey(account.address),
                                  account: account,
                                  balance: wm.getBalanceEntity(account),
                                  active: account.address == selected?.address,
                                  onTap: () => wm.onSelectedChanged(account),
                                );
                        },
                        separatorBuilder: (_, __) => CommonDivider(
                          color: theme.colors.border0,
                        ),
                      );*/
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        StateNotifierBuilder(
          listenableState: wm.selected,
          builder: (_, value) => AccentButton(
            buttonShape: ButtonShape.pill,
            title: LocaleKeys.nextWord.tr(),
            onPressed: value != null ? wm.onNext : null,
          ),
        ),
      ],
    );
  }

  void _scrollToActiveAccount(
    List<KeyAccount>? accounts,
    KeyAccount? selected,
  ) {
    if (accounts != null && selected != null) {
      final index = accounts.indexWhere(
        (account) => account.address == selected.address,
      );

      if (index != -1) {
        scrollController.animateTo(
          index * DimensSizeV2.d72,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    }
  }
}

class _SeedItem extends StatefulWidget {
  const _SeedItem({
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
  State<_SeedItem> createState() => _SeedItemState();
}

class _SeedItemState extends State<_SeedItem> {
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

class _ConfirmPermissionsWidget extends StatelessWidget {
  const _ConfirmPermissionsWidget(this.wm);

  final RequestPermissionsWidgetModel wm;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    final account = wm.selected.value!;

    return SeparatedColumn(
      separatorSize: DimensSizeV2.d12,
      children: [
        Expanded(
          child: SingleChildScrollView(
            controller: wm.scrollController,
            child: SeparatedColumn(
              separatorSize: DimensSizeV2.d12,
              children: [
                AccountInfo(
                  account: account,
                  color: theme.colors.background2,
                ),
                WebsiteInfoWidget(uri: wm.origin),
                PrimaryCard(
                  color: theme.colors.background2,
                  borderRadius: BorderRadius.circular(DimensRadiusV2.radius12),
                  padding: const EdgeInsets.all(DimensSizeV2.d16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        LocaleKeys.requestedPermissions.tr(),
                        style: theme.textStyles.labelSmall.copyWith(
                          color: theme.colors.content3,
                        ),
                      ),
                      const SizedBox(height: DimensSizeV2.d16),
                      StateNotifierBuilder(
                        listenableState: wm.permissions,
                        builder: (_, value) {
                          final basic = value?.contains(Permission.basic);
                          final accountInteraction = value?.contains(
                            Permission.accountInteraction,
                          );

                          return SeparatedColumn(
                            separatorSize: DimensSizeV2.d12,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    LocaleKeys.basicInteractionType.tr(),
                                    style: theme.textStyles.labelSmall,
                                  ),
                                  const Spacer(),
                                  Switch(
                                    value: basic ?? false,
                                    onChanged: (value) => wm.onPermissionSwitch(
                                      permission: Permission.basic,
                                      checked: value,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    LocaleKeys.accountInteractionType.tr(),
                                    style: theme.textStyles.labelSmall,
                                  ),
                                  const Spacer(),
                                  Switch(
                                    value: accountInteraction ?? false,
                                    onChanged: (value) => wm.onPermissionSwitch(
                                      permission: Permission.accountInteraction,
                                      checked: value,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        AccentButton(
          buttonShape: ButtonShape.pill,
          title: LocaleKeys.allowWord.tr(),
          onPressed: wm.onConfirm,
        ),
      ],
    );
  }
}
