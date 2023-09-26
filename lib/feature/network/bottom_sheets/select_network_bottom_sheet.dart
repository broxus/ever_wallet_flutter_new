import 'package:app/app/router/router.dart';
import 'package:app/app/service/service.dart';
import 'package:app/data/models/models.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/network/network.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Helper function to show [SelectNetworkSheet].
Future<void> showSelectNetworkSheet({
  required BuildContext context,
}) {
  return showCommonBottomSheet(
    context: context,
    expand: true,
    title: LocaleKeys.selectNetwork.tr(),
    body: (_, __) => const SelectNetworkSheet(),
  );
}

class SelectNetworkSheet extends StatefulWidget {
  const SelectNetworkSheet({super.key});

  @override
  State<SelectNetworkSheet> createState() => _SelectNetworkSheetState();
}

class _SelectNetworkSheetState extends State<SelectNetworkSheet> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ManageNetworksBloc(
        inject<ConnectionsStorageService>(),
      ),
      child: BlocBuilder<ManageNetworksBloc, ManageNetworksState>(
        builder: (context, state) {
          return NetworkListView(
            onItemPressed: (connection) => _onItemPressed(
              context,
              connection,
            ),
            buttonText: LocaleKeys.configureNetworks.tr(),
            onButtonPressed: _onButtonPressed,
          );
        },
      ),
    );
  }

  void _onItemPressed(BuildContext context, ConnectionData connection) {
    context.read<ManageNetworksBloc>().add(
          ManageNetworksEvent.updateCurrentConnectionId(id: connection.id),
        );
    Navigator.of(context).pop();
  }

  void _onButtonPressed() {
    Navigator.of(context).pop();
    context.goFurther(
      AppRoute.configureNetworks.path,
    );
  }
}
