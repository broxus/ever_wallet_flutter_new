import 'package:flutter/material.dart';
import 'package:ui_components_lib/v2/utils/state_mixins.dart';

class AdaptiveFooterSingleChildScrollView extends StatefulWidget {
  const AdaptiveFooterSingleChildScrollView({
    required this.child,
    this.footer,
    this.scrollController,
    super.key,
  });

  final Widget child;

  final Widget? footer;

  final ScrollController? scrollController;

  @override
  State<AdaptiveFooterSingleChildScrollView> createState() =>
      _AdaptiveFooterSingleChildScrollViewState();
}

class _AdaptiveFooterSingleChildScrollViewState
    extends State<AdaptiveFooterSingleChildScrollView> with StateMixin {
  double? _width;

  double? _height;

  BoxConstraints get _constraints => BoxConstraints(
        maxHeight: _height ?? double.maxFinite,
      );

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, BoxConstraints constraint) {
        return SingleChildScrollView(
          controller: widget.scrollController,
          child: ConstrainedBox(
            constraints: _constraints,
            child: CustomMultiChildLayout(
              delegate: StickyHeaderFooterScrollViewDelegate(
                width: constraint.maxWidth,
                height: constraint.maxHeight,
                onUpdate: _onUpdate,
              ),
              children: [
                LayoutId(
                  id: _Ids.body,
                  child: SingleChildScrollView(
                    child: widget.child,
                  ),
                ),
                if (widget.footer != null)
                  LayoutId(
                    id: _Ids.footer,
                    child: widget.footer!,
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _onUpdate(double width, double height) {
    if (width == _width && height == _height) {
      return;
    }

    _width = width;
    _height = height;
    setStatePostFrame();
  }
}

class StickyHeaderFooterScrollViewDelegate extends MultiChildLayoutDelegate {
  StickyHeaderFooterScrollViewDelegate({
    required this.height,
    required this.width,
    required this.onUpdate,
  });

  final double height;

  final double width;

  final void Function(double width, double height) onUpdate;

  @override
  void performLayout(Size size) {
    late Size leadingSize;

    if (hasChild(_Ids.body)) {
      leadingSize = layoutChild(
        _Ids.body,
        BoxConstraints(
          maxWidth: width,
        ),
      );

      positionChild(
        _Ids.body,
        Offset.zero,
      );
    } else {
      leadingSize = Size.zero;
    }

    if (hasChild(_Ids.footer)) {
      final footerSize = layoutChild(
        _Ids.footer,
        BoxConstraints(
          maxWidth: width,
        ),
      );
      final remainingHeight = height - leadingSize.height - footerSize.height;

      var newHeight = 0.0;

      if (remainingHeight > 0) {
        positionChild(
          _Ids.footer,
          Offset(0, height - footerSize.height),
        );

        newHeight = height;
      } else {
        positionChild(
          _Ids.footer,
          Offset(0, leadingSize.height),
        );
        newHeight = leadingSize.height + footerSize.height;
      }

      onUpdate(width, newHeight);
    }
  }

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) {
    return oldDelegate != this;
  }
}

enum _Ids { body, footer }
