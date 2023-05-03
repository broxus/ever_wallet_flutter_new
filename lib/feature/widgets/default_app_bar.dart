import 'package:app/feature/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Type of closing screen
enum CloseType {
  /// top left arrow button
  leading,

  /// top right cross button
  actions,

  /// leading + actions
  multi,

  /// without close buttons
  none,
}

/// Default width of appbar button
const appBarButtonSize = 32.0;

/// {@template default_appbar}
/// Default appbar for authorized zone.
/// When you use that appbar, title should be displayed in other part of UI
/// {@endtemplate}
class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// {@macro default_appbar}
  const DefaultAppBar({
    this.onClosePressed,
    this.onActionsClosePressed,
    this.actions,
    this.leading,
    this.closeType = CloseType.leading,
    this.backgroundColor,
    super.key,
    this.backText,
    this.needDivider = true,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  /// Color of the appbar.
  /// Default is [ColorsPalette.backgroundPrimary]
  final Color? backgroundColor;

  /// Text of the back button.
  /// If not specified, only icon will be used
  final String? backText;

  /// Action when closing with [CloseType.leading] or [CloseType.multi]
  final VoidCallback? onClosePressed;

  /// Action when closing with [CloseType.actions] or [CloseType.multi]
  /// If not specified [onClosePressed] will be used
  final VoidCallback? onActionsClosePressed;

  /// List of actions that displayed on the right side of the appbar
  final List<Widget>? actions;

  /// Widget that displayed on the left side of the appbar.
  /// Back icon by default
  final Widget? leading;

  /// Type how to close [DefaultAppBar]
  final CloseType closeType;

  /// If divider must be displayed below appbar, default true
  final bool needDivider;

  bool get _hasActions => actions?.isNotEmpty ?? false;

  bool get _hasAnyActions => _hasActions || _showActionsClose;

  bool get _showLeadingClose =>
      closeType == CloseType.leading || closeType == CloseType.multi;

  bool get _showActionsClose =>
      closeType == CloseType.actions || closeType == CloseType.multi;

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyle.colors;
    final mq = MediaQuery.of(context);

    return Material(
      color: backgroundColor ?? colors.backgroundPrimary,
      borderRadius: BorderRadius.zero,
      child: Container(
        margin: EdgeInsets.only(top: mq.padding.top + 5),
        height: preferredSize.height,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: leading ??
                          (_showLeadingClose
                              ? CommonButton.ghostNoPadding(
                                  onPressed: onClosePressed ??
                                      () => Navigator.of(context).maybePop(),
                                  leading: CommonButtonIconWidget.icon(
                                    icon: Icons.arrow_back_ios,
                                  ),
                                  text: backText,
                                )
                              : const SizedBox(width: appBarButtonSize)),
                    ),
                    if (_hasAnyActions)
                      Flexible(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if (_hasActions) ...actions!,
                            if (_showActionsClose)
                              CommonButton.ghostNoPadding(
                                onPressed: onActionsClosePressed ??
                                    onClosePressed ??
                                    () => Navigator.of(context).maybePop(),
                                leading: CommonButtonIconWidget.icon(
                                  icon: Icons.close,
                                ),
                              )
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
            if (needDivider) const DefaultDivider(),
          ],
        ),
      ),
    );
  }
}
