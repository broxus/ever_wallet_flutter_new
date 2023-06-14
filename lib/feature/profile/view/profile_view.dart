import 'package:app/feature/profile/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          return state.when(
            initial: () => const SizedBox(),
            data: (
              seedList,
              currentSeed,
              biometryEnabled,
              biometryAvailable,
            ) =>
                const SizedBox(),
          );
        },
      ),
    );
  }
}
