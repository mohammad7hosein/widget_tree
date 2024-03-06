import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CircleLayoutWidget extends MultiChildRenderObjectWidget {
  const CircleLayoutWidget({
    Key? key,
    required List<Widget> children,
  }) : super(
          key: key,
          children: children,
        );

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderCircleLayout();
  }

  @override
  void updateRenderObject(BuildContext context, covariant RenderCircleLayout renderObject) {}
}

class RenderCircleLayout extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, CircleParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, CircleParentData> {
  @override
  void performLayout() {
    if (childCount == 0) {
      size = constraints.smallest;
      return;
    }

    final childConstraints = constraints.loosen();
    double maxWidth = 0;
    double maxHeight = 0;

    for (final child in getChildrenAsList()) {
      child.layout(childConstraints, parentUsesSize: true);
      maxWidth = max(maxWidth, child.size.width);
      maxHeight = max(maxHeight, child.size.height);
    }
    final radius = max(maxWidth, maxHeight) * childCount;
    size = constraints.constrain(Size(2 * radius, 2 * radius));
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final center = offset + size.center(Offset.zero);
    final radius = size.shortestSide / 2.0;
    final angleBetweenChildren = 2 * pi / childCount;

    for (int i = 0; i < childCount; i++) {
      final child = getChildrenAsList()[i];
      final angle = i * angleBetweenChildren;
      final childX = (center.dx + radius * cos(angle)) - child.size.width / 2;
      final childY = (center.dy + radius * sin(angle)) - child.size.height / 2;

      context.paintChild(child, Offset(childX, childY));
    }
  }

  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! CircleParentData) {
      child.parentData = CircleParentData();
    }
  }

  @override
  bool get isRepaintBoundary => true;
}

class CircleParentData extends ContainerBoxParentData<RenderBox> {}
