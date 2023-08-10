import 'package:app/app/service/service.dart';
import 'package:app/data/models/models.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/browser/browser.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Helper function to show [BrowserBookmarkRenameSheet].
Future<void> showBrowserBookmarkRenameSheet({
  required BuildContext context,
  required BrowserBookmarkItem item,
}) {
  return showCommonBottomSheet(
    title: LocaleKeys.browserBookmarkRenameEnterName.tr(),
    context: context,
    body: (_, __) => BrowserBookmarkRenameSheet(
      item: item,
    ),
  );
}

class BrowserBookmarkRenameSheet extends StatefulWidget {
  const BrowserBookmarkRenameSheet({
    required this.item,
    super.key,
  });

  final BrowserBookmarkItem item;

  @override
  State<BrowserBookmarkRenameSheet> createState() =>
      _BrowserBookmarkRenameSheetState();
}

class _BrowserBookmarkRenameSheetState
    extends State<BrowserBookmarkRenameSheet> {
  final _nameController = TextEditingController();
  late String _newName;

  @override
  void initState() {
    super.initState();
    _nameController
      ..addListener(() {
        setState(() {
          _newName = _nameController.text.trim();
        });
      })
      ..text = widget.item.title;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BrowserBookmarksBloc>(
      create: (context) => BrowserBookmarksBloc(
        inject<BrowserBookmarksStorageService>(),
      ),
      child: Builder(
        builder: (context) {
          return SeparatedColumn(
            mainAxisSize: MainAxisSize.min,
            separatorSize: DimensSize.d24,
            children: [
              CommonInput(
                controller: _nameController,
                titleText: LocaleKeys.browserBookmarkRenameName.tr(),
                onSubmitted: (_) => _onRename(context),
              ),
              CommonButton.primary(
                fillWidth: true,
                onPressed: _canRename() ? () => _onRename(context) : null,
                text: LocaleKeys.browserBookmarkRenameWord.tr(),
              )
            ],
          );
        },
      ),
    );
  }

  void _onRename(BuildContext context) {
    Navigator.of(context).pop();
    if (!_canRename()) return;

    context.read<BrowserBookmarksBloc>().add(
          BrowserBookmarksEvent.setItem(
            item: widget.item.copyWith(title: _newName),
          ),
        );
  }

  bool _canRename() {
    return _newName.isNotEmpty && _newName != widget.item.title;
  }
}
