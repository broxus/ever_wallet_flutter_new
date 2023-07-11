import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/profile/profile.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:ui_components_lib/ui_components_lib.dart';

/// Card widget that displays information about account.
class AccountCard extends StatelessWidget {
  const AccountCard({
    required this.account,
    required this.height,
    super.key,
  });

  final KeyAccount account;

  /// Height of card, just to sync with 'AddNewAccountCard'
  final double height;

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyle.colors;

    return ShapedContainerColumn(
      squircleRadius: DimensRadius.large,
      height: height,
      width: double.infinity,
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      separator: const CommonDivider(),
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: DimensSize.d16) +
                const EdgeInsets.only(top: DimensSize.d16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SeparatedColumn(
                        separatorSize: DimensSize.d4,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            account.name,
                            style: StyleRes.button
                                .copyWith(color: colors.textPrimary),
                          ),
                          // TODO(alex-a4): add multisig custodians
                          SeparatedRow(
                            separatorSize: DimensSize.d4,
                            children: [
                              CommonIconWidget.svg(
                                svg: Assets.images.accountType.path,
                                color: colors.textSecondary,
                              ),
                              Text(
                                inject<NekotonRepository>()
                                    .currentTransport
                                    .defaultAccountName(
                                      account.account.tonWallet.contract,
                                    )
                                    .toLowerCase(),
                                style: StyleRes.addRegular.copyWith(
                                  color: colors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    CommonIconButton.svg(
                      svg: Assets.images.settings.path,
                      buttonType: EverButtonType.ghost,
                      color: colors.textSecondary,
                      outerPadding: EdgeInsets.zero,
                      innerPadding: const EdgeInsets.all(DimensSize.d4),
                      onPressed: () => showAccountSettingsSheet(
                        context: context,
                        address: account.address,
                        showHiding: false,
                        seeInExplorer: true,
                        showCopyAddress: true,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      '0 USD',
                      style: StyleRes.balance.copyWith(
                        color: colors.textPrimary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        CommonListTile(
          height: DimensSize.d72,
          padding: const EdgeInsets.symmetric(
            horizontal: DimensSize.d16,
            vertical: DimensSize.d12,
          ),
          contentColor: colors.blue,
          titleChild: Text(
            LocaleKeys.addressWord.tr(),
            style: StyleRes.addRegular.copyWith(color: colors.blueSecond),
          ),
          subtitleChild: Text(
            account.address.toEllipseString(),
            style: StyleRes.addBold.copyWith(color: colors.blue),
          ),
          trailing: CommonIconWidget.svg(svg: Assets.images.copy.path),
          onPressed: () {
            Clipboard.setData(
              ClipboardData(text: account.address.address),
            );
            inject<MessengerService>().show(
              Message.successful(
                message: LocaleKeys.valueCopiedExclamation.tr(
                  args: [account.address.toEllipseString()],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
