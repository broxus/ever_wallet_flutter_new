import 'package:app/app/router/router.dart';
import 'package:app/data/models/seed/seed_phrase_model.dart';
import 'package:app/v1/feature/add_seed/create_seed/create_seed.dart';
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
          checkCallback: (SeedPhraseModel seed) {
            context.goFurther(
              AppRoute.checkSeed.pathWithData(
                queryParameters: {addSeedPhraseQueryParam: seed.phrase},
              ),
              preserveQueryParams: true,
            );
          },
          // ignore: prefer-extracting-callbacks
          skipCallback: (SeedPhraseModel seed) {
            context.goFurther(
              AppRoute.createSeedPassword.pathWithData(
                queryParameters: {addSeedPhraseQueryParam: seed.phrase},
              ),
              preserveQueryParams: true,
            );
          },
        ),
      ),
    );
  }
}
