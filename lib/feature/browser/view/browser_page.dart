import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/browser/browser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BrowserPage extends StatefulWidget {
  const BrowserPage({required this.child, super.key});
  final Widget child;

  @override
  State<BrowserPage> createState() => _BrowserPageState();
}

class _BrowserPageState extends State<BrowserPage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BrowserTabsBloc>(
          create: (context) => BrowserTabsBloc(
            inject<BrowserTabsStorageService>(),
          ),
        ),
        BlocProvider<BrowserHistoryBloc>(
          create: (context) => BrowserHistoryBloc(
            inject<BrowserHistoryStorageService>(),
          ),
        ),
      ],
      child: SafeArea(
        child: BrowserView(child: widget.child),
      ),
    );
  }
}
