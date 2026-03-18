import 'package:flutter/material.dart';
import 'package:litshelf/theme/text.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final bool obscureText;
  final IconData? icon;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.obscureText = false,
    this.icon,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {

  bool isHidden = true;
  FocusNode focusNode = FocusNode();
  bool isFocused = false;

  @override
  void initState() {
    super.initState();

    focusNode.addListener(() {
      setState(() {
        isFocused = focusNode.hasFocus;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      height: size.height * 0.06,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),        
        border: Border.all(
          color: isFocused
              ? const Color.fromARGB(255, 138, 112, 198)
              : Colors.transparent,
          width: size.width*0.002,
        ),
      ),
      child: TextField(
        focusNode: focusNode,
        obscureText: widget.obscureText ? isHidden : false,
        style: AppTextStyles.text16b,

        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: widget.hintText,
 hintStyle: AppTextStyles.text18g,
 prefixIcon: !widget.obscureText && widget.icon != null
      ? Icon(widget.icon, color: Colors.grey)
      : null,

  
  suffixIcon: widget.obscureText
      ? IconButton(
          icon: Icon(
            isHidden ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: () {
            setState(() {
              isHidden = !isHidden;
            });
          },
        )
      : null,
        ),
      ),
    );
  }
}