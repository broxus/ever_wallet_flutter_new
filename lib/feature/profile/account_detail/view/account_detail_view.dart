import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/profile/profile.dart';
import 'package:app/generated/generated.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class AccountDetailView extends StatelessWidget {
  const AccountDetailView({
    required this.account,
    required this.balance,
    required this.custodians,
    super.key,
  });

  final KeyAccount account;
  final Money balance;
  final List<SeedKey> custodians;

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyle.colors;
    final theme = context.themeStyleV2;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: DimensSizeV2.d16),
      child: SeparatedColumn(
        mainAxisSize: MainAxisSize.min,
        separatorSize: DimensSizeV2.d16,
        children: [
          SeparatedColumn(
            mainAxisSize: MainAxisSize.min,
            separatorSize: DimensSizeV2.d4,
            children: [
              Text(
                LocaleKeys.accountWord.tr(),
                style: theme.textStyles.labelXSmall,
              ),
              Text(
                account.name,
                style: theme.textStyles.headingLarge,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
              ),
            ],
          ),
          CommonCard(
            backgroundColor: theme.colors.background2,
            topSubtitleText: LocaleKeys.totalBalance.tr(),
            titleChild: MoneyWidget(
              money: balance,
              style: MoneyWidgetStyle.primary,
            ),
            height: DimensSizeV2.d76,
            width: double.infinity,
          ),
          ShapedContainerColumn(
            color: theme.colors.background2,
            mainAxisSize: MainAxisSize.min,
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            crossAxisAlignment: CrossAxisAlignment.center,
            separator: const CommonDivider(),
            children: [
              BarcodeWidget(
                margin: const EdgeInsets.all(DimensSizeV2.d32),
                width: DimensSizeV2.d148,
                height: DimensSizeV2.d148,
                data: account.address.address,
                barcode: Barcode.qrCode(),
                color: colors.textPrimary,
              ),
              CommonListTile(
                onPressed: _copyAddress,
                height: null,
                padding: const EdgeInsets.all(DimensSizeV2.d16),
                titleChild: Text(
                  LocaleKeys.addressWord.tr(),
                  style: theme.textStyles.labelXSmall,
                ),
                subtitleChild: Text(
                  account.address.address,
                  style: theme.textStyles.labelXSmall.copyWith(
                    color: theme.colors.content3,
                  ),
                ),
                trailing: CommonIconWidget.svg(svg: Assets.images.copy.path),
              ),
            ],
          ),
          CommonListTile(
            titleText: LocaleKeys.displayOnMainScreen.tr(),
            padding: const EdgeInsets.all(DimensSizeV2.d16),
            height: null,
            backgroundColor: theme.colors.background2,
            trailing: CommonSwitchInput(
              value: !account.isHidden,
              onChanged: (_) => _changeVisibility(),
            ),
          ),
          if (custodians.isNotEmpty)
            ShapedContainerColumn(
              color: theme.colors.background2,
              mainAxisSize: MainAxisSize.min,
              margin: EdgeInsets.zero,
              crossAxisAlignment: CrossAxisAlignment.center,
              separator: const CommonDivider(),
              titleText: LocaleKeys.custodiansWord.tr(),
              children: custodians.map(_custodianTile).toList(),
            ),
        ],
      ),
    );
  }

  void _copyAddress() {
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
  }

  void _changeVisibility() {
    if (account.isHidden) {
      account.show();
    } else {
      account.hide();
    }
  }

  Widget _custodianTile(SeedKey custodian) {
    return Builder(
      builder: (context) {
        final colors = context.themeStyle.colors;

        return CommonListTile(
          titleText: custodian.name,
          subtitleText: custodian.publicKey.toEllipseString(),
          trailing: CommonIconButton.svg(
            svg: Assets.images.edit.path,
            buttonType: EverButtonType.ghost,
            color: colors.textSecondary,
            onPressed: () => Navigator.of(context).push(
              showRenameSheet(context, custodian.publicKey, isCustodian: true),
            ),
          ),
        );
      },
    );
  }
}
