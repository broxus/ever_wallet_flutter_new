import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

Future<void> showPrimaryBottomSheet({
  required BuildContext context,
  String? assetsPath,
  String? title,
  String? subtitle,
  BaseButton? firstButton,
  BaseButton? secondButton,
  EdgeInsets padding = const EdgeInsets.symmetric(horizontal: DimensSizeV2.d16),
  bool expand = false,
  bool dismissible = true,
  bool wrapIntoAnimatedSize = true,
  bool useRootNavigator = true,
}) {
  return showCustomModalBottomSheet(
    expand: expand,
    context: context,
    isDismissible: dismissible,
    useRootNavigator: useRootNavigator,
    containerWidget: (context, animation, child) => _ContainerWidget(
      animated: wrapIntoAnimatedSize,
      child: child,
    ),
    builder: (_) => _ContentBottomSheet(
      padding: padding,
      subtitle: subtitle,
      title: title,
      assetsPath: assetsPath,
      firstButton: firstButton,
      secondButton: secondButton,
    ),
  );
}

class _ContentBottomSheet extends StatelessWidget {
  const _ContentBottomSheet({
    required this.padding,
    this.assetsPath,
    this.title,
    this.subtitle,
    this.firstButton,
    this.secondButton,
  });

  final String? assetsPath;
  final String? title;
  final String? subtitle;
  final EdgeInsets padding;
  final BaseButton? firstButton;
  final BaseButton? secondButton;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    return Material(
      child: Container(
        decoration: BoxDecoration(color: theme.colors.background1),
        padding: padding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: DimensSizeV2.d56),
            if (assetsPath != null)
              Padding(
                padding: const EdgeInsets.only(bottom: DimensSizeV2.d16),
                child: Image.asset(
                  assetsPath!,
                  width: DimensSizeV2.d56,
                  height: DimensSizeV2.d56,
                ),
              ),
            if (title != null)
              Padding(
                padding: const EdgeInsets.only(bottom: DimensSizeV2.d8),
                child: Text(
                  title!,
                  style: theme.textStyles.headingLarge,
                ),
              ),
            if (subtitle != null)
              Padding(
                padding: const EdgeInsets.only(bottom: DimensSizeV2.d24),
                child: Text(
                  subtitle!,
                  style: theme.textStyles.paragraphMedium,
                  textAlign: TextAlign.center,
                ),
              ),
            if (firstButton != null)
              Padding(
                padding: const EdgeInsets.only(bottom: DimensSize.d12),
                child: firstButton,
              ),
            if (secondButton != null)
              Padding(
                padding: const EdgeInsets.only(bottom: DimensSize.d12),
                child: secondButton,
              ),
            const SizedBox(height: DimensSizeV2.d32),
          ],
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
