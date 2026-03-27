import 'package:flutter/material.dart';
import 'package:litshelf/theme/text.dart';
import 'package:litshelf/widget/purplebutton.dart';

class OrderReceivedPage extends StatelessWidget {
  const OrderReceivedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [ Container(
                height:size.height*0.05 ,
                width: size.width*0.1,
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F2FF),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.inventory_2_outlined,
                  size: 60,
                  color: Color(0xFF6A5AE0),
                ),
              ),

               SizedBox(height: size.height*0.02),

              // Title
               Text(
                "You Received The Order!",
                style: AppTextStyles.des20bw
              ),

              SizedBox(height: size.height*0.02),

              // Order ID
               Text(
                "Order #2930541",
                style: AppTextStyles.text14g
              ),

              SizedBox(height: size.height*0.02),

              // Feedback Title
               Text(
                "Tell us your feedback 👋",
                style: AppTextStyles.text18bp
              ),

              SizedBox(height: size.height*0.01),

              // Description
               Text(
                "Lorem ipsum dolor sit amet\nconsectetur. Dignissim magna vitae.",
                textAlign: TextAlign.center,
                style: AppTextStyles.text14g
              ),

               SizedBox(height: size.height*0.02),

              // ⭐ Rating Stars
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  5,
                  (index) => Icon(
                    index < 4 ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                    size: 32,
                  ),
                ),
              ),

                SizedBox(height: size.height*0.02),

              // Write feedback
               Text(
                "Write something for us!",
                style: AppTextStyles.text14b
              ),

               SizedBox(height: size.height*0.02),

              PurpleButton(text: "Done", onTap: (){})
              ],
          ),
        ),
      ),
    );
  }
}