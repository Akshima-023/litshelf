import 'package:flutter/material.dart';
import 'package:litshelf/theme/text.dart';

class CustomFormField extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final TextInputType keyboardType;

  const CustomFormField({
    super.key,
    required this.label,
    this.controller,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
     final Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Label above container
        Text(
          label,
          style: AppTextStyles.text16bb
        ),

        SizedBox(height:size.height*0.01),

      
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),

         SizedBox(height: size.height*0.01),
      ],
    );
  }
}