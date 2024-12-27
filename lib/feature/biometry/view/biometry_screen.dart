import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/biometry/cubit/biometry_cubit.dart';
import 'package:app/feature/biometry/view/biometry_view.dart';
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
class BiometryScreen extends StatelessWidget {
  const BiometryScreen({
    super.key,
    this.onCompleted,
    this.onClose,
  });

  final VoidCallback? onCompleted;
  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    final themeStyle = context.themeStyleV2;
    return PopCapture(
      onPop: onClose ?? context.pop,
      child: Scaffold(
        backgroundColor: themeStyle.colors.background0,
        body: BlocProvider<BiometryCubit>(
          create: (_) => BiometryCubit(
            inject<BiometryService>(),
            inject<NekotonRepository>(),
          )..init(),
          child: BlocConsumer<BiometryCubit, BiometryState>(
            listener: (context, state) => state.whenOrNull(
              completed: onCompleted ?? () => context.pop(),
            ),
            builder: (context, state) {
              return state.when(
                completed: () => const SizedBox.shrink(),
                init: () => const SizedBox.shrink(),
                ask: (isFace) => Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: DimensSize.d16),
                  child: BiometryView(
                    isFace: isFace,
                    onClose: onClose,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
