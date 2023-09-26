import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/network/network.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Helper function to show [SwitchToThisNetworkSheet].
Future<void> showSwitchToThisNetworkSheet({
  required BuildContext context,
  required String connectionId,
}) {
  return showCommonBottomSheet(
    context: context,
    title: LocaleKeys.networkAddedSheetTitle.tr(),
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
      ),
      child: Builder(
        builder: (context) {
          return SeparatedColumn(
            mainAxisSize: MainAxisSize.min,
            separatorSize: DimensSize.d24,
            children: [
              CommonButton.primary(
                fillWidth: true,
                onPressed: () => _onSwitch(context),
                text: LocaleKeys.networkAddedSheetSwitch.tr(),
              ),
              CommonButton.secondary(
                fillWidth: true,
                onPressed: () => _onContinue(context),
                text: LocaleKeys.networkAddedSheetContinue.tr(),
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
              id: widget.connectionId),
        );
    Navigator.of(context).pop();
  }

  void _onContinue(BuildContext context) {
    Navigator.of(context).pop();
  }
}
