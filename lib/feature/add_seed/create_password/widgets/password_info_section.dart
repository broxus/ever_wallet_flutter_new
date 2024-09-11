import 'package:app/feature/add_seed/create_password/model/password_status.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class PasswordInfoSection extends StatelessWidget {
  const PasswordInfoSection({
    required this.themeStyle,
    required this.status,
    super.key,
  });

  final ThemeStyleV2 themeStyle;
  final PasswordStatus status;

  @override
  Widget build(BuildContext context) {
    final icon = status.svgUriIcon;
    final title = status.title;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (icon != null)
              SvgPicture.asset(
                icon,
                width: DimensSizeV2.d16,
              ),
            const SizedBox(width: DimensSizeV2.d6),
            if (title != null)
              Text(
                title,
                style: themeStyle.textStyles.labelXSmall.copyWith(
                  color: status == PasswordStatus.match
                      ? themeStyle.colors.contentPositive
                      : themeStyle.colors.contentNegative,
                ),
              ),
          ],
        ),
        const SizedBox(height: DimensSizeV2.d8),
        Text(
          status.subtitle,
          style: themeStyle.textStyles.paragraphXSmall,
        ),
      ],
    );
  }
}
