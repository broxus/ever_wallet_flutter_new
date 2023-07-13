import 'package:app/feature/browser/browser.dart';
import 'package:app/feature/browser/view/browser_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BrowserPage extends StatelessWidget {
  const BrowserPage({required this.child, super.key});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BrowserBloc>(
      create: (context) => BrowserBloc(),
      child: BrowserView(child: child),
    );
  }
}
