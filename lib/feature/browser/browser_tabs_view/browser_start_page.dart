import 'package:app/feature/browser/bloc/bloc.dart';
import 'package:app/feature/browser/browser_tabs_view/browser_start_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BrowserStartPage extends StatefulWidget {
  const BrowserStartPage({super.key});

  @override
  State<BrowserStartPage> createState() => _BrowserStartPageState();
}

class _BrowserStartPageState extends State<BrowserStartPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BrowserFaviconsBloc, BrowserFaviconsState>(
      builder: (context, state) {
        return const BrowserStartView();
      },
    );
  }
}
