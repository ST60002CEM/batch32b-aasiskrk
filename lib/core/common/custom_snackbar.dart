import 'package:flutter/material.dart';

SnackBar customSnackBar({
  required String message,
  TextStyle? textStyle,
  required Color backgroundColor,
  double borderRadius = 10.0,
  Duration duration = const Duration(seconds: 4),
}) {
  return SnackBar(
    content: Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: Colors.green, // Green border color
          width: 2.0, // Border width
        ),
      ),
      padding: const EdgeInsets.all(8.0), // Padding inside the container
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: textStyle ?? const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    ),
    behavior: SnackBarBehavior.fixed,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(borderRadius),
    ),
    duration: duration,
    backgroundColor: Colors
        .transparent, // Make background transparent to show custom background color
    elevation: 0, // Remove shadow for better appearance
  );
}

void showCustomSnackBar(
  BuildContext context,
  String message, {
  TextStyle? textStyle,
  Color? backgroundColor,
  double borderRadius = 15.0,
  Duration duration = const Duration(seconds: 4),
}) {
  final resolvedBackgroundColor =
      backgroundColor ?? Theme.of(context).canvasColor;

  ScaffoldMessenger.of(context).showSnackBar(
    customSnackBar(
      message: message,
      textStyle: textStyle,
      backgroundColor: resolvedBackgroundColor,
      borderRadius: borderRadius,
      duration: duration,
    ),
  );
}
