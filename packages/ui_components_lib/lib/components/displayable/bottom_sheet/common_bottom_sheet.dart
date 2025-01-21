import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Builder for body parameter of [showCommonBottomSheet].
/// This allows get [ScrollController] of modal sheet and use it in scroll box.
typedef CommonSheetBodyBuilder = Widget Function(
  BuildContext context,
  ScrollController scrollController,
);

/// Display default bottom sheet from [context].
///
/// [title] is a text for sheet description.
/// [subtitle] is a text for sheet that displays below [title].
/// [padding] around [body].
/// [avoidBottomInsets] if opened keyboard should resize sheet, same
///   as [Scaffold.resizeToAvoidBottomInset].
/// [openFullScreen] if a [body] should be displayed for full screen.
/// [useAppBackgroundColor] if true, then [ColorsPalette.appBackground] is used
///   as sheet color, [ColorsPalette.backgroundSecondary] otherwise.
// ignore: long-method
Future<T?> showCommonBottomSheet<T>({
  required BuildContext context,
  required CommonSheetBodyBuilder body,
  String? title,
  String? subtitle,
  EdgeInsets padding = const EdgeInsets.symmetric(horizontal: DimensSizeV2.d16),
  EdgeInsets? titleMargin,
  EdgeInsets? subtitleMargin,
  bool expand = false,
  bool dismissible = true,
  bool wrapIntoAnimatedSize = true,
  bool avoidBottomInsets = true,
  bool openFullScreen = false,
  bool useRootNavigator = true,
  Color? barrierColor,
  bool useAppBackgroundColor = false,
  bool centerTitle = false,
  TextStyle? titleTextStyle,
  TextStyle? subtitleStyle,
  bool centerSubtitle = false,
}) {
  return showCustomModalBottomSheet<T>(
    expand: expand,
    context: context,
    isDismissible: dismissible,
    useRootNavigator: useRootNavigator,
    barrierColor: barrierColor ??
        Colors.black.withAlpha(
          Opac.large.toByteInt(),
        ),
    containerWidget: (context, animation, child) => _ContainerWidget(
      animated: wrapIntoAnimatedSize,
      child: child,
    ),
    builder: (_) => CommonBottomSheetWidget(
      useAppBackgroundColor: useAppBackgroundColor,
      openFullScreen: openFullScreen,
      avoidBottomInsets: avoidBottomInsets,
      padding: padding,
      subtitle: subtitle,
      title: title,
      centerTitle: centerTitle,
      centerSubtitle: centerSubtitle,
      body: body,
      titleTextStyle: titleTextStyle,
      subtitleStyle: subtitleStyle,
      titleMargin: titleMargin,
      subtitleMargin: subtitleMargin,
    ),
  );
}

/// Return route of bottom sheet, that could be used in navigator directly.
/// This route could be helpful as `Navigator.of(context)..pop()..push()`
/// action.
///
/// [title] is a text for sheet description.
/// [subtitle] is a text for sheet that displays below [title].
/// [padding] around [body].
/// [avoidBottomInsets] if opened keyboard should resize sheet, same
///   as [Scaffold.resizeToAvoidBottomInset].
/// [openFullScreen] if a [body] should be displayed for full screen.
/// [useAppBackgroundColor] if true, then [ColorsPalette.appBackground] is used
///   as sheet color, [ColorsPalette.backgroundSecondary] otherwise.
// ignore: long-method
ModalSheetRoute<T> commonBottomSheetRoute<T>({
  required CommonSheetBodyBuilder body,
  String? title,
  String? subtitle,
  EdgeInsets padding = const EdgeInsets.symmetric(horizontal: DimensSizeV2.d16),
  bool expand = false,
  bool dismissible = true,
  bool wrapIntoAnimatedSize = true,
  bool avoidBottomInsets = true,
  bool openFullScreen = false,
  Color? barrierColor,
  bool useAppBackgroundColor = false,
  bool centerTitle = false,
  TextStyle? titleTextStyle,
  TextStyle? subtitleStyle,
  EdgeInsetsGeometry? titleMargin,
  EdgeInsetsGeometry? subtitleMargin,
  bool centerSubtitle = false,
}) {
  return ModalSheetRoute<T>(
    builder: (_) => CommonBottomSheetWidget(
      useAppBackgroundColor: useAppBackgroundColor,
      openFullScreen: openFullScreen,
      avoidBottomInsets: avoidBottomInsets,
      padding: padding,
      subtitle: subtitle,
      title: title,
      body: body,
      centerTitle: centerTitle,
      titleTextStyle: titleTextStyle,
      subtitleStyle: subtitleStyle,
      titleMargin: titleMargin,
      subtitleMargin: subtitleMargin,
      centerSubtitle: centerSubtitle,
    ),
    expanded: expand,
    isDismissible: dismissible,
    modalBarrierColor: barrierColor,
    containerBuilder: (context, animation, child) => _ContainerWidget(
      animated: wrapIntoAnimatedSize,
      child: child,
    ),
  );
}

