import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ui_components_lib/components/button/app_bar_back_button.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

const defaultAppBarHeight = 72.0;

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

/// Action that is called to check if close button should be displayed.
typedef DefaultAppBarCanPopAction = bool Function(BuildContext context);

/// Default width or height of appbar button
const appBarButtonSize = DimensSizeV2.d48;

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
    this.leadingWidth = appBarButtonSize,
    this.systemOverlayStyle,
  });

  /// This is a default action of [DefaultAppBar] that is used with leading
  /// or action buttons.
  /// This field exists because of difference of navigation between story book
  /// and real application.
  ///
  /// To change behavior, just set another callback in main.dart
  // ignore: avoid-global-state
  static DefaultAppBarCloseAction defaultPopAction = (context) {
    try {
      Navigator.of(context).pop();
    } catch (_) {}
  };

  /// This is a default action of [DefaultAppBar] to check if leading
  /// close button should be displayed.
  ///
  /// To change behavior, just set another callback in main.dart
  // ignore: avoid-global-state
  static DefaultAppBarCanPopAction defaultCanPopAction = (context) {
    try {
      return Navigator.of(context).canPop();
    } catch (_) {
      return true;
    }
  };

  @override
  Size get preferredSize => const Size.fromHeight(defaultAppBarHeight);

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

  /// Width of leading widget, default [appBarButtonSize]
  final double leadingWidth;

  final SystemUiOverlayStyle? systemOverlayStyle;

  bool get _hasActions => actions?.isNotEmpty ?? false;

  bool get _hasAnyActions => _hasActions || _showActionsClose;

  bool get _showLeadingClose =>
      closeType == CloseType.leading || closeType == CloseType.multi;

  bool get _showActionsClose =>
      closeType == CloseType.actions || closeType == CloseType.multi;

  @override
  Widget build(BuildContext context) {
    final title = buildTitle(context.themeStyleV2);
    final isShowLeadingClose =
        _showLeadingClose && defaultCanPopAction(context);

    final leading = this.leading ??
        (isShowLeadingClose
            ? AppBarBackButton(
                onPressed: () => _onPressedBack(context),
              )
            : null);

    return PopCapture(
      onPop: () => _onPressedBack(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: DimensSizeV2.d16),
        child: AppBar(
          backgroundColor: backgroundColor ?? Colors.transparent,
          surfaceTintColor: Colors.transparent,
          toolbarHeight: preferredSize.height,
          elevation: 0,
          scrolledUnderElevation: 0,
          titleSpacing: DimensSize.d8,
          centerTitle: centerTitle,
          leadingWidth: isShowLeadingClose ? DimensSizeV2.d48 : leadingWidth,
          leading: leading == null
              ? null
              : Align(
                  alignment: Alignment.centerLeft,
                  child: leading,
                ),
          actions: _hasAnyActions ? _actionsWidget(context) : null,
          title: title,
          systemOverlayStyle: systemOverlayStyle,
        ),
      ),
    );
  }

  List<Widget> _actionsWidget(BuildContext context) {
    return [
      if (_hasActions)
        for (final action in actions!) Center(child: action),
      if (_showActionsClose && defaultCanPopAction(context))
        Center(
          child: CommonButton(
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
        ),
    ];
  }

  Widget? buildTitle(ThemeStyleV2 theme) {
    Widget? subtitleTop;
    if (subtitleTopText != null) {
      subtitleTop = Text(
        subtitleTopText!,
        style: theme.textStyles.labelSmall,
      );
    } else if (subtitleTopWidget != null) {
      subtitleTop = subtitleTopWidget;
    }

    Widget? subtitleBottom;
    if (subtitleBottomText != null) {
      subtitleBottom = Text(
        subtitleBottomText!,
        style: theme.textStyles.labelSmall,
      );
    } else if (subtitleBottomWidget != null) {
      subtitleBottom = subtitleBottomWidget;
    }

    Widget? title;
    if (titleText != null) {
      title = Text(
        titleText!,
        style: theme.textStyles.headingMedium,
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

  void _onPressedBack(BuildContext context) {
    if (onClosePressed != null) {
      onClosePressed!(context);
    } else {
      defaultPopAction(context);
    }
  }
}
