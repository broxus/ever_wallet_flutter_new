import 'package:flutter/material.dart';

/// Divider with default parameters
class DefaultDivider extends StatelessWidget {
  const DefaultDivider({super.key, this.bothIndent = 0});

  final double bothIndent;

  @override
  Widget build(BuildContext context) {
    // TODO(alex-a4): add default color for authorized zone
    return Divider(
      thickness: 1,
      height: 1,
      indent: bothIndent,
      endIndent: bothIndent,
    );
  }
}
