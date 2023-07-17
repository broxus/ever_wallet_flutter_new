import 'package:app/feature/browser/browser.dart';
import 'package:app/feature/browser/primary/hud_bloc/hud_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PrimaryView extends StatefulWidget {
  const PrimaryView({super.key});

  @override
  State<PrimaryView> createState() => _PrimaryViewState();
}

class _PrimaryViewState extends State<PrimaryView> {
  static const int _hudScrollMinYThreshold = 64;
  static const int _hudScrollDYThreshold = 64;

  @override
  Widget build(BuildContext context) {
    final isHudVisible = context.watch<HudBloc>().state.when(
          visible: () => true,
          invisible: () => false,
        );

    print('build: isHudVisible: $isHudVisible');

    return Stack(
      children: [
        IndexedStack(
          index: 0,
          children: [
            BrowserTabView(onScroll: _onScroll),
          ],
        ),
        if (isHudVisible)
          Align(
            alignment: Alignment.topCenter,
            child: BrowserSearchBar(
              onSubmit: () => {},
            ),
          ),
        if (isHudVisible)
          Align(
            alignment: Alignment.bottomCenter,
            child: BrowserBottomMenuCommon(
              onBackPressed: () => {},
              onForwardPressed: null,
              onAddTabPressed: null,
              onTabsPressed: null,
              onOverflowPressed: null,
            ),
          ),
      ],
    );
  }

  void _onScroll({required int currentY, required int gestureDY}) {
    print('onScroll: currentY: $currentY, gestureDY: $gestureDY');
    if (currentY < _hudScrollMinYThreshold) {
      print('    onScroll: show');
      context.read<HudBloc>().add(const HudEvent.show());
    } else {
      if (gestureDY.abs() > _hudScrollDYThreshold) {
        if (gestureDY > 0) {
          print('    onScroll: hide');
          context.read<HudBloc>().add(const HudEvent.hide());
        } else {
          print('    onScroll: show');
          context.read<HudBloc>().add(const HudEvent.show());
        }
      }
    }
  }
}
