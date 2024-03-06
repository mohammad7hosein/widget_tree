import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class BoxAroundText extends SingleChildRenderObjectWidget {
  final double padding;

  const BoxAroundText({
    Key? key,
    required this.padding,
    required Widget text,
  }) : super(key: key, child: text);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderBoxAroundText(padding: padding);
  }

  @override
  void updateRenderObject(BuildContext context, covariant RenderBoxAroundText renderObject) {
    renderObject.padding = padding;
    super.updateRenderObject(context, renderObject);
  }
}

class RenderBoxAroundText extends RenderShiftedBox {
  double padding;

  RenderBoxAroundText({
    RenderBox? child,
    required this.padding,
  }) : super(child);

  @override
  void performLayout() {
    if (child != null) {
      // Layout the child with the given constraints
      child!.layout(constraints, parentUsesSize: true);

      // Calculate the size of the box with padding
      final boxSize = child!.size + Offset(padding * 2, padding * 2);

      // Set the size of this render box
      size = constraints.constrain(boxSize);

      // Position the child within the box
      final childParentData = child!.parentData as BoxParentData;
      childParentData.offset = Offset(padding, padding);
    } else {
      size = constraints.smallest;
    }
  }

  @override
  void setupParentData(covariant RenderObject child) {
    if (child.parentData is! BoxParentData) {
      child.parentData = BoxParentData();
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child != null) {
      final childParentData = child!.parentData as BoxParentData;

      // Calculate the size of the box with padding
      final boxSize = child!.size + Offset(padding * 2, padding * 2);

      // Calculate the position of the box
      final boxOffset = Offset(
        childParentData.offset.dx - padding,
        childParentData.offset.dy - padding,
      );

      // Draw the box using the current context
      final paint = Paint()
        ..color = Colors.blue
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0;
      context.canvas.drawRect(
        Rect.fromLTWH(
          offset.dx + boxOffset.dx,
          offset.dy + boxOffset.dy,
          boxSize.width,
          boxSize.height,
        ),
        paint,
      );
      context.paintChild(child!, childParentData.offset + offset);
    }
  }

  @override
  bool get isRepaintBoundary => true;
}
