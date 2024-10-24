import 'package:app/feature/choose_network/data/choose_network_item_data.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class ChooseNetworkItem extends StatelessWidget {
  const ChooseNetworkItem(
    this.data, {
    required this.onPressed,
    required this.isLoading,
    super.key,
  });

  final ChooseNetworkItemData data;
  final bool isLoading;
  final ValueChanged<String> onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed(data.id),
      child: PrimaryCard(
        borderRadius: BorderRadius.circular(DimensSizeV2.d24),
        margin: const EdgeInsets.only(
          left: DimensSizeV2.d16,
          right: DimensSizeV2.d16,
          bottom: DimensSizeV2.d12,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: DimensSizeV2.d12),
                    child: _Icon(data.icon),
                  ),
                  Flexible(
                    child: _Name(data.title),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: DimensSizeV2.d24),
              child: isLoading
                  ? ProgressIndicatorWidget(
                      size: DimensSizeV2.d20,
                      color: context.themeStyleV2.colors.primaryA,
                    )
                  : Icon(
                      LucideIcons.chevronRight,
                      size: DimensSizeV2.d20,
                      color: context.themeStyleV2.colors.primaryA,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Icon extends StatelessWidget {
  const _Icon(this.icon);

  final SvgGenImage icon;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.themeStyleV2.colors.background2,
        borderRadius: BorderRadius.circular(
          DimensRadiusV2.radius32,
        ),
      ),
      child: SizedBox(
        width: DimensSizeV2.d32,
        height: DimensSizeV2.d32,
        child: Center(
          child: icon.svg(
            width: DimensSizeV2.d16,
            height: DimensSizeV2.d16,
          ),
        ),
      ),
    );
  }
}

class _Name extends StatelessWidget {
  const _Name(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return PrimaryText(
      title,
      type: PrimaryTextType.titleSmall,
      textAlign: TextAlign.start,
    );
  }
}
