import 'package:app/feature/wallet/new_account/new_account_type'
    '/new_account_type_wm.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/constants.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

const _walletV5R1 = WalletType.walletV5R1();

class NewAccountTypeWidget extends ElementaryWidget<NewAccountTypeWidgetModel> {
  const NewAccountTypeWidget({
    required this.publicKey,
    required this.password,
    Key? key,
    WidgetModelFactory wmFactory = defaultNewAccountTypeWidgetModelFactory,
  }) : super(wmFactory, key: key);

  final PublicKey publicKey;
  final String? password;

  @override
  Widget build(NewAccountTypeWidgetModel wm) {
    final theme = wm.theme;
    final disabledTypes = wm.disabledWalletTypes;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                PrimaryTextField(
                  maxLength: maxLengthForMainEntities,
                  textEditingController: wm.controller,
                  hintText: LocaleKeys.accountName.tr(),
                ),
                const SizedBox(height: DimensSizeV2.d12),
                StateNotifierBuilder(
                  listenableState: wm.selected,
                  builder: (_, selected) => PrimaryCard(
                    padding: EdgeInsets.zero,
                    color: theme.colors.background1,
                    borderRadius:
                        BorderRadius.circular(DimensRadiusV2.radius12),
                    child: SeparatedColumn(
                      mainAxisSize: MainAxisSize.min,
                      separator: const CommonDivider(),
                      children: [
                        _WalletType(
                          name: LocaleKeys.defaultWord.tr(),
                          description: _getDescription(wm.defaultType),
                          checked: wm.defaultType == selected,
                          disabled: disabledTypes.contains(wm.defaultType),
                          onTap: () => wm.onSelect(wm.defaultType),
                        ),
                        if (wm.isHmstr)
                          _WalletType(
                            name: wm.getWalletName(_walletV5R1),
                            description: _getDescription(_walletV5R1),
                            checked: selected == _walletV5R1,
                            disabled: disabledTypes.contains(_walletV5R1),
                            onTap: () => wm.onSelect(_walletV5R1),
                          ),
                        if (wm.defaultMultisigType != null)
                          _WalletType(
                            name: LocaleKeys.multisignatureWord.tr(),
                            description:
                                _getDescription(wm.defaultMultisigType!),
                            checked: wm.defaultMultisigType == selected,
                            disabled: disabledTypes.contains(
                              wm.defaultMultisigType,
                            ),
                            onTap: () => wm.onSelect(wm.defaultMultisigType!),
                          ),
                      ],
                    ),
                  ),
                ),
                if (wm.isEverscale || wm.isHmstr)
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: DimensSizeV2.d24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            LocaleKeys.deprecatedTypes.tr(),
                            style: theme.textStyles.labelSmall,
                          ),
                          StateNotifierBuilder(
                            listenableState: wm.showDeprecated,
                            builder: (_, value) => Switch(
                              value: value ?? false,
                              onChanged: wm.onShowDeprecatedChanged,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: DimensSizeV2.d8),
                      SeparatedRow(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            LucideIcons.octagonAlert,
                            size: DimensSizeV2.d20,
                            color: theme.colors.content3,
                          ),
                          Flexible(
                            child: Text(
                              LocaleKeys.deprecatedTypesHint.tr(),
                              style: theme.textStyles.labelXSmall.copyWith(
                                color: theme.colors.content3,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: DimensSizeV2.d12),
                      DoubleSourceBuilder(
                        firstSource: wm.selected,
                        secondSource: wm.showDeprecated,
                        builder: (_, selected, showDeprecated) {
                          if (showDeprecated != true) {
                            return const SizedBox.shrink();
                          }

                          return PrimaryCard(
                            padding: EdgeInsets.zero,
                            color: theme.colors.background1,
                            borderRadius:
                                BorderRadius.circular(DimensRadiusV2.radius12),
                            child: SeparatedColumn(
                              mainAxisSize: MainAxisSize.min,
                              separator: const CommonDivider(),
                              children: [
                                for (final type in wm.deprecatedTypes)
                                  _WalletType(
                                    name: wm.getWalletName(type),
                                    description: _getDescription(type),
                                    checked: type == selected,
                                    disabled: disabledTypes.contains(type),
                                    onTap: () => wm.onSelect(type),
                                  ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
        DoubleSourceBuilder(
          firstSource: wm.loading,
          secondSource: wm.selected,
          builder: (_, isLoading, selected) => Padding(
            padding: const EdgeInsets.only(top: DimensSizeV2.d12),
            child: AccentButton(
              buttonShape: ButtonShape.pill,
              title: LocaleKeys.addAccount.tr(),
              postfixIcon: LucideIcons.plus,
              isLoading: isLoading ?? false,
              onPressed: selected != null && !disabledTypes.contains(selected)
                  ? wm.onSubmit
                  : null,
            ),
          ),
        ),
      ],
    );
  }

  String _getDescription(WalletType walletType) => walletType.when(
        multisig: (multisigType) {
          switch (multisigType) {
            case MultisigType.safeMultisigWallet:
              return LocaleKeys.walletDescriptionSafeMultisigWallet.tr();
            case MultisigType.safeMultisigWallet24h:
              return LocaleKeys.walletDescriptionSafeMultisigWallet24h.tr();
            case MultisigType.setcodeMultisigWallet:
              return LocaleKeys.walletDescriptionSetcodeMultisigWallet.tr();
            case MultisigType.setcodeMultisigWallet24h:
              return LocaleKeys.walletDescriptionSetcodeMultisigWallet24h.tr();
            case MultisigType.bridgeMultisigWallet:
              return LocaleKeys.walletDescriptionBridgeMultisigWallet.tr();
            case MultisigType.surfWallet:
              return LocaleKeys.walletDescriptionSurfWallet.tr();
            case MultisigType.multisig2:
              return LocaleKeys.walletDescriptionMultisig2.tr();
            case MultisigType.multisig2_1:
              return LocaleKeys.walletDescriptionMultisig2_1.tr();
          }
        },
        everWallet: () => LocaleKeys.walletDescriptionEverWallet.tr(),
        walletV3: () => LocaleKeys.walletDescriptionWalletV3.tr(),
        highloadWalletV2: () =>
            LocaleKeys.walletDescriptionHighloadWalletV2.tr(),
        walletV4R1: () => LocaleKeys.walletDescriptionWalletV4R1.tr(),
        walletV4R2: () => LocaleKeys.walletDescriptionWalletV4R2.tr(),
        walletV5R1: () => LocaleKeys.walletDescriptionWalletV5R1.tr(),
      );
}

class _WalletType extends StatelessWidget {
  const _WalletType({
    required this.name,
    required this.description,
    required this.checked,
    required this.disabled,
    required this.onTap,
  });

  final String name;
  final String description;
  final bool checked;
  final bool disabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    final colors = theme.colors;

    return GestureDetector(
      onTap: !disabled ? onTap : null,
      behavior: HitTestBehavior.translucent,
      child: Padding(
        padding: const EdgeInsets.all(DimensSizeV2.d16),
        child: SeparatedRow(
          separatorSize: DimensSizeV2.d12,
          children: [
            Expanded(
              child: SeparatedColumn(
                separatorSize: DimensSizeV2.d4,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: theme.textStyles.labelSmall.copyWith(
                      color: disabled
                          ? colors.content0.withAlpha(OpacV2.opac50.toByteInt())
                          : null,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      description,
                      style: theme.textStyles.labelXSmall.copyWith(
                        color: disabled
                            ? colors.content3.withAlpha(
                                OpacV2.opac50.toByteInt(),
                              )
                            : colors.content3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Visibility.maintain(
              visible: checked,
              child: Icon(
                LucideIcons.check,
                size: DimensSizeV2.d20,
                color: disabled ? colors.borderDisabled : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
