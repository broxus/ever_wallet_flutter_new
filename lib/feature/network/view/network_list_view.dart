import 'package:app/data/models/models.dart';
import 'package:app/feature/network/network.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class NetworkListView extends StatefulWidget {
  const NetworkListView({
    required this.onItemPressed,
    required this.buttonText,
    required this.onButtonPressed,
    this.itemTrailing,
    super.key,
  });

  final ValueChanged<ConnectionData> onItemPressed;
  final String buttonText;
  final VoidCallback onButtonPressed;
  final Widget? itemTrailing;

  @override
  State<NetworkListView> createState() => _NetworkListViewState();
}

class _NetworkListViewState extends State<NetworkListView> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        CustomScrollView(
          slivers: [
            _networkListBuilder(),
            _bottomSpacerBuilder(),
          ],
        ),
        _buttonsBuilder(),
      ],
    );
  }

  SliverList _networkListBuilder() {
    final items = context.watch<ManageNetworksBloc>().state.connections;
    final currentConnectionId =
        context.watch<ManageNetworksBloc>().state.currentConnectionId;

    return SliverList.builder(
      itemCount: items.length,
      itemBuilder: (_, index) {
        final item = items[index];
        final isSelected = item.id == currentConnectionId;

        return _networkItem(item, isSelected);
      },
    );
  }

  Widget _networkItem(
    ConnectionData connection,
    bool isSelected,
  ) {
    final trailing = widget.itemTrailing ??
        (isSelected
            ? CommonIconWidget.svg(
                svg: Assets.images.check.path,
              )
            : null);

    return CommonListTile(
      padding: const EdgeInsets.symmetric(horizontal: DimensSize.d16),
      titleText: connection.name,
      leading: CommonIconWidget.svg(
        svg: Assets.images.sparxLogoSmall.path,
      ),
      trailing: trailing,
      onPressed: () => widget.onItemPressed(connection),
    );
  }

  Widget _bottomSpacerBuilder() {
    return const SliverSafeArea(
      sliver: SliverToBoxAdapter(
        child: SizedBox(
          height: commonButtonHeight + DimensSize.d16,
        ),
      ),
      minimum: EdgeInsets.only(bottom: DimensSize.d16),
    );
  }

  Widget _buttonsBuilder() {
    final colors = context.themeStyle.colors;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: colors.gradient,
        ),
      ),
      child: SafeArea(
        minimum: const EdgeInsets.all(DimensSize.d16),
        child: CommonButton.primary(
          text: widget.buttonText,
          onPressed: widget.onButtonPressed,
          fillWidth: true,
        ),
      ),
    );
  }
}
