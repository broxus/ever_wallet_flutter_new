import 'package:flutter/material.dart';

class BookmarksView extends StatefulWidget {
  const BookmarksView({super.key});

  @override
  State<BookmarksView> createState() => _BookmarksViewState();
}

class _BookmarksViewState extends State<BookmarksView> {
  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: Colors.lime,
      child: Center(
        child: Text('Bookmarks'),
      ),
    );
  }
}
