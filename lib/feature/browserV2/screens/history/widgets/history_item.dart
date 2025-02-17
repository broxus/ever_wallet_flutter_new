import 'package:app/feature/browser/widgets/browser_resource_section.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class HistoryItem extends StatelessWidget {
  const HistoryItem({
    required this.id,
    required this.url,
    required this.title,
    required this.subTitleText,
    required this.isEditing,
    required this.onPressed,
    required this.onPressedPostfix,
    super.key,
  });

  final String id;
  final Uri url;
  final String title;
  final String subTitleText;
  final bool isEditing;
  final VoidCallback onPressed;
  final VoidCallback onPressedPostfix;

  @override
  Widget build(BuildContext context) {
    return BrowserResourceSection(
      faviconUri: url,
      titleText: title,
      subTitleText: subTitleText,
      trailing: SvgPicture.asset(
        Assets.images.caretRight.path,
        width: DimensSizeV2.d20,
        height: DimensSizeV2.d20,
        colorFilter: context.themeStyleV2.colors.content0.colorFilter,
      ),
      postfix: isEditing
          ? Padding(
              padding: const EdgeInsets.only(left: DimensSizeV2.d4),
              child: GhostButton(
                buttonShape: ButtonShape.circle,
                icon: LucideIcons.trash2,
                onPressed: onPressedPostfix,
              ),
            )
          : null,
      onPressed: onPressed,
    );
  }
}
