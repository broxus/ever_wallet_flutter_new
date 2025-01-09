import 'package:app/feature/network/network.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class TypeField extends StatelessWidget {
  const TypeField({
    required this.connectionType,
    required this.editable,
    required this.onChangeType,
    super.key,
  });

  final ConnectionType connectionType;
  final bool editable;
  final ValueChanged<ConnectionType> onChangeType;

  @override
  Widget build(BuildContext context) {
    return NetworkFormField(
      label: LocaleKeys.networkType.tr(),
      child: PrimaryCard(
        padding: EdgeInsets.zero,
        borderRadius: BorderRadius.circular(DimensRadiusV2.radius16),
        child: SeparatedColumn(
          mainAxisSize: MainAxisSize.min,
          separator: const CommonDivider(),
          children: [
            TypeComponent(
              editable: editable,
              currentConnectionType: connectionType,
              title: LocaleKeys.networkTypeJRPC.tr(),
              type: ConnectionType.jrpc,
              onChanged: onChangeType,
            ),
            TypeComponent(
              editable: editable,
              currentConnectionType: connectionType,
              title: LocaleKeys.networkTypeGraphQL.tr(),
              type: ConnectionType.gql,
              onChanged: onChangeType,
            ),
            TypeComponent(
              editable: editable,
              currentConnectionType: connectionType,
              title: LocaleKeys.networkTypeProto.tr(),
              type: ConnectionType.proto,
              onChanged: onChangeType,
            ),
          ],
        ),
      ),
    );
  }
}
