import 'package:flutter/material.dart';

class RegularButton extends StatelessWidget {
  final Color color;
  final double clipSize;
  final EdgeInsets padding;
  final VoidCallback onTap;
  final Widget child;

  const RegularButton(
      {super.key,
      required this.color,
      this.clipSize = 16.0,
      this.padding = const EdgeInsets.all(16.0),
      required this.onTap,
      required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _RegularButtonClipper(clipSize),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          color: color,
          child: Padding(
            padding: padding + EdgeInsets.symmetric(horizontal: clipSize),
            child: child,
          ),
        ),
      ),
    );
  }
}

class _RegularButtonClipper extends CustomClipper<Path> {
  final double clipSize;

  _RegularButtonClipper(this.clipSize);

  @override
  Path getClip(Size size) {
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
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
