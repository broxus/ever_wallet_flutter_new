import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

// !!!!!!!!!!!!!!!!!!!!!!!!
// TODO(alex-a4): if we will really need this in the future, we must update
//  [SquircleShapeBorder] to have isBackground param that will reduce painting
//  rect area for some value to avoid 1pixel difference between back and ink
// !!!!!!!!!!!!!!!!!!!!!!!!

/// Copied from ink_ripple.dart but without k prefix
const _splashFadeDuration = defaultAnimationDuration;

/// Factory that is used inside [InkResponse] to create [SquircleShapeInk]
// class _SquircleShapeInkFactory extends InteractiveInkFeatureFactory {
//   const _SquircleShapeInkFactory({this.cornerRadius = 0});
//
//   final double cornerRadius;
//
//   @override
//   InteractiveInkFeature create({
//     required MaterialInkController controller,
//     required RenderBox referenceBox,
//     required ui.Offset position,
//     required ui.Color color,
//     required ui.TextDirection textDirection,
//     bool containedInkWell = false,
//     RectCallback? rectCallback,
//     BorderRadius? borderRadius,
//     ShapeBorder? customBorder,
//     double? radius,
//     ui.VoidCallback? onRemoved,
//   }) {
//     return SquircleShapeInk(
//       controller: controller,
//       referenceBox: referenceBox,
//       color: color,
//       squircleRadius: cornerRadius,
//       onRemoved: onRemoved,
//       textDirection: textDirection,
//     );
//   }
// }
// static SquircleShapeInkFactoryCreator splashFactory = ({
//   double cornerRadius = 0,
// }) =>
//     _SquircleShapeInkFactory(cornerRadius: cornerRadius);

// typedef SquircleShapeInkFactoryCreator = InteractiveInkFeatureFactory
// Function({
//   double cornerRadius,
// });

/// Ink effect that applies above [SquircleShapeBorder] and change color from
/// background color to [color] with animation.
class SquircleShapeInk extends InteractiveInkFeature {
  SquircleShapeInk({
    required MaterialInkController controller,
    required super.referenceBox,
    required Color color,
    required TextDirection textDirection,
    this.squircleRadius = 0,
    super.onRemoved,
  })  : _squirclePath =
            SquircleShapeBorder(cornerRadius: squircleRadius).getOuterPath(
          Offset.zero & referenceBox.size,
          textDirection: textDirection,
        ),
        super(controller: controller, color: color) {
    _alphaController = AnimationController(
      duration: _splashFadeDuration,
      vsync: controller.vsync,
    )
      ..addListener(controller.markNeedsPaint)
      ..addStatusListener(_handleAlphaStatusChanged);
    _alpha = _alphaController.drive(IntTween(begin: color.alpha, end: 0));

    controller.addInkFeature(this);
  }

  final double squircleRadius;
  final Path _squirclePath;

  late Animation<int> _alpha;
  late AnimationController _alphaController;

  @override
  void confirm() {
    _alphaController.forward();
  }

  @override
  void cancel() {
    _alphaController.forward();
  }

  void _handleAlphaStatusChanged(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      dispose();
    }
  }

  @override
  void dispose() {
    _alphaController.dispose();
    super.dispose();
  }

  @override
  void paintFeature(Canvas canvas, Matrix4 transform) {
    final paint = Paint()..color = color.withAlpha(_alpha.value);
    paintSquircleInk(
      canvas: canvas,
      transform: transform,
      paint: paint,
      squirclePath: _squirclePath,
    );
  }

  void paintSquircleInk({
    required Canvas canvas,
    required Matrix4 transform,
    required Paint paint,
    required Path squirclePath,
  }) {
    final originOffset = MatrixUtils.getAsTranslation(transform);
    canvas.save();
    if (originOffset == null) {
      canvas.transform(transform.storage);
    } else {
      canvas.translate(originOffset.dx, originOffset.dy);
    }

    canvas
      ..drawPath(squirclePath, paint)
      ..restore();
  }
}
