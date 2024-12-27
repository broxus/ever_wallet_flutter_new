import 'package:app/app/service/connection/presets_connection_service.dart';
import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/network/network.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

/// Helper function to show [SwitchToThisNetworkSheet].
Future<void> showSwitchToThisNetworkSheet({
  required BuildContext context,
  required String connectionId,
}) {
  return showCommonBottomSheet(
    context: context,
    body: (_, __) => SwitchToThisNetworkSheet(
      connectionId: connectionId,
    ),
  );
}

class SwitchToThisNetworkSheet extends StatefulWidget {
  const SwitchToThisNetworkSheet({
    required this.connectionId,
    super.key,
  });

  final String connectionId;

  @override
  State<SwitchToThisNetworkSheet> createState() =>
      _SwitchToThisNetworkSheetState();
}

class _SwitchToThisNetworkSheetState extends State<SwitchToThisNetworkSheet> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ManageNetworksBloc>(
      create: (context) => ManageNetworksBloc(
        inject<ConnectionsStorageService>(),
        inject<PresetsConnectionService>(),
      ),
      child: Builder(
        builder: (context) {
          final theme = context.themeStyleV2;
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: DimensSizeV2.d24),
              Image.asset(
                Assets.images.checkCircleFill.checkCircleFill.path,
                height: DimensSizeV2.d56,
                width: DimensSizeV2.d56,
              ),
              const SizedBox(height: DimensSizeV2.d16),
              Text(
                LocaleKeys.networkAddedSheetTitle.tr(),
                style: theme.textStyles.headingLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: DimensSizeV2.d24),
              AccentButton(
                buttonShape: ButtonShape.pill,
                title: LocaleKeys.networkAddedSheetSwitch.tr(),
                onPressed: () => _onSwitch(context),
              ),
              const SizedBox(height: DimensSizeV2.d8),
              PrimaryButton(
                buttonShape: ButtonShape.pill,
                title: LocaleKeys.networkAddedSheetContinue.tr(),
                onPressed: () => _onContinue(context),
              ),
            ],
          );
        },
      ),
    );
  }

  void _onSwitch(BuildContext context) {
    context.read<ManageNetworksBloc>().add(
          ManageNetworksEvent.updateCurrentConnectionId(
            id: widget.connectionId,
          ),
        );
    Navigator.of(context).pop();
  }

  void _onContinue(BuildContext context) {
    Navigator.of(context).pop();
  }
}
