import 'package:app/feature/browser/browser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class BookmarksView extends StatefulWidget {
  const BookmarksView({super.key});

  @override
  State<BookmarksView> createState() => _BookmarksViewState();
}

class _BookmarksViewState extends State<BookmarksView> {
  final _scrollController = ScrollController();
  bool _showTopDivider = false;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(
      () {
        final showTopDivider = _scrollController.position.pixels > 0;
        if (showTopDivider != _showTopDivider) {
          setState(() {
            _showTopDivider = showTopDivider;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyle.colors;

    final isEditing = context.watch<BrowserBookmarksBloc>().getSortedItems();
    final items = context.watch<BrowserBookmarksBloc>().state.items;

    return const ColoredBox(
      color: Colors.lime,
      child: Center(
        child: Text('Bookmarks'),
      ),
    );
  }
}
