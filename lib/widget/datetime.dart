import 'package:flutter/material.dart';
import 'package:litshelf/theme/text.dart';



class DateTimeCard extends StatelessWidget {
  final Size size;
  final String title;
  final String subtitle;
  final String description;
  final IconData icon;
  final VoidCallback? onTap;

  const DateTimeCard({
    super.key,
    required this.size,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: size.height * 0.15,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              Text(title, style: AppTextStyles.des18bb),

              SizedBox(height: size.height * 0.02),

              Row(
                children: [
                  Icon(icon, size: 24, color: Colors.purple),

                  SizedBox(width: size.width * 0.05),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(subtitle, style: AppTextStyles.text16b),
                        Text(description, style: AppTextStyles.text16g),
                      ],
                    ),
                  ),

                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.grey,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}