import 'package:app/feature/network/configure_networks/configure_networks_widget.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class ConfigureNetworksPage extends StatefulWidget {
  const ConfigureNetworksPage({super.key});

  @override
  State<ConfigureNetworksPage> createState() => _ConfigureNetworksPageState();
}

class _ConfigureNetworksPageState extends State<ConfigureNetworksPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        titleText: LocaleKeys.networksWord.tr(),
      ),
      body: const Padding(
        padding: EdgeInsets.all(DimensSizeV2.d16),
        child: ConfigureNetworksWidget(),
      ),
    );
  }
}
