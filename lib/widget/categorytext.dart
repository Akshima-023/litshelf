import 'package:flutter/material.dart';

class CategoryText extends StatelessWidget {
  final String title;
  final String selectedCategory;
  final Function(String) onTap;

  const CategoryText({
    super.key,
    required this.title,
    required this.selectedCategory,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = selectedCategory == title;

    return InkWell(
      onTap: () => onTap(title),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: isSelected ? Colors.black : Colors.grey,
        ),
      ),
    );
  }
}