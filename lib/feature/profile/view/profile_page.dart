import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/profile/bloc/profile_bloc.dart';
import 'package:app/feature/profile/view/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// Root widget for profile section of app
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc(
        inject<NekotonRepository>(),
        inject<CurrentSeedService>(),
        inject<BiometryService>(),
      )..add(const ProfileEvent.init()),
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          return state.when(
            initial: () => const ProfileView(),
            data: (
              currentSeed,
              isBiometryAvailable,
            ) =>
                ProfileView(
              currentSeed: currentSeed,
              isBiometryAvailable: isBiometryAvailable,
            ),
          );
        },
      ),
    );
  }
}
