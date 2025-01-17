import 'package:app/app/service/connection/data/connection_data/connection_data.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class NetworkButtons extends StatelessWidget {
  const NetworkButtons({
    required this.saveEnabled,
    required this.deleteEnabled,
    required this.connection,
    required this.onSave,
    required this.onDelete,
    super.key,
  });

  final bool saveEnabled;
  final bool deleteEnabled;
  final ConnectionData? connection;
  final VoidCallback onSave;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    final saveButtonText = connection == null
        ? LocaleKeys.networkAdd.tr()
        : LocaleKeys.networkSave.tr();

    return ColoredBox(
      color: theme.colors.background0,
      child: SafeArea(
        minimum: const EdgeInsets.symmetric(
          vertical: DimensSizeV2.d12,
          horizontal: DimensSizeV2.d16,
        ),
        child: SeparatedColumn(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (saveEnabled)
              AccentButton(
                buttonShape: ButtonShape.pill,
                title: saveButtonText,
                onPressed: onSave,
              ),
            if (deleteEnabled)
              DestructiveButton(
                buttonShape: ButtonShape.pill,
                title: LocaleKeys.networkDelete.tr(),
                onPressed: onDelete,
              ),
          ],
        ),
      ),
    );
  }
}
