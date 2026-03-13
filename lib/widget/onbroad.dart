import 'package:flutter/material.dart';
import 'package:litshelf/textstyle/text.dart';

class OnboardingWidget extends StatelessWidget {
  final String title;
  final String description;
  final String image;

  const OnboardingWidget({
    super.key,
    required this.title,
    required this.description,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(image, height: 250),
        const SizedBox(height: 20),
        Text(
          title,
          style: AppTextStyles.des20bw
        ),
        const SizedBox(height: 10),
        Text(
          description,
          style: AppTextStyles.text18g,
        ),
      ],
    );
  }
}