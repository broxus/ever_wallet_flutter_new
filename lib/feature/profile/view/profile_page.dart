import 'package:app/feature/profile/bloc/profile_bloc.dart';
import 'package:app/feature/profile/view/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Root widget for profile section of app
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc()..add(const ProfileEvent.init()),
      child: const ProfileView(),
    );
  }
}
