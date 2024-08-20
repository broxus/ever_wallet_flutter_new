import 'package:app/generated/generated.dart';
import 'package:flutter/widgets.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class ExpandableCard extends StatefulWidget {
  const ExpandableCard({
    required this.collapsedHeight,
    required this.child,
    super.key,
  });

  final double collapsedHeight;
  final Widget? child;

  @override
  State<ExpandableCard> createState() => _ExpandableCardState();
}

class _ExpandableCardState extends State<ExpandableCard> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    const padding = DimensSizeV2.d16;
    const btnSize = DimensSizeV2.d48;

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: expanded ? double.infinity : widget.collapsedHeight,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(DimensRadiusV2.radius12),
        child: Stack(
          children: [
            PrimaryCard(
              color: theme.colors.background2,
              borderRadius: BorderRadius.circular(DimensRadiusV2.radius12),
              padding: const EdgeInsets.all(padding),
              child: Padding(
                padding: expanded
                    ? const EdgeInsets.only(bottom: btnSize + padding)
                    : EdgeInsets.zero,
                child: widget.child,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  if (!expanded)
                    Container(
                      height: 136,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [Color(0xff353960), Color(0x00353960)],
                        ),
                      ),
                    ),
                  Container(
                    color: theme.colors.background2,
                    padding: const EdgeInsets.all(padding),
                    child: GhostButton(
                      buttonShape: ButtonShape.pill,
                      buttonSize: ButtonSize.small,
                      title: expanded
                          ? LocaleKeys.collapse.tr()
                          : LocaleKeys.expand.tr(),
                      postfixIcon: expanded
                          ? LucideIcons.chevronUp
                          : LucideIcons.chevronDown,
                      onPressed: onToggle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onToggle() => setState(() {
        expanded = !expanded;
      });
}
