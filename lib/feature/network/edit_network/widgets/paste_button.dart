import 'package:app/feature/wallet/wallet_deploy/clipboard_paste_button.dart';
import 'package:app/utils/clipboard_utils.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class PasteButton extends StatelessWidget {
  const PasteButton({
    required this.controller,
    super.key,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: DimensSizeV2.d8),
      child: ClipboardPasteButton(
        onPressed: _onPressed,
      ),
    );
  }

  Future<void> _onPressed() async {
    final text = await getClipBoardText();
    if (text != null) {
      controller.text = text;
    }
  }
}
