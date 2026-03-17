import 'package:flutter/material.dart';
import 'package:litshelf/theme/text.dart';

class ProfileItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;

  const ProfileItem({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.deepPurple.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.deepPurple),
            ),
             SizedBox(width:size.width*0.05 ),
            Expanded(
              child: Text(
                title,
                style: AppTextStyles.text16b
              ),
            ),
               Icon(
              Icons.arrow_forward_ios,
              size: size.height*0.02,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}