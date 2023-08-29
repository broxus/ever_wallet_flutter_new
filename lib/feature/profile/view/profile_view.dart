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
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({
    this.isBiometryAvailable = false,
    this.currentSeed,
    super.key,
  });

  final Seed? currentSeed;
  final bool isBiometryAvailable;

  @override
  Widget build(BuildContext context) {
    final service = inject<BiometryService>();
    final colors = context.themeStyle.colors;
    final mq = MediaQuery.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: mq.padding.top + DimensSize.d32),
            Text(
              LocaleKeys.currentSeed.tr(),
              style: StyleRes.addRegular.copyWith(color: colors.textSecondary),
            ),
            const SizedBox(height: DimensSize.d4),
            Text(
              currentSeed?.name ?? '',
              style: StyleRes.h2.copyWith(color: colors.textPrimary),
            ),
            const SizedBox(height: DimensSize.d16),
            CommonButton.secondary(
              text: LocaleKeys.exportSeedPhrase.tr(),
              trailing: CommonIconWidget.svg(svg: Assets.images.export.path),
              onPressed: currentSeed == null
                  ? null
                  : () => Navigator.of(context, rootNavigator: true)
                      .push(exportSeedSheetRoute(currentSeed!.publicKey)),
            ),
            const SizedBox(height: DimensSize.d32),
            ShapedContainerColumn(
              separator: const CommonDivider(),
              children: [
                _profileTile(
                  leadingIcon: Assets.images.settings.path,
                  title: LocaleKeys.manageSeedsAndAccounts.tr(),
                  trailing: CommonButtonIconWidget.svg(
                    svg: Assets.images.caretRight.path,
                  ),
                  onPressed: () =>
                      context.goFurther(AppRoute.manageSeedsAccounts.path),
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
                  trailing: CommonButtonIconWidget.svg(
                    svg: Assets.images.caretRight.path,
                  ),
                  // ignore: no-empty-block
                  onPressed: () => showLocalizationSheet(
                    context: context,
                  ),
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
                      );
                    },
                  ),
              ],
            ),
            const SizedBox(height: DimensSize.d16),
            ShapedContainerColumn(
              separator: const CommonDivider(),
              children: [
                _profileTile(
                  leadingIcon: Assets.images.support.path,
                  title: LocaleKeys.contactSupport.tr(),
                  trailing: CommonButtonIconWidget.svg(
                    svg: Assets.images.caretRight.path,
                  ),
                  onPressed: () => showContactSupportSheet(
                    context: context,
                    mode: ContactSupportMode.initiatedByUser,
                  ),
                ),
              ],
            ),
            const SizedBox(height: DimensSize.d40),
            CommonButton(
              padding: const EdgeInsets.symmetric(horizontal: DimensSize.d24),
              buttonType: EverButtonType.ghost,
              contentColor: colors.alert,
              onPressed: () =>
                  context.read<ProfileBloc>().add(const ProfileEvent.logOut()),
              text: LocaleKeys.logOut.tr(),
              trailing: CommonButtonIconWidget.svg(
                svg: Assets.images.exit.path,
              ),
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
  }) {
    return CommonListTile(
      titleText: title,
      leading: CommonBackgroundedIconWidget.svg(svg: leadingIcon),
      trailing: trailing,
      onPressed: onPressed,
    );
  }
}
