import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData? prefixIconData;
  final Color hintTextColor;
  final Color fillColor;
  final bool filled;
  final String? Function(String?)? validator;
  final TextStyle? textStyle;
  final bool obscureText; // New property for obscuring text

  const CustomTextFormField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.prefixIconData,
    this.hintTextColor = Colors.grey,
    this.fillColor = Colors.white,
    this.filled = true,
    this.validator,
    this.textStyle,
    this.obscureText = false, // Initialize the new property
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      style: textStyle,
      obscureText: obscureText, // Use the obscureText property
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: hintTextColor),
        fillColor: fillColor,
        filled: filled,
        prefixIcon: prefixIconData != null
            ? Icon(prefixIconData, color: Colors.grey)
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
