import 'package:app/feature/browser/approvals_listener/actions/widgets/widgets.dart';
import 'package:app/feature/profile/profile.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:ui_components_lib/ui_components_lib.dart';

/// Helper function that shows sheet to sign data.
///
/// Returns password if user entered it or null.
Future<String?> showSignDataSheet({
  required BuildContext context,
  required Uri origin,
  required Address account,
  required PublicKey publicKey,
  required String data,
}) {
  return showCommonBottomSheet(
    context: context,
    title: LocaleKeys.signData.tr(),
    centerTitle: true,
    body: (_, controller) => _SignData(
      origin: origin,
      account: account,
      publicKey: publicKey,
      data: data,
      scrollController: controller,
    ),
  );
}

class _SignData extends StatelessWidget {
  const _SignData({
    required this.origin,
    required this.account,
    required this.publicKey,
    required this.data,
    required this.scrollController,
  });

  final Uri origin;
  final Address account;
  final PublicKey publicKey;
  final String data;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) => SeparatedColumn(
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
                  DataCard(data: data),
                ],
              ),
            ),
          ),
          EnterPasswordWidgetV2(
            publicKey: publicKey,
            title: LocaleKeys.sign.tr(),
            onPasswordEntered: (String password) =>
                Navigator.of(context).pop(password),
          ),
        ],
      );
}
