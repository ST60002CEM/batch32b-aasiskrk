import 'package:flutter/material.dart';

import '../../app/navigator_key/navigator_key.dart';

showMySnackBar({
  required String message,
  Color? color,
  TextStyle? textStyle,
  double borderRadius = 10.0,
  Duration duration = const Duration(seconds: 1),
}) {
  ScaffoldMessenger.of(
    // We already created this navigator key in the navigator_key.dart file
    AppNavigator.navigatorKey.currentState!.context,
  ).showSnackBar(
    SnackBar(
      content: Container(
        decoration: BoxDecoration(
          color: color ?? Colors.black,
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
    ),
  );
}
