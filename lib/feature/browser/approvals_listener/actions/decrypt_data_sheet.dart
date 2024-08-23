import 'package:app/feature/browser/approvals_listener/actions/widgets/widgets.dart';
import 'package:app/feature/profile/profile.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

/// Helper function that shows sheet to decrypt data.
///
/// Returns password if user entered it or null.
Future<String?> showDecryptDataSheet({
  required BuildContext context,
  required Uri origin,
  required Address account,
  required PublicKey recipientPublicKey,
  required PublicKey sourcePublicKey,
}) {
  return showCommonBottomSheet(
    context: context,
    title: LocaleKeys.encryptData.tr(),
    centerTitle: true,
    body: (_, controller) => _DecryptData(
      origin: origin,
      account: account,
      recipientPublicKey: recipientPublicKey,
      sourcePublicKey: sourcePublicKey,
      scrollController: controller,
    ),
  );
}

class _DecryptData extends StatelessWidget {
  const _DecryptData({
    required this.origin,
    required this.account,
    required this.recipientPublicKey,
    required this.sourcePublicKey,
    required this.scrollController,
  });

  final Uri origin;
  final Address account;
  final PublicKey recipientPublicKey;
  final PublicKey sourcePublicKey;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return SeparatedColumn(
      separatorSize: DimensSizeV2.d12,
      children: [
        Expanded(
          child: SingleChildScrollView(
            controller: scrollController,
            child: SeparatedColumn(
              separatorSize: DimensSizeV2.d12,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AccountInfoWidget(account: account),
                WebsiteInfoWidget(uri: origin),
                PrimaryCard(
                  color: theme.colors.background2,
                  borderRadius: BorderRadius.circular(DimensRadiusV2.radius12),
                  padding: const EdgeInsets.all(DimensSizeV2.d16),
                  child: SeparatedColumn(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        LocaleKeys.sourcePublicKey.tr(),
                        style: theme.textStyles.labelSmall.copyWith(
                          color: theme.colors.content3,
                        ),
                      ),
                      Text(
                        sourcePublicKey.publicKey,
                        style: theme.textStyles.labelSmall.copyWith(
                          color: theme.colors.content0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        EnterPasswordWidgetV2(
          publicKey: recipientPublicKey,
          title: LocaleKeys.decrypt.tr(),
          onPasswordEntered: (String password) =>
              Navigator.of(context).pop(password),
        ),
      ],
    );
  }
}
