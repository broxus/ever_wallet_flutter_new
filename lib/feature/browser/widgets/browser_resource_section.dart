import 'package:app/feature/browserV2/widgets/browser_resource_item/browser_resource_item.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class BrowserResourceSection extends StatelessWidget {
  const BrowserResourceSection({
    this.titleText,
    this.subTitleText,
    this.faviconUri,
    this.onPressed,
    this.onLongPress,
    this.trailing,
    this.postfix,
    this.padding,
    super.key,
  });

  final String? titleText;
  final Uri? faviconUri;
  final String? subTitleText;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final EdgeInsets? padding;
  final Widget? trailing;
  final Widget? postfix;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: DimensSizeV2.d8,
        left: DimensSize.d16,
        right: DimensSize.d16,
      ),
      child: Row(
        children: [
          Expanded(
            child: BrowserResourceItem(
              faviconUri: faviconUri,
              title: titleText,
              subTitle: subTitleText,
              trailing: trailing,
              padding: padding ??
                  const EdgeInsets.symmetric(
                    vertical: DimensSizeV2.d8,
                    horizontal: DimensSizeV2.d16,
                  ),
              onPressed: onPressed,
            ),
          ),
          if (postfix != null) postfix!,
        ],
      ),
    );
  }
}
