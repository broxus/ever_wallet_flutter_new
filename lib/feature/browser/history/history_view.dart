import 'package:app/data/models/models.dart';
import 'package:app/feature/browser/browser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  @override
  Widget build(BuildContext context) {
    final items = context.watch<BrowserHistoryBloc>().state.items;
    return CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          floating: true,
          delegate: SearchBarHeaderDelegate(),
        ),
        SliverList.builder(
          itemCount: items.length,
          itemBuilder: (_, index) => _itemBuilder(items[index]),
        ),
      ],
    );
  }

  Widget? _itemBuilder(BrowserHistoryItem item) {
    return Text(item.title);
  }
}
