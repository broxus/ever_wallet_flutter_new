import 'package:app/data/models/models.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/browser/browser.dart';
import 'package:app/feature/browserV2/service/browser_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BrowserPage extends StatefulWidget {
  const BrowserPage({required this.child, super.key});

  final Widget child;

  @override
  State<BrowserPage> createState() => _BrowserPageState();
}

class _BrowserPageState extends State<BrowserPage> {
  final _browserService = inject<BrowserService>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BrowserTabsBloc>(
      create: (context) => BrowserTabsBloc(
        inject(),
        (item) => _onBrowserHistoryItemAdd(context, item),
        (items) => _onBrowserMultipleHistoryItemAdd(context, items),
      ),
      child: SafeArea(
        child: ApprovalsListenerWidget(
          child: BrowserView(child: widget.child),
        ),
      ),
    );
  }

  void _onBrowserHistoryItemAdd(
    BuildContext context,
    BrowserHistoryItem item,
  ) {
    _browserService.hM.addHistoryItem(item);
  }

  void _onBrowserMultipleHistoryItemAdd(
    BuildContext context,
    List<BrowserHistoryItem> items,
  ) {
    _browserService.hM.addHistoryItems(items);
  }
}