/// Widget that displays default content of bottom sheet.
class CommonBottomSheetWidget extends StatelessWidget {
  const CommonBottomSheetWidget({
    required this.body,
    required this.padding,
    required this.avoidBottomInsets,
    required this.openFullScreen,
    required this.useAppBackgroundColor,
    required this.centerTitle,
    required this.centerSubtitle,
    this.title,
    this.subtitle,
    this.titleTextStyle,
    this.subtitleStyle,
    this.titleMargin,
    this.subtitleMargin,
    super.key,
  });

  final CommonSheetBodyBuilder body;
  final String? title;
  final String? subtitle;
  final EdgeInsets padding;
  final bool avoidBottomInsets;
  final bool openFullScreen;
  final bool useAppBackgroundColor;
  final bool centerTitle;
  final TextStyle? titleTextStyle;
  final TextStyle? subtitleStyle;
  final bool centerSubtitle;
  final EdgeInsetsGeometry? titleMargin;
  final EdgeInsetsGeometry? subtitleMargin;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    final bodyWidget = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (title != null || subtitle != null)
          _Header(
            title: title,
            subtitle: subtitle,
            isCenterTitle: centerTitle,
            isCenterSubTitle: centerSubtitle,
            titleTextStyle: titleTextStyle,
            subtitleStyle: subtitleStyle,
            titleMargin: titleMargin,
            subtitleMargin: subtitleMargin,
          )
        else
          const SizedBox(height: DimensSizeV2.d32),
        Flexible(
          child: Padding(
            padding: padding,
            child: body(
              context,

              // TODO(knightforce): fix of context in build
              ModalScrollController.of(context)!,
            ),
          ),
        ),
      ],
    );

    return Material(
      color: useAppBackgroundColor
          ? theme.colors.background0
          : theme.colors.background1,
      child: SafeArea(
        minimum: avoidBottomInsets
            ? const EdgeInsets.only(bottom: DimensSizeV2.d24)
            : EdgeInsets.zero,
        child: Padding(
          padding: avoidBottomInsets
              ? MediaQuery.of(context).viewInsets
              : EdgeInsets.zero,
          child: Stack(
            children: [
              if (openFullScreen)
                Positioned.fill(child: bodyWidget)
              else
                bodyWidget,
              const Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: SheetDraggableLine(
                  height: DimensSizeV2.d4,
                  verticalMargin: DimensSizeV2.d8,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContainerWidget extends StatefulWidget {
  const _ContainerWidget({
    required this.child,
    this.animated = true,
  });

  final Widget child;
  final bool animated;

  @override
  __ContainerWidgetState createState() => __ContainerWidgetState();
}

class __ContainerWidgetState extends State<_ContainerWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + DimensSizeV2.d24,
      ),
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(DimensRadius.large),
        ),
      ),
      width: double.infinity,
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        removeBottom: true,
        child: widget.animated
            ? AnimatedSize(
                duration: kThemeAnimationDuration,
                reverseDuration: kThemeAnimationDuration,
                curve: Curves.decelerate,
                clipBehavior: Clip.none,
                alignment: Alignment.topCenter,
                child: widget.child,
              )
            : widget.child,
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    this.title,
    this.subtitle,
    this.titleTextStyle,
    this.subtitleStyle,
    this.isCenterTitle = false,
    this.isCenterSubTitle = false,
    this.titleMargin,
    this.subtitleMargin,
  });

  final String? title;
  final String? subtitle;
  final bool isCenterTitle;
  final bool isCenterSubTitle;
  final TextStyle? titleTextStyle;
  final TextStyle? subtitleStyle;
  final EdgeInsetsGeometry? titleMargin;
  final EdgeInsetsGeometry? subtitleMargin;

  static const _top = DimensSizeV2.d20 + DimensSizeV2.d4 + DimensSizeV2.d8 * 2;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    final textStyles = theme.textStyles;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Container(
            margin: titleMargin ??
                EdgeInsets.only(
                  top: _top,
                  bottom:
                      subtitle != null ? DimensSizeV2.d12 : DimensSizeV2.d24,
                  left: DimensSizeV2.d16,
                  right: DimensSizeV2.d16,
                ),
            alignment: isCenterTitle ? Alignment.center : Alignment.centerLeft,
            child: Text(
              title!,
              style: titleTextStyle ?? textStyles.headingMedium,
              textAlign: isCenterTitle ? TextAlign.center : TextAlign.start,
            ),
          ),
        if (subtitle != null)
          Container(
            margin: subtitleMargin ??
                EdgeInsets.only(
                  top: title == null ? _top : 0,
                  bottom: DimensSizeV2.d24,
                  left: DimensSizeV2.d16,
                  right: DimensSizeV2.d16,
                ),
            alignment:
                isCenterSubTitle ? Alignment.center : Alignment.centerLeft,
            child: Text(
              subtitle!,
              textAlign: isCenterSubTitle ? TextAlign.center : TextAlign.left,
              style: subtitleStyle ??
                  textStyles.paragraphMedium.copyWith(
                    color: theme.colors.content1,
                  ),
            ),
          ),
      ],
    );
  }
}
