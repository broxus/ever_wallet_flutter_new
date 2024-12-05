// ignore_for_file: inference_failure_on_function_return_type
import 'package:app/generated/generated.dart';
import 'package:app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

Future<void> showRenameCustodianModal(
  BuildContext context,
  Function(String) callback,
) {
  return showCommonBottomSheet(
    context: context,
    titleTextStyle: context.themeStyleV2.textStyles.headingLarge,
    title: LocaleKeys.enterNewName.tr(),
    body: (_, __) => AccountRenameSheet(callback: callback),
  );
}

class AccountRenameSheet extends StatefulWidget {
  const AccountRenameSheet({
    required this.callback,
    super.key,
  });

  final Function(String) callback;

  @override
  State<AccountRenameSheet> createState() => _AccountRenameSheetState();
}

class _AccountRenameSheetState extends State<AccountRenameSheet> {
  final nameController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SeparatedColumn(
      mainAxisSize: MainAxisSize.min,
      separatorSize: DimensSize.d16,
      children: [
        PrimaryTextField(
          maxLength: maxLengthForMainEntities,
          textEditingController: nameController,
          hintText: LocaleKeys.nameWord.tr(),
          onSubmit: (_) {
            widget.callback(nameController.text.trim());
            Navigator.of(context).pop();
          },
        ),
        PrimaryButton(
          buttonShape: ButtonShape.pill,
          title: LocaleKeys.renameWord.tr(),
          onPressed: () {
            widget.callback(nameController.text.trim());
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
