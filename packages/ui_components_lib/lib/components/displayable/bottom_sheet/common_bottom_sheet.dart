import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/dimens_v2.dart';

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
}) {
  return showCustomModalBottomSheet<T>(
    expand: expand,
    context: context,
    isDismissible: dismissible,
    useRootNavigator: useRootNavigator,
    barrierColor: barrierColor ?? Colors.black.withOpacity(Opac.large),
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
      body: body,
      titleTextStyle: titleTextStyle,
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
    this.title,
    this.subtitle,
    this.titleTextStyle,
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

  @override
  Widget build(BuildContext context) {
    const dragWidgetSize = DimensSizeV2.d4;
    const dragWidgetMargin = DimensSizeV2.d8;
    final theme = context.themeStyleV2;

    final bodyWidget = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (title != null)
          Container(
            margin: const EdgeInsets.symmetric(horizontal: DimensSizeV2.d16) +
                EdgeInsets.only(
                  top: DimensSizeV2.d20 + dragWidgetSize + dragWidgetMargin * 2,
                  bottom:
                      subtitle != null ? DimensSizeV2.d12 : DimensSizeV2.d24,
                ),
            child: Align(
              alignment: centerTitle ? Alignment.center : Alignment.centerLeft,
              child: Text(
                title!,
                style: titleTextStyle ?? theme.textStyles.headingMedium,
                textAlign: centerTitle ? TextAlign.center : TextAlign.start,
              ),
            ),
          ),
        if (subtitle != null)
          Container(
            margin: const EdgeInsets.symmetric(horizontal: DimensSizeV2.d16) +
                EdgeInsets.only(
                  bottom: DimensSizeV2.d24,
                  top: title == null
                      ? DimensSizeV2.d20 + dragWidgetSize + dragWidgetMargin * 2
                      : 0,
                ),
            child: Text(
              subtitle!,
              style: theme.textStyles.paragraphMedium.copyWith(
                color: theme.colors.content1,
              ),
            ),
          ),
        Flexible(
          child: Padding(
            padding: padding,
            child: body(
              context,
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
                  height: dragWidgetSize,
                  verticalMargin: dragWidgetMargin,
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
