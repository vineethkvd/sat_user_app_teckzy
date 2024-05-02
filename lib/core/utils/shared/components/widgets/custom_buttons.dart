import 'package:flutter/material.dart';

class CustomElevatedBtn extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double height;
  final double width;
  final Widget? child;
  final double radius;
  final BorderSide? side;
  final String title;
  final TextStyle? textStyle;

  const CustomElevatedBtn({
    Key? key,
    this.side,
    this.width = double.infinity,
    this.height = 48,
    this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
    this.child,
    this.radius = 10,
    this.title = '', this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        side: side,
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        minimumSize: Size(width, height),
        shadowColor: Colors.black54,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
      child: child ??
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
    );
  }
}

class CustomTextBtn extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double height;
  final double width;
  final Widget? child;
  final double radius;
  final String title;

  const CustomTextBtn({
    Key? key,
    this.width = double.infinity,
    this.height = 48,
    this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
    this.child,
    this.radius = 10,
    this.title = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        minimumSize: Size(width, height),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
      child: child ??
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
    );
  }
}
