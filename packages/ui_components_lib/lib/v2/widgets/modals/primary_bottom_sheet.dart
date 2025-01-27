import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

Future<void> showPrimaryBottomSheet({
  required BuildContext context,
  String? assetsPath,
  String? title,
  String? subtitle,
  Widget? content,
  Widget? firstButton,
  Widget? secondButton,
  EdgeInsets padding = const EdgeInsets.symmetric(horizontal: DimensSizeV2.d16),
  bool expand = false,
  bool dismissible = true,
  bool wrapIntoAnimatedSize = true,
  bool useRootNavigator = true,
  bool showBackButton = false,
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
      content: content,
      title: title,
      assetsPath: assetsPath,
      firstButton: firstButton,
      secondButton: secondButton,
      showBackButton: showBackButton,
    ),
  );
}

class _ContentBottomSheet extends StatelessWidget {
  const _ContentBottomSheet({
    required this.padding,
    required this.showBackButton,
    this.assetsPath,
    this.title,
    this.subtitle,
    this.content,
    this.firstButton,
    this.secondButton,
  });

  final String? assetsPath;
  final String? title;
  final String? subtitle;
  final Widget? content;
  final EdgeInsets padding;
  final Widget? firstButton;
  final Widget? secondButton;
  final bool showBackButton;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    return Material(
      color: theme.colors.background1,
      child: SafeArea(
        minimum: const EdgeInsets.only(bottom: DimensSizeV2.d4),
        child: Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(color: theme.colors.background1),
                  padding: padding,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: DimensSizeV2.d16),
                      if (showBackButton)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(top: DimensSizeV2.d12),
                            child: FloatButton(
                              buttonShape: ButtonShape.circle,
                              icon: LucideIcons.arrowLeft,
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                          ),
                        ),
                      const SizedBox(height: DimensSizeV2.d40),
                      if (assetsPath != null)
                        Padding(
                          padding:
                              const EdgeInsets.only(bottom: DimensSizeV2.d16),
                          child: Image.asset(
                            assetsPath!,
                            width: DimensSizeV2.d56,
                            height: DimensSizeV2.d56,
                          ),
                        ),
                      if (title != null)
                        Padding(
                          padding:
                              const EdgeInsets.only(bottom: DimensSizeV2.d8),
                          child: Text(
                            title!,
                            style: theme.textStyles.headingLarge,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      if (subtitle != null)
                        Padding(
                          padding:
                              const EdgeInsets.only(bottom: DimensSizeV2.d24),
                          child: Text(
                            subtitle!,
                            style: theme.textStyles.paragraphMedium,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      if (content != null) content!,
                      if (firstButton != null)
                        Padding(
                          padding:
                              const EdgeInsets.only(bottom: DimensSize.d12),
                          child: firstButton,
                        ),
                      if (secondButton != null)
                        Padding(
                          padding:
                              const EdgeInsets.only(bottom: DimensSize.d12),
                          child: secondButton,
                        ),
                      const SizedBox(height: DimensSizeV2.d32),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: DimensSizeV2.d12),
                    width: DimensSizeV2.d40,
                    height: DimensSizeV2.d4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(DimensSizeV2.d2),
                      color: theme.colors.backgroundAlpha,
                    ),
                  ),
                ],
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
