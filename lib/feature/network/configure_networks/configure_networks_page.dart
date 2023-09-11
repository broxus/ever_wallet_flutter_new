import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/network/network.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class ConfigureNetworksPage extends StatelessWidget {
  const ConfigureNetworksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        titleText: LocaleKeys.networksWord.tr(),
      ),
      body: BlocProvider(
        create: (context) => ManageNetworksBloc(
          inject<ConnectionsStorageService>(),
        ),
        child: const ConfigureNetworksView(),
      ),
    );
  }
}
