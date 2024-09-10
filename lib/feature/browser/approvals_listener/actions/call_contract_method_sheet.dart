import 'package:app/feature/browser/approvals_listener/actions/widgets/widgets.dart';
import 'package:app/feature/profile/profile.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:ui_components_lib/ui_components_lib.dart';

/// Helper function that shows sheet to call contract method.
/// Is used by `executeLocal`, `sendExternalMessage`,
/// and `sendExternalMessageDelayed` inpage-provider methods.
///
/// Returns password if user entered it or null.
Future<String?> showCallContractMethodSheet({
  required BuildContext context,
  required Uri origin,
  required Address account,
  required PublicKey publicKey,
  required Address recipient,
  required FunctionCall payload,
}) {
  return showCommonBottomSheet(
    context: context,
    title: LocaleKeys.callContractMethod.tr(),
    centerTitle: true,
    body: (_, controller) => _CallContractMethod(
      origin: origin,
      account: account,
      publicKey: publicKey,
      recipient: recipient,
      payload: payload,
      scrollController: controller,
    ),
  );
}

class _CallContractMethod extends StatelessWidget {
  const _CallContractMethod({
    required this.origin,
    required this.account,
    required this.publicKey,
    required this.recipient,
    required this.payload,
    required this.scrollController,
  });

  final Uri origin;
  final Address account;
  final PublicKey publicKey;
  final Address recipient;
  final FunctionCall payload;
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
                ExpandableCard(
                  collapsedHeight: DimensSizeV2.d256,
                  child: SeparatedColumn(
                    separatorSize: DimensSizeV2.d16,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        LocaleKeys.metadata.tr(),
                        style: theme.textStyles.labelSmall.copyWith(
                          color: theme.colors.content3,
                        ),
                      ),
                      FunctionCallBody(payload: payload, contract: recipient),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        EnterPasswordWidgetV2(
          publicKey: publicKey,
          title: LocaleKeys.confirm.tr(),
          onPasswordEntered: (String password) =>
              Navigator.of(context).pop(password),
        ),
      ],
    );
  }
}
