import 'package:app/feature/network/edit_network/widgets/widgets.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class NameField extends StatelessWidget {
  const NameField({
    required this.editable,
    required this.controller,
    required this.validator,
    super.key,
  });

  final bool editable;
  final TextEditingController controller;
  final CommonTextValidator validator;

  @override
  Widget build(BuildContext context) {
    return NetworkFormField(
      label: LocaleKeys.networkName.tr(),
      child: PrimaryTextField(
        textEditingController: controller,
        hintText: LocaleKeys.networkNameHint.tr(),
        isEnabled: editable,
        validator: validator.validate,
      ),
    );
  }
}
