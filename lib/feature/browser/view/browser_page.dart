import 'package:app/app/service/service.dart';
import 'package:app/data/models/models.dart';
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
        BlocProvider<BrowserHistoryBloc>(
          create: (context) => BrowserHistoryBloc(
            inject(),
          ),
        ),
        BlocProvider<BrowserBookmarksBloc>(
          create: (context) => BrowserBookmarksBloc(
            inject(),
          ),
        ),
        BlocProvider<BrowserFaviconsBloc>(
          create: (context) => BrowserFaviconsBloc(
            inject(),
          ),
        ),
      ],
      child: BlocProvider<BrowserTabsBloc>(
        create: (context) => BrowserTabsBloc(
          inject<BrowserTabsStorageService>(),
          (item) => _onBrowserHistoryItemAdd(context, item),
          (items) => _onBrowserMultipleHistoryItemAdd(context, items),
        ),
        child: SafeArea(
          child: ApprovalsListenerWidget(
            child: BrowserView(child: widget.child),
          ),
        ),
      ),
    );
  }

  void _onBrowserHistoryItemAdd(
    BuildContext context,
    BrowserHistoryItem item,
  ) {
    context.read<BrowserHistoryBloc>().add(
          BrowserHistoryEvent.add(item: item),
        );
  }

  void _onBrowserMultipleHistoryItemAdd(
    BuildContext context,
    List<BrowserHistoryItem> items,
  ) {
    context.read<BrowserHistoryBloc>().add(
          BrowserHistoryEvent.addMultiple(items: items),
        );
  }
}
