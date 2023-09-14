import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/network/edit_network/edit_network_view.dart';
import 'package:app/feature/network/network.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class EditNetworkPage extends StatefulWidget {
  const EditNetworkPage({this.connectionDataId, super.key});

  final String? connectionDataId;

  @override
  State<EditNetworkPage> createState() => _EditNetworkPageState();
}

class _EditNetworkPageState extends State<EditNetworkPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ManageNetworksBloc(
        inject<ConnectionsStorageService>(),
      ),
      child: BlocBuilder<ManageNetworksBloc, ManageNetworksState>(
        builder: (context, state) {
          final connection = widget.connectionDataId == null
              ? null
              : context.read<ManageNetworksBloc>().getConnection(
                    widget.connectionDataId!,
                  );
          final title = connection == null
              ? LocaleKeys.addCustomNetwork.tr()
              : connection.name;

          return Scaffold(
            appBar: DefaultAppBar(
              titleText: title,
            ),
            body: const EditNetworkView(),
          );
        },
      ),
    );
  }
}
