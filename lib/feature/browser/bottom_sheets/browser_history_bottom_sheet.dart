import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

typedef OnClearPressedCallback = void Function({
  required bool clearHistory,
  required bool clearCookies,
  required bool clearCache,
});

/// Helper function to show [BrowserHistorySheet].
Future<void> showBrowserHistorySheet({
  required BuildContext context,
  required bool clearHistoryEnabled,
  required OnClearPressedCallback onClearPressed,
}) {
  return showCommonBottomSheet(
    title: LocaleKeys.browserHistoryClear.tr(),
    context: context,
    body: (_, __) => BrowserHistorySheet(
      clearHistoryEnabled: clearHistoryEnabled,
      onClearPressed: onClearPressed,
    ),
  );
}

class BrowserHistorySheet extends StatefulWidget {
  const BrowserHistorySheet({
    required this.clearHistoryEnabled,
    required this.onClearPressed,
    super.key,
  });

  final bool clearHistoryEnabled;
  final OnClearPressedCallback onClearPressed;

  @override
  State<BrowserHistorySheet> createState() => _BrowserHistorySheetState();
}

class _BrowserHistorySheetState extends State<BrowserHistorySheet> {
  bool _clearHistory = true;
  bool _clearCookies = false;
  bool _clearCache = false;

  @override
  Widget build(BuildContext context) {
    final clearEnabled = (_clearHistory && widget.clearHistoryEnabled) ||
        _clearCookies ||
        _clearCache;

    return SeparatedColumn(
      mainAxisSize: MainAxisSize.min,
      separator: const CommonDivider(),
      children: [
        CommonListTile(
          titleText: LocaleKeys.browserHistory.tr(),
          subtitleText: LocaleKeys.browserClearHistory.tr(),
          leading: CommonBackgroundedIconWidget.svg(
            svg: Assets.images.historyFill.path,
          ),
          trailing: CommonCheckboxInput(
            checked: _clearHistory && widget.clearHistoryEnabled,
            onChanged: widget.clearHistoryEnabled
                ? (value) => setState(
                      () => _clearHistory = value,
                    )
                : null,
          ),
          onPressed: widget.clearHistoryEnabled
              ? () {
                  setState(() => _clearHistory = !_clearHistory);
                }
              : null,
        ),
        CommonListTile(
          titleText: LocaleKeys.browserClearCookies.tr(),
          subtitleText: LocaleKeys.browserClearCookiesDescription.tr(),
          leading: CommonBackgroundedIconWidget.svg(
            svg: Assets.images.key.path,
          ),
          trailing: CommonCheckboxInput(
            checked: _clearCookies,
            onChanged: (value) {
              setState(() => _clearCookies = value);
            },
          ),
          onPressed: () {
            setState(() => _clearCookies = !_clearCookies);
          },
        ),
        CommonListTile(
          titleText: LocaleKeys.browserClearCache.tr(),
          leading: CommonBackgroundedIconWidget.svg(
            svg: Assets.images.camera.path,
          ),
          trailing: CommonCheckboxInput(
            checked: _clearCache,
            onChanged: (value) {
              setState(() => _clearCache = value);
            },
          ),
          onPressed: () {
            setState(() => _clearCache = !_clearCache);
          },
        ),
        CommonButton.primary(
          text: LocaleKeys.browserHistoryClear.tr(),
          onPressed: clearEnabled ? _onClearPressed : null,
          fillWidth: true,
        ),
      ],
    );
  }

  void _onClearPressed() {
    widget.onClearPressed(
      clearHistory: _clearHistory,
      clearCookies: _clearCookies,
      clearCache: _clearCache,
    );
    Navigator.of(context).pop();
  }
}
