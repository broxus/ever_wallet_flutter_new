import 'package:app/app/router/router.dart';
import 'package:app/feature/add_seed/enter_seed_phrase/cubit/enter_seed_phrase_cubit.dart';
import 'package:app/feature/add_seed/enter_seed_phrase/view/enter_seed_phrase_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// {@template enter_seed_phrase_page}
/// Starting page for seed phrase entering.
/// {@endtemplate}
class EnterSeedPhrasePage extends StatelessWidget {
  /// {@macro enter_seed_phrase_page}
  const EnterSeedPhrasePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    return BlocProvider<EnterSeedPhraseCubit>(
      create: (context) => EnterSeedPhraseCubit(
        context,
        // ignore: prefer-extracting-callbacks
        (phrase) {
          final path =
              GoRouter.of(context).routerDelegate.currentConfiguration.fullPath;
          final route = getCurrentAppRoute(fullPath: path);

          // because of automatic navigation, we may face problem with double
          // navigation here.
          if (route != AppRoute.createSeedPassword) {
            context.goFurther(
              AppRoute.createSeedPassword.pathWithData(
                queryParameters: {
                  addSeedPhraseQueryParam: phrase,
                },
              ),
              preserveQueryParams: true,
            );
          }
        },
      )..init(),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: theme.colors.background0,
          resizeToAvoidBottomInset: false,
          appBar: DefaultAppBar(
            onClosePressed: (context) => context.maybePop(),
          ),
          body: const EnterSeedPhraseView(),
        ),
      ),
    );
  }
}
