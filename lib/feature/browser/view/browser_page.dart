import 'package:app/feature/browser/browser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BrowserPage extends StatelessWidget {
  const BrowserPage({required this.child, super.key});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BrowserTabsBlocBloc>(
      create: (context) => BrowserTabsBlocBloc(),
      child: SafeArea(
        child: BrowserView(child: child),
      ),
    );
  }
}
