import 'package:flutter/material.dart';
import 'package:litshelf/theme/text.dart';


class BuildTag extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const BuildTag({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.deepPurple : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: AppTextStyles.text16b.copyWith(
  color: isSelected ? Colors.white : Colors.black,
),
        ),
      ),
    );
  }
}