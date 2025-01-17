import 'package:app/feature/network/edit_network/widgets/widgets.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/widgets/widgets.dart';

class BlockExplorerField extends StatelessWidget {
  const BlockExplorerField({
    required this.validator,
    required this.editable,
    required this.controller,
    super.key,
  });

  final UrlTextValidator validator;
  final bool editable;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return NetworkFormField(
      label: LocaleKeys.networkBlockExplorer.tr(),
      child: PrimaryTextField(
        textEditingController: controller,
        hintText: LocaleKeys.networkBlockExplorerHint.tr(),
        isEnabled: editable,
        validator: validator.validate,
        suffixes: [
          PasteButton(
            controller: controller,
          ),
        ],
      ),
    );
  }
}
