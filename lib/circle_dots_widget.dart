import 'dart:math';

import 'package:flutter/material.dart';

class CircleDotsWidget extends LeafRenderObjectWidget {
  final int numberOfDots;
  final double dotRadius;
  final Color dotColor;

  const CircleDotsWidget({
    super.key,
    required this.numberOfDots,
    this.dotRadius = 10,
    this.dotColor = Colors.deepPurpleAccent,
  });

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderCircleDots(
      numberOfDots: numberOfDots,
      dotRadius: dotRadius,
      dotColor: dotColor,
    );
  }

  @override
  void updateRenderObject(BuildContext context, covariant RenderCircleDots renderObject) {
    renderObject
      ..numberOfDots = numberOfDots
      ..dotRadius = dotRadius
      ..dotColor = dotColor;
  }
}

class RenderCircleDots extends RenderBox {
  int numberOfDots;
  double dotRadius;
  Color dotColor;

  RenderCircleDots({
    required this.numberOfDots,
    required this.dotRadius,
    required this.dotColor,
  });

  @override
  void performLayout() {
    size = constraints.biggest;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final center = offset + size.center(Offset.zero);
    final radius = size.shortestSide / 2.0;
    final angleBetweenDots = 2 * pi / numberOfDots;

    context.canvas.drawCircle(
      Offset(center.dx, center.dy),
      radius,
      Paint()
        ..color = Colors.black
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0,
    );

    final dotPaint = Paint()
      ..color = dotColor
      ..style = PaintingStyle.fill;

    for (int i = 0; i < numberOfDots; i++) {
      final angle = i * angleBetweenDots;
      final dotOffset = Offset(
        center.dx + radius * cos(angle),
        center.dy + radius * sin(angle),
      );
      context.canvas.drawCircle(dotOffset, dotRadius, dotPaint);
    }
  }

  @override
  bool get isRepaintBoundary => true;
}
