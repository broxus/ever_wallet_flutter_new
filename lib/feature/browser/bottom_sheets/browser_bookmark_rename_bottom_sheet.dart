import 'package:app/app/service/service.dart';
import 'package:app/data/models/models.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/browser/browser.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

/// Helper function to show [BrowserBookmarkRenameSheet].
ModalRoute<void> showBrowserBookmarkRenameSheet({
  required BrowserBookmarkItem item,
  TextStyle? titleTextStyle,
}) {
  return commonBottomSheetRoute(
    title: LocaleKeys.browserBookmarkRenameEnterName.tr(),
    titleTextStyle: titleTextStyle,
    titleMargin: const EdgeInsets.only(
      top: DimensSizeV2.d32,
      bottom: DimensSizeV2.d24,
      left: DimensSizeV2.d16,
      right: DimensSizeV2.d16,
    ),
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
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BrowserBookmarksBloc>(
      create: (context) => BrowserBookmarksBloc(
        inject(),
      ),
      child: Builder(
        builder: (context) {
          return SeparatedColumn(
            mainAxisSize: MainAxisSize.min,
            separatorSize: DimensSizeV2.d24,
            children: [
              PrimaryTextField(
                textEditingController: _nameController,
                hintText: LocaleKeys.browserBookmarkRenameName.tr(),
                onSubmit: (_) => _onRename(context),
              ),
              PrimaryButton(
                buttonShape: ButtonShape.pill,
                title: LocaleKeys.browserBookmarkRenameWord.tr(),
                onPressed: _canRename() ? () => _onRename(context) : null,
              ),
            ],
          );
        },
      ),
    );
  }

  void _onRename(BuildContext context) {
    if (_canRename()) {
      context.read<BrowserBookmarksBloc>().add(
            BrowserBookmarksEvent.setItem(
              item: widget.item.copyWith(title: _newName),
            ),
          );
    }
    Navigator.of(context).pop();
  }

  bool _canRename() {
    return _newName.isNotEmpty && _newName != widget.item.title;
  }
}
