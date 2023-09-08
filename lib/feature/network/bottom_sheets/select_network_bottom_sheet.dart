import 'package:app/app/router/router.dart';
import 'package:app/app/service/service.dart';
import 'package:app/data/models/models.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/network/bloc/bloc.dart';
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
      create: (context) => SelectNetworkBloc(
        inject<ConnectionsStorageService>(),
      ),
      child: Stack(
        children: [
          _networkList(),
          _buttons(),
        ],
      ),
    );
  }

  Widget _networkList() {
    return BlocBuilder<SelectNetworkBloc, SelectNetworkState>(
      builder: (context, state) {
        final items = context.watch<SelectNetworkBloc>().state.connections;
        final currentConnectionId =
            context.watch<SelectNetworkBloc>().state.currentConnectionId;
        return ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            final isSelected = item.id == currentConnectionId;
            return _networkItem(context, item, isSelected);
          },
        );
      },
    );
  }

  Widget _networkItem(
    BuildContext context,
    ConnectionData connection,
    bool isSelected,
  ) {
    return CommonListTile(
      titleText: connection.name,
      leading: CommonIconWidget.svg(
        svg: Assets.images.sparxLogoSmall.path,
      ),
      trailing: isSelected
          ? CommonIconWidget.svg(
              svg: Assets.images.check.path,
            )
          : null,
      onPressed: () => _onItemPressed(context, connection),
    );
  }

  void _onItemPressed(BuildContext context, ConnectionData connection) {
    context.read<SelectNetworkBloc>().add(
          SelectNetworkEvent.setCurrentConnectionId(id: connection.id),
        );
    Navigator.of(context).pop();
  }

  Widget _buttons() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(DimensSize.d16),
        child: CommonButton.primary(
          fillWidth: true,
          onPressed: () => _onConfigurePressed(context),
          text: LocaleKeys.configureNetworks.tr(),
        ),
      ),
    );
  }

  void _onConfigurePressed(BuildContext context) {
    Navigator.of(context).pop();
    context.goFurther(
      AppRoute.configureNetworks.path,
    );
  }
}
