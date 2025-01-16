import 'package:app/feature/network/edit_network/edit_network.dart';
import 'package:app/generated/generated.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class EndpointsField extends StatelessWidget {
  const EndpointsField({
    required this.editable,
    required this.endpointsControllers,
    required this.onAdd,
    required this.isLocal,
    required this.onLocalChanged,
    required this.onRemove,
    required this.connectionType,
    required this.validator,
    super.key,
  });

  final bool editable;
  final List<TextEditingController> endpointsControllers;
  final VoidCallback onAdd;
  final bool isLocal;
  final ValueChanged<bool> onLocalChanged;
  final ValueChanged<int> onRemove;
  final ConnectionType connectionType;
  final UrlTextValidator validator;

  @override
  Widget build(BuildContext context) {
    return NetworkFormField(
      label: LocaleKeys.networkEndpoint.plural(endpointsControllers.length),
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
          ...endpointsControllers.mapIndexed(
            (index, controller) => EndpointItem(
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
                Switch(
                  value: isLocal,
                  onChanged: onLocalChanged,
                ),
              ],
            ),
        ],
      ),
    );
  }
}
