import 'package:flutter/material.dart';
import 'package:litshelf/theme/text.dart';

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
    final Size size = MediaQuery.of(context).size;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(image, height: size.height*0.30),
  SizedBox(height:size.height*0.01),
          Text(
          title,
          style: AppTextStyles.des20bw
        ),
         SizedBox(height:size.height*0.01),
        Text(
          description,
          style: AppTextStyles.text18g,
        ),
      ],
    );
  }
}