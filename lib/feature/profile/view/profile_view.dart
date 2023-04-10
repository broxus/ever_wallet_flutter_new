import 'package:app/feature/profile/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Profile'),
        TextButton(
          onPressed: () => onDeleteAccount(context),
          child: const Text('Delete account'),
        ),
      ],
    );
  }

  void onDeleteAccount(BuildContext context) {
    context.read<ProfileBloc>().add(ProfileDeleteAccount());
  }
}
