import 'package:app/app/router/app_route.dart';
import 'package:app/data/models/seed/seed_phrase_model.dart';
import 'package:app/feature/add_seed/create_password/create_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

typedef _Cubit = CreateSeedPasswordCubit;

/// {@template create_seed_password_profile_page}
/// Entry point to create seed password from profile.
/// {@endtemplate}
class CreateSeedPasswordProfilePage extends StatelessWidget {
  /// {@macro create_seed_password_profile_page}
  const CreateSeedPasswordProfilePage({
    required this.name,
    required this.seedPhrase,
    super.key,
  });

  final SeedPhraseModel seedPhrase;
  final String? name;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateSeedPasswordCubit>(
      create: (context) => CreateSeedPasswordCubit(
        seedPhrase: seedPhrase,
        name: name,
        // When we do this flow from profile, navigate to profile root
        completeCallback: () =>
            context.goNamed(AppRoute.manageSeedsAccounts.name),
      ),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: DefaultAppBar(
            onClosePressed: (context) => context.maybePop(),
          ),
          body: Builder(
            builder: (context) {
              final cubit = context.read<_Cubit>();

              return BlocBuilder<_Cubit, CreateSeedPasswordState>(
                builder: (context, state) {
                  return CreateSeedPasswordView(
                    needBiometryIfPossible: false,
                    passwordController: cubit.passwordController,
                    confirmController: cubit.confirmController,
                    onPressedNext: () => cubit.nextAction(context),
                    passwordStatus: state.status,
                    isLoading: state.isLoading,
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
