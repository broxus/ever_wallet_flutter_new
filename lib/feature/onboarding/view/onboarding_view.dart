import 'package:app/di/di.dart';
import 'package:app/feature/onboarding/bloc/onboarding_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: StreamBuilder<bool>(
        stream: inject<NekotonRepository>().accountsStream,
        builder: (context, snapshot) {
          return Column(
            children: [
              const Text('Onboarding'),
              TextButton(
                onPressed: () => onAddAccount(context),
                child: const Text('Add account'),
              ),
              TextButton(
                onPressed: () => onDeleteAccount(context),
                child: const Text('Delete account'),
              ),
              Text('account: ${snapshot.data}'),
            ],
          );
        },
      ),
    );
  }

  void onAddAccount(BuildContext context) {
    context.read<OnboardingBloc>().add(OnboardingAddAccount());
  }

  void onDeleteAccount(BuildContext context) {
    context.read<OnboardingBloc>().add(OnboardingDeleteAccount());
  }
}
