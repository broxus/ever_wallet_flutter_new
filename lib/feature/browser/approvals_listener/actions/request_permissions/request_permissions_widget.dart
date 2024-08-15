import 'package:app/data/models/models.dart';
import 'package:app/feature/browser/approvals_listener/actions/request_permissions/account_list_item/account_list_item.dart';
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
          RequestPermissionsStep.account => _SelectAccountWidget(wm),
          RequestPermissionsStep.confirm => _ConfirmPermissionsWidget(wm),
        },
      );
}

class _SelectAccountWidget extends StatelessWidget {
  const _SelectAccountWidget(this.wm);

  final RequestPermissionsWidgetModel wm;

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
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    border: Border.all(color: theme.colors.border1),
                    borderRadius: BorderRadius.circular(
                      DimensRadiusV2.radius12,
                    ),
                    color: theme.colors.background1,
                  ),
                  child: DoubleSourceBuilder(
                    firstSource: wm.accounts,
                    secondSource: wm.selected,
                    builder: (_, accounts, selected) => ListView.separated(
                      shrinkWrap: true,
                      itemCount: accounts?.length ?? 0,
                      itemBuilder: (_, index) {
                        final account = accounts?[index];
                        return account == null
                            ? const SizedBox.shrink()
                            : AccountListItemWidget(
                                key: ValueKey(account.address),
                                account: account,
                                active: account.address == selected?.address,
                                onTap: () => wm.onSelectedChanged(account),
                              );
                      },
                      separatorBuilder: (_, __) => CommonDivider(
                        color: theme.colors.border0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        AccentButton(
          buttonShape: ButtonShape.pill,
          title: LocaleKeys.nextWord.tr(),
          onPressed: wm.onNext,
        ),
      ],
    );
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
                                  // TODO(Komarov): custom switch.
                                  Switch(
                                    activeColor: theme.colors.primaryA,
                                    activeTrackColor: theme.colors.accent,
                                    inactiveThumbColor: theme.colors.primaryA,
                                    inactiveTrackColor:
                                        theme.colors.backgroundAlpha,
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
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
                                  // TODO(Komarov): custom switch.
                                  Switch(
                                    activeColor: theme.colors.primaryA,
                                    activeTrackColor: theme.colors.accent,
                                    inactiveThumbColor: theme.colors.primaryA,
                                    inactiveTrackColor:
                                        theme.colors.backgroundAlpha,
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
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