import 'package:app/feature/network/edit_network/widgets/network_form_field.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class NetworkTypeField extends StatelessWidget {
  const NetworkTypeField({
    required this.types,
    required this.selectedNetworkTypeState,
    required this.onChanged,
    super.key,
  });

  final List<String> types;
  final ListenableState<String?> selectedNetworkTypeState;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    return NetworkFormField(
      label: LocaleKeys.networkTypeWord.tr(),
      child: StateNotifierBuilder<String?>(
        listenableState: selectedNetworkTypeState,
        builder: (_, String? selectedValue) {
          return Wrap(
            spacing: DimensSize.d16,
            runSpacing: DimensSize.d16,
            children: [
              for (final type in types)
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => onChanged(type),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IgnorePointer(
                        child: CommonRadioInput(
                          value: type,
                          groupValue: selectedValue,
                          onChanged: (_) {},
                        ),
                      ),
                      const SizedBox(width: DimensSize.d8),
                      Text(
                        type,
                        style: theme.textStyles.labelSmall,
                      ),
                    ],
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
