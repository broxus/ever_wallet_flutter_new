import 'package:app/generated/generated.dart';
import 'package:app/v2/feature/choose_network/data/choose_network_item_data.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class ChooseNetworkItem extends StatelessWidget {
  const ChooseNetworkItem({
    required this.id,
    required this.networkType,
    required this.onPressed,
    super.key,
  });

  final String id;
  final ChooseNetworkType networkType;
  final ValueChanged<String> onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed(id),
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
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: DimensSizeV2.d12),
                  child: _Icon(networkType),
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _Name(networkType),
                      _Description(networkType),
                    ],
                  ),
                ),
              ],
            ),
            Icon(
              LucideIcons.chevronRight,
              size: DimensSizeV2.d20,
              color: context.themeStyleV2.colors.primaryA,
            ),
          ],
        ),
      ),
    );
  }
}

class _Icon extends StatelessWidget {
  const _Icon(this.networkType);

  final ChooseNetworkType networkType;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        // TODO(knightforce): awaiting design.
        color: const Color(0xFF3C4067),
        borderRadius: BorderRadius.circular(
          DimensRadiusV2.radius32,
        ),
      ),
      child: SizedBox(
        width: DimensSizeV2.d32,
        height: DimensSizeV2.d32,
        child: Center(
          child: switch (networkType) {
            ChooseNetworkType.ever => Assets.images.everVector.svg(
                width: DimensSizeV2.d16,
                height: DimensSizeV2.d16,
              ),
            ChooseNetworkType.venom => Assets.images.venomVector.svg(
                width: DimensSizeV2.d16,
                height: DimensSizeV2.d16,
              ),
          },
        ),
      ),
    );
  }
}

class _Name extends StatelessWidget {
  const _Name(this.networkType);

  final ChooseNetworkType networkType;

  @override
  Widget build(BuildContext context) {
    return PrimaryText(
        switch (networkType) {
          ChooseNetworkType.ever => LocaleKeys.everscale.tr(),
          ChooseNetworkType.venom => LocaleKeys.venom.tr(),
        },
        type: PrimaryTextType.titleSmall,
        textAlign: TextAlign.start);
  }
}

class _Description extends StatelessWidget {
  const _Description(this.networkType);

  final ChooseNetworkType networkType;

  @override
  Widget build(BuildContext context) {
    return PrimaryText(
      switch (networkType) {
        ChooseNetworkType.ever => LocaleKeys.chooseNetworkEverDescription.tr(),
        ChooseNetworkType.venom =>
          LocaleKeys.chooseNetworkVenomDescription.tr(),
      },
      type: PrimaryTextType.descriptionSmall,
      textAlign: TextAlign.start,
    );
  }
}
