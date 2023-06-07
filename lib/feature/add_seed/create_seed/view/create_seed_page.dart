import 'package:app/app/router/app_route.dart';
import 'package:app/feature/add_seed/create_password/create_password.dart';
import 'package:app/feature/add_seed/create_seed/create_seed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// {@template create_seed_page}
/// Starting page for seed creation.
/// {@endtemplate}
class CreateSeedPage extends StatelessWidget {
  /// {@macro create_seed_page}
  const CreateSeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateSeedCubit>(
      create: (_) => CreateSeedCubit()..init(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const DefaultAppBar(),
        body: CreateSeedView(
          // ignore: prefer-extracting-callbacks
          checkCallback: (List<String> phrase) {
            context.goFurther(
              AppRoute.checkSeed.path,
              extra: CreateSeedRouteExtra(phrase: phrase),
            );
          },
          // ignore: prefer-extracting-callbacks
          skipCallback: (List<String> phrase) {
            context.goFurther(
              AppRoute.createSeedPassword.path,
              extra: CreateSeedRouteExtra(phrase: phrase),
            );
          },
        ),
      ),
    );
  }
}
