import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/profile/profile.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:ui_components_lib/ui_components_lib.dart';

/// Helper function that allows show sheet to ask user password to make any
/// action related to <ApprovalsListener Service/Widget>.
/// [data] is a pairs where key - title for tile, value - subtitle.
/// All subtitles from [data] can be copied with default `Copied` message.
///
/// [publicKey] - key that should be used to ask user for password.
///
/// Returns password if user entered it or null.
Future<String?> showAskPasswordApprovalsSheet({
  required BuildContext context,
  required PublicKey publicKey,
  required Map<String, String> data,
  required String sheetTitle,
}) {
  return showCommonBottomSheet(
    context: context,
    title: sheetTitle,
    useAppBackgroundColor: true,
    body: (_, controller) => AskPasswordApprovalsSheet(
      data: data,
      sheetTitle: sheetTitle,
      publicKey: publicKey,
      controller: controller,
    ),
  );
}

class AskPasswordApprovalsSheet extends StatelessWidget {
  const AskPasswordApprovalsSheet({
    required this.publicKey,
    required this.data,
    required this.controller,
    required this.sheetTitle,
    super.key,
  });

  final PublicKey publicKey;
  final Map<String, String> data;
  final ScrollController controller;
  final String sheetTitle;

  @override
  Widget build(BuildContext context) {
    return SeparatedColumn(
      children: [
        Expanded(
          child: SingleChildScrollView(
            controller: controller,
            child: ShapedContainerColumn(
              margin: EdgeInsets.zero,
              children: data.keys
                  .map(
                    (e) => CommonListTile(
                      height: null,
                      subtitleMaxLines: null,
                      invertTitleSubtitleStyles: true,
                      titleText: e,
                      subtitleText: data[e],
                      // ignore: prefer-extracting-callbacks
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: data[e]!));
                        inject<MessengerService>().show(
                          Message.successful(
                            message: LocaleKeys.copiedExclamation.tr(),
                          ),
                        );
                      },
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
        SeparatedRow(
          children: [
            Expanded(
              child: CommonButton.ghost(
                fillWidth: true,
                text: LocaleKeys.rejectWord.tr(),
                onPressed: Navigator.of(context).pop,
              ),
            ),
            Expanded(
              child: CommonButton.primary(
                fillWidth: true,
                text: LocaleKeys.submitWord.tr(),
                onPressed: () => onSubmitPressed(context),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> onSubmitPressed(BuildContext context) async {
    final password = await showCommonBottomSheet<String?>(
      context: context,
      title: LocaleKeys.enterPasswordTo.tr(args: [sheetTitle.toLowerCase()]),
      useAppBackgroundColor: true,
      body: (_, __) => Builder(
        builder: (c) {
          return EnterPasswordWidget(
            onPasswordEntered: Navigator.of(c).pop,
            publicKey: publicKey,
          );
        },
      ),
    );
    if (password != null && context.mounted) {
      Navigator.of(context).pop(password);
    }
  }
}
