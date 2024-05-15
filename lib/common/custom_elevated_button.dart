import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final TextStyle? textStyle;
  final Color color;
  final double borderRadius;
  final double height;

  const CustomElevatedButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.textStyle,
    this.color = const Color.fromRGBO(48, 255, 81, 40),
    this.borderRadius = 15.0,
    this.height = 60.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: color,
      ),
      child: TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
        ),
        child: Text(
          text,
          style: textStyle ?? TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
