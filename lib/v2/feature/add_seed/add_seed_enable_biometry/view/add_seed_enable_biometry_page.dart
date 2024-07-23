import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:app/v2/feature/add_seed/add_seed_enable_biometry/add_seed_enable_biometry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// This is a helper page that allows enable biometry after adding seed from
/// onboarding page.
///
/// Displaying this page means, that biometry is available on device and NOT
/// ENABLED.
///
/// This is a fake enabling biometry for seed, because it's difficult to provide
/// it here, so password should be stored after creating, here we just enable it
class AddSeedEnableBiometryPage extends StatelessWidget {
  const AddSeedEnableBiometryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.only(bottom: DimensSize.d16),
      child: Scaffold(
        body: BlocProvider<AddSeedEnableBiometryCubit>(
          create: (_) => AddSeedEnableBiometryCubit(
            inject<BiometryService>(),
            inject<NekotonRepository>(),
          )..init(),
          child: BlocConsumer<AddSeedEnableBiometryCubit,
              AddSeedEnableBiometryState>(
            listener: (context, state) => state.whenOrNull(
              completed: () => context.pop(),
            ),
            builder: (context, state) {
              return state.when(
                completed: () => const SizedBox.shrink(),
                init: () => const SizedBox.shrink(),
                ask: (isFace) => Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: DimensSize.d16),
                  child: AddSeedEnableBiometryView(isFace: isFace),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
