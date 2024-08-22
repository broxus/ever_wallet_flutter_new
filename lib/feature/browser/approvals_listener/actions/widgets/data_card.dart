import 'dart:convert';

import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class DataCard extends StatefulWidget {
  const DataCard({
    required this.data,
    super.key,
  });

  /// base64 encoded data
  final String data;

  @override
  State<DataCard> createState() => _DataCardState();
}

class _DataCardState extends State<DataCard> {
  final Map<_DisplayType, String> _converted = {};

  _DisplayType _displayType = _DisplayType.base64;

  String get data => _converted[_displayType] ??= _getDecodedData();

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return PrimaryCard(
      color: theme.colors.background2,
      borderRadius: BorderRadius.circular(DimensRadiusV2.radius12),
      padding: const EdgeInsets.all(DimensSizeV2.d16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.dataWord.tr(),
            style: theme.textStyles.labelSmall.copyWith(
              color: theme.colors.content3,
            ),
          ),
          const SizedBox(height: DimensSizeV2.d4),
          Text(
            data,
            style: theme.textStyles.labelSmall.copyWith(
              color: theme.colors.content0,
            ),
          ),
          const SizedBox(height: DimensSizeV2.d24),
          SwitcherSegmentControls<_DisplayType>(
            currentValue: _displayType,
            values: [
              PrimarySegmentControl(
                title: _DisplayType.base64.name,
                value: _DisplayType.base64,
                size: SegmentControlSize.xsmall,
                state: SegmentControlState.normal,
              ),
              PrimarySegmentControl(
                title: _DisplayType.hex.name,
                value: _DisplayType.hex,
                size: SegmentControlSize.xsmall,
                state: SegmentControlState.normal,
              ),
              PrimarySegmentControl(
                title: _DisplayType.utf8.name,
                value: _DisplayType.utf8,
                size: SegmentControlSize.xsmall,
                state: SegmentControlState.normal,
              ),
            ],
            onTabChanged: (value) => setState(() {
              _displayType = value;
            }),
          ),
        ],
      ),
    );
  }

  String _getDecodedData() => switch (_displayType) {
        _DisplayType.base64 => widget.data,
        _DisplayType.utf8 => utf8.decode(base64.decode(widget.data)),
        _DisplayType.hex => base64
            .decode(widget.data)
            .map((e) => e.toRadixString(16).padLeft(2, '0'))
            .join(),
      };
}

enum _DisplayType { base64, hex, utf8 }
