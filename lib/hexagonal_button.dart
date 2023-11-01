import 'package:custom_ui/hexagonal_button_render.dart';
import 'package:flutter/material.dart';

class HexagonalButton extends StatelessWidget {
  final Color color;
  final double clipSize;
  final EdgeInsets padding;
  final VoidCallback onTap;
  final Widget child;

  const HexagonalButton(
      {super.key,
      required this.color,
      this.clipSize = 16.0,
      this.padding = const EdgeInsets.all(16.0),
      required this.onTap,
      required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: _HexagonalButtonWidget(
          key: key,
          color: color,
          clipSize: clipSize,
          padding: padding,
          child: child),
    );
  }
}

class _HexagonalButtonWidget extends SingleChildRenderObjectWidget {
  final Color color;
  final double clipSize;
  final EdgeInsets padding;

  const _HexagonalButtonWidget(
      {super.key,
      required super.child,
      required this.color,
      required this.clipSize,
      required this.padding});

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderHexagonalBox(
      color: color,
      clipSize: clipSize,
      padding: padding,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, RenderHexagonalBox renderObject) {
    renderObject
      ..color = color
      ..padding = padding
      ..clipSize = clipSize;
  }
}
