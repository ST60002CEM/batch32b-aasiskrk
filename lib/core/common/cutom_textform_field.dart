import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData? prefixIconData;
  final Color hintTextColor;
  final Color fillColor;
  final bool filled;
  final String? Function(String?)? validator;
  final TextStyle? textStyle;
  final bool obscureText; // New property for obscuring text
  final bool enableToggle; // New property to enable/disable toggle icon

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
    this.enableToggle = false, // Initialize the new property
  }) : super(key: key);

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText =
        widget.obscureText; // Set the initial value based on widget property
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      style: widget.textStyle,
      obscureText: _obscureText, // Use the local obscureText variable
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(color: widget.hintTextColor),
        fillColor: widget.fillColor,
        filled: widget.filled,
        prefixIcon: widget.prefixIconData != null
            ? Icon(widget.prefixIconData, color: Colors.grey)
            : null,
        suffixIcon: widget.enableToggle
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
