import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/dimens_v2.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

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
    titleTextStyle: context.themeStyleV2.textStyles.headingLarge,
    context: context,
    body: (_, __) => BrowserHistorySheet(
      clearHistoryEnabled: clearHistoryEnabled,
      onClearPressed: onClearPressed,
    ),
    titleMargin: const EdgeInsets.only(
      top: DimensSizeV2.d32,
      bottom: DimensSizeV2.d12,
      left: DimensSizeV2.d16,
      right: DimensSizeV2.d16,
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

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _Item(
          titleText: LocaleKeys.browserHistory.tr(),
          subtitleText: LocaleKeys.browserClearHistory.tr(),
          svgUri: Assets.images.historyFill.path,
          isSelected: _clearHistory && widget.clearHistoryEnabled,
          onPressed: widget.clearHistoryEnabled
              ? () {
                  setState(() => _clearHistory = !_clearHistory);
                }
              : null,
        ),
        const _Divider(),
        _Item(
          titleText: LocaleKeys.browserClearCookies.tr(),
          subtitleText: LocaleKeys.browserClearCookiesDescription.tr(),
          svgUri: Assets.images.key.path,
          isSelected: _clearCookies,
          onPressed: () {
            setState(() => _clearCookies = !_clearCookies);
          },
        ),
        const _Divider(),
        _Item(
          titleText: LocaleKeys.browserClearCache.tr(),
          svgUri: Assets.images.camera.path,
          isSelected: _clearCache,
          onPressed: () {
            setState(() => _clearCache = !_clearCache);
          },
        ),
        const SizedBox(height: DimensSizeV2.d24),
        PrimaryButton(
          buttonShape: ButtonShape.pill,
          title: LocaleKeys.browserHistoryClear.tr(),
          onPressed: clearEnabled ? _onClearPressed : null,
        ),
        const SizedBox(height: DimensSizeV2.d16),
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

class _Item extends StatelessWidget {
  const _Item({
    required this.titleText,
    required this.svgUri,
    this.subtitleText,
    this.onPressed,
    this.isSelected = false,
  });

  final String titleText;
  final String? subtitleText;
  final String svgUri;
  final VoidCallback? onPressed;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final color = context.themeStyleV2.colors;

    return CommonListTile(
      titleText: titleText,
      subtitleText: subtitleText,
      padding: EdgeInsets.zero,
      height: null,
      leading: CommonBackgroundedIconWidget.svg(
        svg: svgUri,
        backgroundColor: color.backgroundAlpha,
        iconColor: color.content0,
      ),
      trailing: CommonCheckbox(
        checked: isSelected,
        color: Colors.white,
      ),
      onPressed: onPressed,
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: DimensSizeV2.d16),
      child: CommonDivider(),
    );
  }
}
