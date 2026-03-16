import 'package:flutter/material.dart';
import 'package:litshelf/theme/text.dart';

class PurpleButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const PurpleButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: size.height * 0.06,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 151, 118, 231),
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),topLeft: Radius.circular(20),
        topRight: Radius.circular(20))),
        child: Center(
          child: Text(
            text,
            style: AppTextStyles.text18w,
          ),
        ),
      ),
    );
  }
}