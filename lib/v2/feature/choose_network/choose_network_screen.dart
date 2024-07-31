import 'package:app/v2/feature/choose_network/choose_network_screen_wm.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';

/// Network selection screen
class ChooseNetworkScreen extends ElementaryWidget<ChooseNetworkScreenWidgetModel> {
  const ChooseNetworkScreen({
    Key? key,
    WidgetModelFactory<ChooseNetworkScreenWidgetModel> wmFactory =
        defaultChooseNetworkScreenWidgetModelFactory,
  }) : super(
          wmFactory,
          key: key,
        );

  @override
  Widget build(ChooseNetworkScreenWidgetModel wm) {
    return Scaffold(
      body: Placeholder(),
    );
  }
}
