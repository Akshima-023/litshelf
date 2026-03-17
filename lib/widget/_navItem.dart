import 'package:flutter/material.dart';

class NavItem extends StatelessWidget {
  final int index;
  final int currentIndex;
  final IconData icon;
  final IconData selectedIcon;
  final Function(int) onTap;

  const NavItem({
    super.key,
    required this.index,
    required this.currentIndex,
    required this.icon,
     required this.selectedIcon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final bool isSelected = currentIndex == index;

    return GestureDetector(
      onTap: () => onTap(index),

      child: Container(
        height: size.height * 0.05,
        width: size.width * 0.12,

        decoration: BoxDecoration(
          color: isSelected ? Colors.deepPurple : Colors.transparent,
          shape: BoxShape.circle,
        ),
child: Icon(
          isSelected ? selectedIcon : icon,
          color: isSelected ? Colors.white : Colors.grey,
          size: 28,
        ),
        
      ),
    );
  }
}