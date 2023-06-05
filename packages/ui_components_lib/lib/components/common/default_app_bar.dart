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

/// Action that is called by back leading or action buttons.
typedef DefaultAppBarCloseAction = void Function(BuildContext context);

/// Default width or height of appbar button
const appBarButtonSize = 40.0;
const appBarIconButtonInnerPadding = EdgeInsets.all(
  (appBarButtonSize - defaultCommonIconSize) / 2,
);

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
    this.centerTitle = true,
    this.titleText,
    this.subtitleTopText,
    this.subtitleBottomText,
    this.titleWidget,
    this.subtitleTopWidget,
    this.subtitleBottomWidget,
  });

  /// This is a default action of [DefaultAppBar] that is used with leading
  /// or action buttons.
  /// This field exists because of difference of navigation between story book
  /// and real application.
  ///
  /// To change behavior, just set another callback in main.dart
  static DefaultAppBarCloseAction defaultPopAction =
      (context) => Navigator.of(context).pop();

  @override
  Size get preferredSize => const Size.fromHeight(64);

  /// Color of the appbar.
  /// Default is transparent
  final Color? backgroundColor;

  /// If title, subtitleTop and subtitleBottom column should
  /// be displayed in the center of width. Default true
  final bool centerTitle;

  /// Title of the appBar, used in Text
  final String? titleText;

  /// Custom title of the appBar
  final Widget? titleWidget;

  /// Subtitle that displays above [titleText], used in Text
  final String? subtitleTopText;

  /// Subtitle widget that displays above title
  final Widget? subtitleTopWidget;

  /// Subtitle that displays under title, used in Text
  final String? subtitleBottomText;

  /// Subtitle widget that displays under title
  final Widget? subtitleBottomWidget;

  /// Text of the back button.
  /// If not specified, only icon will be used
  final String? backText;

  /// Action when closing with [CloseType.leading] or [CloseType.multi]
  final DefaultAppBarCloseAction? onClosePressed;

  /// Action when closing with [CloseType.actions] or [CloseType.multi]
  /// If not specified [onClosePressed] will be used
  final DefaultAppBarCloseAction? onActionsClosePressed;

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

  bool get _hasAnyLeading => leading != null || _showLeadingClose;

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyle.colors;
    final mq = MediaQuery.of(context);

    final title = buildTitle(colors);

    return Material(
      color: backgroundColor ?? Colors.transparent,
      borderRadius: BorderRadius.zero,
      child: Container(
        margin: EdgeInsets.only(
          top: mq.padding.top,
          left: Dimens.medium,
          right: Dimens.medium,
        ),
        height: preferredSize.height,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimens.xSmall),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    leading ??
                        (_showLeadingClose
                            ? CommonIconButton.icon(
                                innerPadding: appBarIconButtonInnerPadding,
                                icon: Icons.arrow_back_rounded,
                                buttonType: EverButtonType.secondary,
                                onPressed: () {
                                  if (onClosePressed != null) {
                                    onClosePressed!(context);
                                  } else {
                                    defaultPopAction(context);
                                  }
                                },
                              )
                            : const SizedBox(width: appBarButtonSize)),
                    if (title != null) ...[
                      const SizedBox(width: 8),
                      Expanded(child: title),
                      const SizedBox(width: 8),
                    ],
                    if (_hasAnyActions)
                      _actionsWidget(context)
                    else if (_hasAnyLeading)
                      // This button is need display appbar in the center if no
                      // actions
                      const SizedBox(width: appBarButtonSize),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _actionsWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (_hasActions) ...actions!,
        if (_showActionsClose)
          CommonButton(
            buttonType: EverButtonType.ghost,
            height: appBarButtonSize,
            child: CommonButtonIconWidget.icon(icon: Icons.close),
            onPressed: () {
              if (onActionsClosePressed != null) {
                onActionsClosePressed!(context);
              } else if (onClosePressed != null) {
                onClosePressed!(context);
              } else {
                defaultPopAction(context);
              }
            },
          ),
      ],
    );
  }

  Widget? buildTitle(ColorsPalette colors) {
    Widget? subtitleTop;
    if (subtitleTopText != null) {
      subtitleTop = Text(
        subtitleTopText!,
        style: StyleRes.addRegular.copyWith(color: colors.textSecondary),
      );
    } else if (subtitleTopWidget != null) {
      subtitleTop = subtitleTopWidget;
    }

    Widget? subtitleBottom;
    if (subtitleBottomText != null) {
      subtitleBottom = Text(
        subtitleBottomText!,
        style: StyleRes.addRegular.copyWith(color: colors.textSecondary),
      );
    } else if (subtitleBottomWidget != null) {
      subtitleBottom = subtitleBottomWidget;
    }

    Widget? title;
    if (titleText != null) {
      title = Text(
        titleText!,
        style: StyleRes.button.copyWith(color: colors.textPrimary),
      );
    } else if (titleWidget != null) {
      title = titleWidget;
    }

    Widget? anyTitle;
    if (title != null || subtitleTop != null || subtitleBottom != null) {
      anyTitle = Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment:
            centerTitle ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          if (subtitleTop != null) subtitleTop,
          if (subtitleTop != null && title != null) const SizedBox(height: 3),
          if (title != null) title,
          if (subtitleBottom != null && title != null)
            const SizedBox(height: 3),
          if (subtitleBottom != null) subtitleBottom,
        ],
      );
    }

    return anyTitle;
  }
}
