import 'package:app/feature/browser/primary/hud_bloc/hud_bloc.dart';
import 'package:app/feature/browser/primary/primary_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PrimaryPage extends StatelessWidget {
  const PrimaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HudBloc>(
      create: (context) => HudBloc(),
      child: const PrimaryView(),
    );
  }
}
