import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

const suggestionsList = ['aaaa', 'bbbb', 'cccc', 'dddd', 'eeee', 'ffff'];

/// Page with buttons
class InputsStory extends StatefulWidget {
  const InputsStory({super.key});

  @override
  State<InputsStory> createState() => _InputsStoryState();
}

class _InputsStoryState extends State<InputsStory> {
  final suggestion1Controller = TextEditingController();
  final suggestion2Controller = TextEditingController();

  final validationFormKey1 = GlobalKey<FormState>();
  final validationFormKey12 = GlobalKey<FormState>();
  final validationFormKey2 = GlobalKey<FormState>();
  final validationFormKey3 = GlobalKey<FormState>();
  final validationFormKey4 = GlobalKey<FormState>();

  final switcher1Notifier = ValueNotifier<bool>(true);
  final switcher2Notifier = ValueNotifier<bool>(true);
  final switcher3Notifier = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inputs'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CommonInput(labelText: 'Default input'),
              const SizedBox(height: 20),

              const CommonInput(
                labelText: 'Default without X',
                needClearButton: false,
              ),
              const SizedBox(height: 20),

              /// with suggestion
              CommonInput(
                labelText: 'Suggestions with simple builder',
                controller: suggestion1Controller,
                suggestionsCallback: (pattern) {
                  if (pattern.isEmpty) return suggestionsList;
                  return suggestionsList
                      .where(
                        (element) => element
                            .toLowerCase()
                            .contains(pattern.toLowerCase()),
                      )
                      .toList();
                },
                itemBuilder: (_, suggestion) =>
                    ListTile(title: Text(suggestion)),
                onSuggestionSelected: (v) => suggestion1Controller.text = v,
              ),
              const SizedBox(height: 20),

              /// Validation
              Form(
                key: validationFormKey1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonInput(
                      labelText: 'Silent validation for emptiness',
                      validator: (v) => v?.isEmpty ?? true ? '' : null,
                    ),
                    const SizedBox(height: 12),
                    CommonButton.primary(
                      text: 'Validate',
                      onPressed: () =>
                          validationFormKey1.currentState!.validate(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              Form(
                key: validationFormKey12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonInput(
                      labelText: 'Auto silent validation',
                      validator: (v) => v?.isEmpty ?? true ? '' : null,
                      validateMode: AutovalidateMode.onUserInteraction,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              Form(
                key: validationFormKey2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonInput(
                      labelText: 'Validation for emptiness with error',
                      validator: (v) => v?.isEmpty ?? true ? 'Error' : null,
                    ),
                    const SizedBox(height: 12),
                    CommonButton.primary(
                      text: 'Validate',
                      onPressed: () =>
                          validationFormKey2.currentState!.validate(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              Form(
                key: validationFormKey3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonInput(
                      labelText: 'Validation with suggestions',
                      controller: suggestion2Controller,
                      suggestionsCallback: (pattern) {
                        if (pattern.isEmpty) return suggestionsList;
                        return suggestionsList
                            .where(
                              (element) => element
                                  .toLowerCase()
                                  .contains(pattern.toLowerCase()),
                            )
                            .toList();
                      },
                      itemBuilder: (_, suggestion) =>
                          ListTile(title: Text(suggestion)),
                      onSuggestionSelected: (v) =>
                          suggestion2Controller.text = v,
                      validator: (v) => v?.isEmpty ?? true ? 'Error' : null,
                    ),
                    const SizedBox(height: 12),
                    CommonButton.primary(
                      text: 'Validate',
                      onPressed: () =>
                          validationFormKey3.currentState!.validate(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              /// Switchers
              ValueListenableBuilder<bool>(
                valueListenable: switcher1Notifier,
                builder: (_, value, __) {
                  return CommonSwitchInput(
                    value: value,
                    onChanged: (v) => switcher1Notifier.value = v,
                  );
                },
              ),
              const SizedBox(height: 20),

              ValueListenableBuilder<bool>(
                valueListenable: switcher2Notifier,
                builder: (context, value, __) {
                  final textColor = context.themeStyle.colors.textPrimary;

                  return Form(
                    key: validationFormKey4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Switcher with validation',
                          style: TextStyle(color: textColor),
                        ),
                        const SizedBox(height: 5),
                        CommonSwitchInput(
                          value: value,
                          validateMode: AutovalidateMode.onUserInteraction,
                          validator: (v) => v ?? false ? null : '',
                          onChanged: (v) => switcher2Notifier.value = v,
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),

              ValueListenableBuilder<bool>(
                valueListenable: switcher3Notifier,
                builder: (_, value, __) {
                  return CommonSwitchInput(
                    value: value,
                    thumbChild: const Icon(Icons.check, color: Colors.grey),
                    onChanged: (v) => switcher3Notifier.value = v,
                  );
                },
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
