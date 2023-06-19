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
      )..add(const ProfileEvent.init()),
      child: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          state.whenOrNull(
            data: (currentSeed, exportedSeed) {
              if (exportedSeed != null) {
                // TODO(alex-a4): show seed dialog
              }
            },
          );
        },
        builder: (context, state) {
          return state.when(
            initial: () => const ProfileView(),
            data: (currentSeed, _) => ProfileView(currentSeed: currentSeed),
          );
        },
      ),
    );
  }
}
