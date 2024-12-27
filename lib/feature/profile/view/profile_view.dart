import 'package:app/app/router/app_route.dart';
import 'package:app/feature/contact_support/contact_support.dart';
import 'package:app/feature/profile/profile.dart';
import 'package:app/generated/assets.gen.dart';
import 'package:app/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({
    required this.appVersion,
    required this.currentSeed,
    required this.isBiometryAvailable,
    required this.isBiometryEnabled,
    required this.onLogout,
    required this.onBiomentryChanged,
    this.isDarkThemeEnabled = false,
    super.key,
  });

  final ListenableState<Seed?> currentSeed;
  final ListenableState<bool> isBiometryAvailable;
  final ListenableState<bool> isBiometryEnabled;
  final String appVersion;
  final bool isDarkThemeEnabled;
  final VoidCallback onLogout;
  final ValueChanged<bool> onBiomentryChanged;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    final mq = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: theme.colors.background0,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: mq.padding.top + DimensSizeV2.d32),
            Text(
              LocaleKeys.currentSeed.tr(),
              style: theme.textStyles.labelXSmall,
            ),
            const SizedBox(height: DimensSizeV2.d4),
            StateNotifierBuilder(
              listenableState: currentSeed,
              builder: (_, currentSeed) => Text(
                currentSeed?.name ?? '',
                style: theme.textStyles.headingLarge,
              ),
            ),
            const SizedBox(height: DimensSizeV2.d16),
            StateNotifierBuilder(
              listenableState: currentSeed,
              builder: (_, currentSeed) => PrimaryButton(
                isFullWidth: false,
                buttonShape: ButtonShape.pill,
                title: LocaleKeys.exportSeedPhrase.tr(),
                postfixIcon: LucideIcons.share,
                onPressed: currentSeed == null
                    ? null
                    : () => Navigator.of(context, rootNavigator: true).push(
                          exportSeedSheetRoute(
                            context,
                            currentSeed.publicKey,
                          ),
                        ),
              ),
            ),
            const SizedBox(height: DimensSizeV2.d32),
            ShapedContainerColumn(
              color: theme.colors.background1,
              separator: const CommonDivider(),
              children: [
                _profileTile(
                  leadingIcon: Assets.images.settings.path,
                  title: LocaleKeys.manageSeedsAndAccounts.tr(),
                  trailing: const Icon(
                    LucideIcons.chevronRight,
                    size: DimensSizeV2.d20,
                  ),
                  onPressed: () =>
                      context.goFurther(AppRoute.manageSeedsAccounts.path),
                  backgroundColor: theme.colors.backgroundAlpha,
                  iconColor: theme.colors.content0,
                ),
                // TODO(knightforce): temp
                // _profileTile(
                //   leadingIcon: Assets.images.currency.path,
                //   title: LocaleKeys.currencyWord.tr(),
                //   trailing: CommonButtonIconWidget.svg(
                //     svg: Assets.images.caretRight.path,
                //   ),
                //   // ignore: no-empty-block
                //   onPressed: () {},
                // ),
                // TODO(knightforce): temp
                // _profileTile(
                //   leadingIcon: Assets.images.planetInner.path,
                //   title: LocaleKeys.languageWord.tr(),
                //   trailing: const Icon(
                //     LucideIcons.chevronRight,
                //     size: DimensSizeV2.d20,
                //   ),
                //   // ignore: no-empty-block
                //   onPressed: () => showLocalizationSheet(
                //     context: context,
                //   ),
                //   backgroundColor: theme.colors.backgroundAlpha,
                //   iconColor: theme.colors.content0,
                // ),
                DoubleSourceBuilder(
                  firstSource: isBiometryAvailable,
                  secondSource: isBiometryEnabled,
                  builder: (_, available, enabled) {
                    if (available != true &&
                        defaultTargetPlatform != TargetPlatform.iOS) {
                      return const SizedBox.shrink();
                    }
                    return _profileTile(
                      leadingIcon: Assets.images.fingerSmall.path,
                      title: LocaleKeys.biometryWord.tr(),
                      trailing: Switch(
                        value: enabled ?? false,
                        onChanged: onBiomentryChanged,
                      ),
                      onPressed: null,
                      backgroundColor: theme.colors.backgroundAlpha,
                      iconColor: theme.colors.content0,
                    );
                  },
                ),
                _profileTile(
                  leadingIcon: Assets.images.support.path,
                  title: LocaleKeys.contactSupport.tr(),
                  trailing: const Icon(
                    LucideIcons.chevronRight,
                    size: DimensSizeV2.d20,
                  ),
                  onPressed: () => showContactSupportSheet(
                    context: context,
                    mode: ContactSupportMode.initiatedByUser,
                  ),
                  backgroundColor: theme.colors.backgroundAlpha,
                  iconColor: theme.colors.content0,
                ),
              ],
            ),
            const SizedBox(height: DimensSizeV2.d40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: DimensSizeV2.d24),
              child: DestructiveButton(
                buttonShape: ButtonShape.pill,
                onPressed: () => _logOutConfirm(context),
                title: LocaleKeys.logOut.tr(),
                icon: LucideIcons.logOut,
              ),
            ),
            const SizedBox(height: DimensSizeV2.d16),
            Text(
              '${LocaleKeys.versionWord.tr()} $appVersion',
              textAlign: TextAlign.center,
              style: theme.textStyles.labelXSmall
                  .copyWith(color: theme.colors.content3),
            ),
          ],
        ),
      ),
    );
  }

  /// !!! Modifying this tile, change BiometryTile and other tiles with custom
  /// logic in this screen.
  Widget _profileTile({
    required String leadingIcon,
    required String title,
    required Widget trailing,
    required VoidCallback? onPressed,
    required Color backgroundColor,
    required Color iconColor,
  }) {
    return CommonListTile(
      titleText: title,
      leading: CommonBackgroundedIconWidget.svg(
        svg: leadingIcon,
        iconColor: iconColor,
        backgroundColor: backgroundColor,
      ),
      trailing: trailing,
      onPressed: onPressed,
    );
  }

  Future<void> _logOutConfirm(BuildContext context) async {
    final confirmed = await showLogOutConfirmSheet(context);

    if (confirmed && context.mounted) {
      onLogout();
    }
  }
}
