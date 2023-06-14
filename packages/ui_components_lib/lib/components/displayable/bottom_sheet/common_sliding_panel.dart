import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:sliding_up_panel2/sliding_up_panel2.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

const defaultMinHeight = 150.0;
const defaultMinHeightSizePercent = 0.3;
const defaultMaxHeight = 500.0;
const defaultMaxHeightSizePercent = 0.7;

/// Builder for panel item that allows use [ScrollController].
typedef CommonSlidingPanelBuilder = Widget Function(
  BuildContext context,
  ScrollController controller,
);

/// This is a wrapper widget above [SlidingUpPanel] with default behavior.
class CommonSlidingPanel extends StatefulWidget {
  const CommonSlidingPanel({
    required this.panelBuilder,
    required this.body,
    this.maxHeightSizePercent = defaultMaxHeightSizePercent,
    this.maxHeight = defaultMaxHeight,
    this.minHeightSizePercent = defaultMinHeightSizePercent,
    this.minHeight = defaultMinHeight,
    super.key,
    this.scrollController,
  });

  /// See [SlidingUpPanel.panelBuilder]
  final CommonSlidingPanelBuilder panelBuilder;

  /// See [SlidingUpPanel.body]
  final Widget body;

  /// This is a percent of real screen size, that allows set
  /// [SlidingUpPanel.maxHeight] in comparing with [maxHeight].
  ///
  /// Apply max value of [maxHeight] and [maxHeightSizePercent]
  final double maxHeightSizePercent;

  /// Max height in pixels of panel, it compares with [maxHeightSizePercent].
  ///
  /// Apply max value of [maxHeight] and [maxHeightSizePercent]
  final double maxHeight;

  /// This is a percent of real screen size, that allows set
  /// [SlidingUpPanel.minHeight] in comparing with [minHeight].
  ///
  /// Apply max value of [minHeight] and [minHeightSizePercent]
  final double minHeightSizePercent;

  /// Min height in pixels of panel, it compares with [minHeightSizePercent].
  ///
  /// Apply max value of [minHeight] and [minHeightSizePercent]
  final double minHeight;

  /// Scroll that will be used inside [SlidingUpPanel] and same scroll
  /// will be provided to [panelBuilder].
  ///
  /// If not provided, widget creates custom one.
  final ScrollController? scrollController;

  @override
  State<CommonSlidingPanel> createState() => _CommonSlidingPanelState();
}

class _CommonSlidingPanelState extends State<CommonSlidingPanel> {
  late ScrollController controller;
  bool _internal = true;

  @override
  void initState() {
    super.initState();
    controller = widget.scrollController ?? ScrollController();
    if (widget.scrollController != null) _internal = false;
  }

  @override
  void dispose() {
    if (_internal) controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final colors = context.themeStyle.colors;

    return SlidingUpPanel(
      scrollController: controller,
      minHeight:
          math.max(size.height * widget.minHeightSizePercent, widget.minHeight),
      maxHeight:
          math.max(size.height * widget.maxHeightSizePercent, widget.maxHeight),
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(DimensRadius.large),
      ),
      color: colors.backgroundSecondary,
      // ignore: prefer-extracting-callbacks
      panelBuilder: () {
        return Material(
          color: Colors.transparent,
          child: Column(
            children: [
              const SheetDraggableLine(
                height: DimensSize.d4,
                verticalMargin: DimensSize.d8,
              ),
              const SizedBox(height: DimensSize.d12),
              Expanded(child: widget.panelBuilder(context, controller)),
            ],
          ),
        );
      },
      body: widget.body,
    );
  }
}
