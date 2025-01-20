import 'package:app/feature/network/edit_network/widgets/widgets.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class TokenListField extends StatelessWidget {
  const TokenListField({
    required this.editable,
    required this.controller,
    required this.validator,
    required this.onTap,
    super.key,
  });

  final bool editable;
  final TextEditingController controller;
  final UrlTextValidator validator;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return NetworkFormField(
      label: LocaleKeys.networkTokenList.tr(),
      child: SeparatedColumn(
        children: [
          PrimaryTextField(
            textEditingController: controller,
            hintText: LocaleKeys.networkTokenListHint.tr(),
            isEnabled: editable,
            validator: validator.validate,
            suffixes: [
              PasteButton(
                controller: controller,
              ),
            ],
          ),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: LocaleKeys.networkTokenListText.tr(),
                  style: theme.textStyles.labelXSmall.copyWith(
                    color: theme.colors.content3,
                  ),
                ),
                TextSpan(
                  text: LocaleKeys.networkTokenListTextLink.tr(),
                  style: theme.textStyles.labelXSmall.copyWith(
                    color: theme.colors.content0,
                  ),
                  recognizer: TapGestureRecognizer()..onTap = onTap,
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
