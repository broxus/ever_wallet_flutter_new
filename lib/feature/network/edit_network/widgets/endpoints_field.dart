import 'package:app/feature/network/edit_network/edit_network.dart';
import 'package:app/generated/generated.dart';
import 'package:collection/collection.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class EndpointsField extends StatelessWidget {
  const EndpointsField({
    required this.editable,
    required this.endpointsControllersState,
    required this.onAdd,
    required this.onLocalChanged,
    required this.onRemove,
    required this.connectionTypeState,
    required this.validator,
    required this.isLocalState,
    super.key,
  });

  final bool editable;
  final ListenableState<List<TextEditingController>> endpointsControllersState;
  final VoidCallback onAdd;
  final ValueChanged<bool> onLocalChanged;
  final ValueChanged<int> onRemove;
  final ListenableState<ConnectionType> connectionTypeState;
  final UrlTextValidator validator;
  final ListenableState<bool> isLocalState;

  @override
  Widget build(BuildContext context) {
    return DoubleSourceBuilder(
      firstSource: endpointsControllersState,
      secondSource: connectionTypeState,
      builder: (
        _,
        List<TextEditingController>? controllers,
        ConnectionType? connectionType,
      ) {
        if (controllers == null || connectionType == null) {
          return const SizedBox.shrink();
        }

        return NetworkFormField(
          label: LocaleKeys.networkEndpoint.plural(controllers.length),
          trailing: editable && connectionType.enableMultipleEndpoints
              ? GhostButton(
                  buttonShape: ButtonShape.square,
                  buttonSize: ButtonSize.small,
                  icon: LucideIcons.plus,
                  onPressed: onAdd,
                )
              : null,
          child: SeparatedColumn(
            children: [
              ...controllers.mapIndexed(
                (index, controller) => EndpointItem(
                  key: ObjectKey(controller),
                  editable: editable,
                  index: index,
                  controller: controller,
                  validator: validator,
                  onRemove: () => onRemove(index),
                ),
              ),
              if (connectionType.enableLocal)
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        LocaleKeys.networkEndpointLocal.tr(),
                        style: StyleRes.secondaryBold,
                      ),
                    ),
                    StateNotifierBuilder<bool>(
                      listenableState: isLocalState,
                      builder: (_, bool? isEnabled) {
                        return Switch(
                          value: isEnabled ?? false,
                          onChanged: onLocalChanged,
                        );
                      },
                    ),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }
}
