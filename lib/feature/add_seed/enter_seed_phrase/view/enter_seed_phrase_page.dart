import 'package:app/app/router/router.dart';
import 'package:app/feature/add_seed/enter_seed_phrase/cubit/enter_seed_phrase_cubit.dart';
import 'package:app/feature/add_seed/enter_seed_phrase/view/enter_seed_phrase_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

final _log = Logger('EnterSeedPhraseCubit');

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
          _log.severe('!!! confirmAction EnterSeedPhrasePage callback');
          final path =
              GoRouter.of(context).routerDelegate.currentConfiguration.fullPath;

          _log.severe('!!! confirmAction EnterSeedPhrasePage path');
          final route = getCurrentAppRoute(fullPath: path);
          _log.severe('!!! confirmAction EnterSeedPhrasePage route');
          // because of automatic navigation, we may face problem with double
          // navigation here.
          if (route != AppRoute.createSeedPassword) {
            _log.severe('!!! confirmAction EnterSeedPhrasePage router exist');
            context.goFurther(
              AppRoute.createSeedPassword.pathWithData(
                queryParameters: {
                  addSeedPhraseQueryParam: phrase,
                },
              ),
              preserveQueryParams: true,
            );
            _log.severe('!!! confirmAction EnterSeedPhrasePage go');
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
