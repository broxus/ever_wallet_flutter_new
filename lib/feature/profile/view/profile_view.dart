import 'package:app/app/router/app_route.dart';
import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/contact_support/contact_support.dart';
import 'package:app/feature/localization/localization.dart';
import 'package:app/feature/profile/profile.dart';
import 'package:app/generated/assets.gen.dart';
import 'package:app/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/dimens_v2.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({
    required this.appVersion,
    required this.isDarkThemeEnabled,
    this.isBiometryAvailable = false,
    this.currentSeed,
    super.key,
  });

  final Seed? currentSeed;
  final bool isBiometryAvailable;
  final String appVersion;
  final bool isDarkThemeEnabled;

  @override
  Widget build(BuildContext context) {
    final service = inject<BiometryService>();
    final theme = context.themeStyleV2;
    final mq = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: theme.colors.background1,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: mq.padding.top + DimensSizeV2.d32),
            Text(
              LocaleKeys.currentSeed.tr(),
              style: theme.textStyles.labelXSmall,
            ),
            const SizedBox(height: DimensSizeV2.d4),
            Text(
              currentSeed?.name ?? '',
              style: theme.textStyles.headingLarge,
            ),
            const SizedBox(height: DimensSizeV2.d16),
            PrimaryButton(
              isFullWidth: false,
              buttonShape: ButtonShape.pill,
              title: LocaleKeys.exportSeedPhrase.tr(),
              postfixIcon: LucideIcons.share,
              onPressed: currentSeed == null
                  ? null
                  : () => Navigator.of(context, rootNavigator: true)
                      .push(exportSeedSheetRoute(currentSeed!.publicKey)),
            ),
            const SizedBox(height: DimensSizeV2.d32),
            ShapedContainerColumn(
              color: theme.colors.background2,
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
                // _profileTile(
                //   leadingIcon: Assets.images.currency.path,
                //   title: LocaleKeys.currencyWord.tr(),
                //   trailing: CommonButtonIconWidget.svg(
                //     svg: Assets.images.caretRight.path,
                //   ),
                //   // ignore: no-empty-block
                //   onPressed: () {},
                // ),
                _profileTile(
                  leadingIcon: Assets.images.planetInner.path,
                  title: LocaleKeys.languageWord.tr(),
                  trailing: const Icon(
                    LucideIcons.chevronRight,
                    size: DimensSizeV2.d20,
                  ),
                  // ignore: no-empty-block
                  onPressed: () => showLocalizationSheet(
                    context: context,
                  ),
                  backgroundColor: theme.colors.backgroundAlpha,
                  iconColor: theme.colors.content0,
                ),
                if (isBiometryAvailable)
                  StreamBuilder<bool>(
                    stream: service.enabledStream,
                    initialData: service.enabled,
                    builder: (context, snapshot) {
                      final enabled = snapshot.data ?? false;

                      return _profileTile(
                        leadingIcon: Assets.images.fingerSmall.path,
                        title: LocaleKeys.biometryWord.tr(),
                        trailing: CommonSwitchInput(
                          value: enabled,
                          onChanged: (value) => service.setStatus(
                            localizedReason: LocaleKeys.biometryAuthReason.tr(),
                            isEnabled: !enabled,
                          ),
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
      context.read<ProfileBloc>().add(const ProfileEvent.logOut());
    }
  }
}
