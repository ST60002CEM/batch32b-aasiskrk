import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final TextStyle? textStyle;
  final Color color;
  final double borderRadius;
  final double height;
  final Image? image; // New image parameter

  const CustomElevatedButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.textStyle,
    this.color = const Color.fromRGBO(48, 255, 81, 40),
    this.borderRadius = 15.0,
    this.height = 58.0,
    this.image, // New image parameter
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
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (image != null)
              SizedBox(
                width: 30.0, // Adjust the width as needed for the image size
                child: image, // Display image if provided
              ),
            SizedBox(width: 8.0), // Add some space between image and text
            Expanded(
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: textStyle ?? TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
