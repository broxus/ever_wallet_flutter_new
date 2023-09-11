import 'package:app/app/router/router.dart';
import 'package:app/data/models/connection_data.dart';
import 'package:app/feature/network/network.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class ConfigureNetworksView extends StatefulWidget {
  const ConfigureNetworksView({super.key});

  @override
  State<ConfigureNetworksView> createState() => _ConfigureNetworksViewState();
}

class _ConfigureNetworksViewState extends State<ConfigureNetworksView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManageNetworksBloc, ManageNetworksState>(
      builder: (context, state) {
        return NetworkListView(
          onItemPressed: (connection) => _onItemPressed(
            context,
            connection,
          ),
          buttonText: LocaleKeys.addCustomNetwork.tr(),
          onButtonPressed: _onButtonPressed,
          itemTrailing: CommonButtonIconWidget.svg(
            svg: Assets.images.caretRight.path,
          ),
        );
      },
    );
  }

  void _onItemPressed(BuildContext context, ConnectionData connection) {
    context.goFurther(
      AppRoute.editNetwork.path,
    );
  }

  void _onButtonPressed() {
    context.goFurther(
      AppRoute.editNetwork.path,
    );
  }
}
