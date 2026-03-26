import 'package:flutter/material.dart';
import 'package:litshelf/theme/text.dart';

class DateChip extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const DateChip({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
     final Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
  margin: const EdgeInsets.only(right: 10),
  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  decoration: BoxDecoration(
    color: Colors.grey[200],
    borderRadius: BorderRadius.circular(10),
    border: Border.all(
      color: isSelected ? Colors.purple : Colors.transparent,
      width: size.width*0.004
    ),
  ),
  child: Text(
    text,
    style: AppTextStyles.text14b
  ),
),);
  }
}