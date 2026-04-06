import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextStyle hintStyle;
  final bool obscureText;
  final IconData? icon;
  final VoidCallback? onIconTap;
  final Function(String)? onChanged;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.hintStyle,
    required this.obscureText,
    this.icon,
    this.onIconTap,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText, 
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: hintStyle,

        suffixIcon: icon != null
            ? IconButton(
                icon: Icon(icon),
                onPressed: onIconTap, color: Colors.grey,
              )
            : null,
      ),
    );
  }
}