import 'package:flutter/rendering.dart';
import 'dart:math' as math;

class RenderHexagonalBox extends RenderShiftedBox {
  Color _color;

  Color get color => _color;

  set color(Color color) {
    if (color == _color) return;
    _color = color;
    markNeedsPaint();
  }

  double get defaultHeight => 48;

  //clip size
  double _clipSize;

  double get clipSize => _clipSize;

  set clipSize(double clipSize) {
    if (_clipSize == clipSize) return;
    _clipSize = clipSize;
    markNeedsLayout();
  }

  // padding
  EdgeInsets _padding;

  EdgeInsets get padding => _padding;

  set padding(EdgeInsets padding) {
    if (_padding == padding) return;
    _padding = padding;
    markNeedsLayout();
  }

  @override
  void performLayout() {
    //Рассчитываем размеры виджета
    size = _computeSize(
      constraints,
      (child, constraints) {
        child.layout(constraints, parentUsesSize: true);
        return child.size;
      },
    );
    if (child != null) {
      final childParentData = child!.parentData! as BoxParentData;
      //Ценртируем чаилда в центре родительского виджета
      childParentData.offset =
          Alignment.center.alongOffset(size - child!.size as Offset);
    }
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    return _computeSize(
        constraints, (child, constraints) => child.getDryLayout(constraints));
  }

  Size _computeSize(BoxConstraints constraints, ChildLayouter layoutChild) {
    if (child != null) {
      final childInsets = padding + EdgeInsets.symmetric(horizontal: clipSize);
      final childConstraints = constraints.deflate(childInsets);
      final Size childSize = layoutChild(child!, childConstraints);
      final targetSize = Size(
         childSize.width + childInsets.horizontal,
        math.max(defaultHeight, childSize.height + padding.vertical),
      );
      return constraints.constrain(targetSize);
    } else {
      return Size(clipSize * 2, defaultHeight);
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final path = _getBorderPath(size);
    final shiftedPath = path.shift(offset);

    //  Рисуем бекграунд
    context.canvas.drawPath(
      shiftedPath,
      Paint()
        ..style = PaintingStyle.fill
        ..color = color,
    );
    //рисуем чаилда
    super.paint(context, offset);
  }

  RenderHexagonalBox({
    required Color color,
    required double clipSize,
    required EdgeInsets padding,
    RenderBox? child,
  })  : _color = color,
        _clipSize = clipSize,
        _padding = padding,
        super(child);

  Path _getBorderPath(Size size) {
    return Path()
      ..moveTo(clipSize, 0)
      ..lineTo(size.width - clipSize, 0)
      ..lineTo(size.width, size.height / 2)
      ..lineTo(size.width - clipSize, size.height)
      ..lineTo(clipSize, size.height)
      ..lineTo(0, size.height / 2)
      ..close();
  }

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    final path = _getBorderPath(size);
    return path.contains(position);
  }

/*
  final PointerDownEventListener pointerDownEventListener;

  @override
  void handleEvent(PointerEvent event, covariant BoxHitTestEntry entry){
      if(event is PointerDownEvent){
        pointerDownEventListener(event);
      }
  }*/

  //Accessbelity
  @override
  void describeSemanticsConfiguration(SemanticsConfiguration config) {
    super.describeSemanticsConfiguration(config);
    config
      ..label = 'My New Amazing Button'
      ..isButton = true;
  }
}
