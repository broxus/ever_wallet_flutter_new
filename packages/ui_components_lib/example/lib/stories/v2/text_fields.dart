import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/widgets/text_fields/base_text_field.dart';
import 'package:ui_components_lib/v2/widgets/text_fields/primary_text_field.dart';

/// Page with buttons
class TextFieldsStoryV2 extends StatefulWidget {
  const TextFieldsStoryV2({super.key});

  @override
  State<TextFieldsStoryV2> createState() => _TextFieldsStoryV2State();
}

class _TextFieldsStoryV2State extends State<TextFieldsStoryV2> {
  final _textController0 = TextEditingController(text: 'Initial value');
  final _textController1 = TextEditingController(text: 'Disabled value');

  @override
  void dispose() {
    _textController0.dispose();
    _textController1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TextFields v2')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(DimensSize.d16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PrimaryTextField(),
            const SizedBox(height: DimensSize.d20),
            const PrimaryTextField(
              labelText: 'Label:',
              hintText: 'Hint text',
            ),
            const SizedBox(height: DimensSize.d20),
            const PrimaryTextField(
              labelText: 'Label:',
              hintText: 'Medium large field',
              sizeType: PrimaryTextFieldSizeType.medium,
            ),
            const SizedBox(height: DimensSize.d20),
            PrimaryTextField(
              labelText: 'Label:',
              hintText: 'Hint text',
              textEditingController: _textController0,
            ),
            const SizedBox(height: DimensSize.d20),
            const PrimaryTextField(
              labelText: 'Label:',
              hintText: 'Disabled hint',
              isEnabled: false,
            ),
            const SizedBox(height: DimensSize.d20),
            PrimaryTextField(
              labelText: 'Label:',
              hintText: 'Disabled hint',
              isEnabled: false,
              textEditingController: _textController1,
            ),
            const SizedBox(height: DimensSize.d20),
            const PrimaryTextField(
              labelText: 'Label:',
              hintText: 'No error text',
              isShowErrorForced: true,
            ),
            const SizedBox(height: DimensSize.d20),
            const PrimaryTextField(
              labelText: 'Label:',
              hintText: 'Outline error',
              errorText: 'Error text',
            ),
            const SizedBox(height: DimensSize.d20),
            const PrimaryTextField(
              labelText: 'Label:',
              hintText: 'Inline error',
              isShowErrorForced: true,
              errorType: TextFieldErrorType.inline,
            ),
            const SizedBox(height: DimensSize.d20),
            PrimaryTextField(
              labelText: 'Label:',
              hintText: 'Validator length < 5',
              validator: (String? text) {
                if (text == null) {
                  return null;
                }
                return text.length < 5 ? null : 'Length is ${text.length}';
              },
            ),
            const SizedBox(height: DimensSize.d20),
            PrimaryTextField(
              labelText: 'Label:',
              hintText: 'Suffixes',
              isShowErrorForced: true,
              errorType: TextFieldErrorType.inline,
              suffixes: [
                Container(
                  width: 40,
                  height: 40,
                  color: context.themeStyleV2.colors.background3,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  child: const Text('S0'),
                ),
                Container(
                  width: 40,
                  height: 40,
                  color: context.themeStyleV2.colors.background3,
                  alignment: Alignment.center,
                  child: const Text('S1'),
                ),
              ],
            ),
            const SizedBox(height: DimensSize.d40),
          ],
        ),
      ),
    );
  }
}
