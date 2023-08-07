import 'package:app/feature/browser/browser.dart';
import 'package:app/feature/browser/history/history_view.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        titleText: LocaleKeys.browserHistory.tr(),
      ),
      body: BlocBuilder<BrowserHistoryBloc, BrowserHistoryState>(
        builder: (context, state) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: const HistoryView(),
          );
        },
      ),
    );
  }
}
