import 'package:flutter/material.dart';
import 'package:litshelf/theme/text.dart';

class VendorTabs extends StatelessWidget {
  final List<String> tabs;
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const VendorTabs({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
Widget build(BuildContext context) {
  final Size size = MediaQuery.of(context).size;
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16), 
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, 
      children: List.generate(tabs.length, (index) {
        final isSelected = selectedIndex == index;

        return GestureDetector(
          onTap: () => onChanged(index),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                tabs[index],
                style: isSelected
                    ? AppTextStyles.text16bb
                    : AppTextStyles.text16g,
              ),
              if (isSelected)
                Container(
                  margin: const EdgeInsets.only(top: 4),
                  height: size.height * 0.003,
                  width: size.width * 0.08,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
            ],
          ),
        );
      }),
    ),
  );
}}