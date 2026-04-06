import 'package:flutter/material.dart';
import 'package:litshelf/screen/cart%20and%20checkout/cartpage.dart';
import 'package:litshelf/screen/provider/cartprovider.dart';
import 'package:litshelf/screen/provider/feedbackprovider.dart';
import 'package:provider/provider.dart';
import 'package:litshelf/theme/text.dart';
import 'package:litshelf/widget/purplebutton.dart';

class OrderReceivedPage extends StatelessWidget {
  final String orderId;
  const OrderReceivedPage({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final feedbackProvider = Provider.of<FeedbackProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// ICON
              Container(
                height: size.height * 0.08,
                width: size.height * 0.08,
                decoration: const BoxDecoration(
                  color: Color(0xFFF5F2FF),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.inventory_2_outlined,
                  size: 40,
                  color: Color(0xFF6A5AE0),
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Text("You Received The Order!",
                  style: AppTextStyles.des20bw),
              SizedBox(height: size.height * 0.01),
              Text("Order #$orderId", style: AppTextStyles.text14g),
              SizedBox(height: size.height * 0.03),
              Text("Tell us your feedback 👋",
                  style: AppTextStyles.text18bp),
              SizedBox(height: size.height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return IconButton(
                    onPressed: () {
                      feedbackProvider.setRating(index + 1);
                    },
                    icon: Icon(
                      index < feedbackProvider.rating
                          ? Icons.star
                          : Icons.star_border,
                      color: Colors.amber,
                      size: 32,
                    ),
                  );
                }),
              ),

              SizedBox(height: size.height * 0.02),
              TextField(
                onChanged: (value) {
                  feedbackProvider.setFeedback(value);
                },
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: "Write something for us...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              SizedBox(height: size.height * 0.03),

              /// BUTTON
             PurpleButton(
  text: "Done",
  onTap: () {
    final rating = feedbackProvider.rating;
    final feedback = feedbackProvider.feedback;

    print("Rating: $rating");
    print("Feedback: $feedback");

    Provider.of<CartProvider>(context, listen: false).clearCart();
    feedbackProvider.clear();

   Navigator.push(
  context,
  MaterialPageRoute(
   
    builder: (context) => const CartPage(),
  ),
);
  },
),
            ],
          ),
        ),
      ),
    );
  }
}