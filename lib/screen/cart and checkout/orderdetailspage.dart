import 'package:flutter/material.dart';
import 'package:litshelf/screen/cart%20and%20checkout/order.dart';
import 'package:litshelf/theme/text.dart';
import 'package:litshelf/widget/purplebutton.dart';

class OrderDetailsPage extends StatelessWidget {
  const OrderDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// THANK YOU CARD
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F2FF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children:  [
                    Text(
                      "Thankyou 👋",
                      style: AppTextStyles.text16p
                    ),
                    SizedBox(height: size.height*0.01),
                    Text(
                      "Lorem ipsum dolor sit",
                      style: AppTextStyles.des18bb
                    ),
                    SizedBox(height: size.height*0.01),
                    Text(
                      "Order #2930541",
                      style: AppTextStyles.text14g
                    ),
                  ],
                ),
              ),

              SizedBox(height: size.height*0.01),

              /// CANCEL TEXT
              Row(
                children:  [
                  Text(
                    "Do you want to cancel your order? ",
                    style: AppTextStyles.text14g
                  ),
                  Text(
                    "Cancel",
                    style: AppTextStyles.text14pb
                  ),
                ],
              ),

               SizedBox(height: size.height*0.02),

              /// ORDER DETAILS TITLE
               Text(
                "Order Details",
                style: AppTextStyles.text16bb
              ),

               SizedBox(height: size.height*0.02),

              /// ORDER DETAILS CARD
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [

                    _row("1x  Carrie Fisher", "\$19.99"),
                    _row("1x  The Da vinci Code", "\$39.99"),
                    _row("1x  Arcu ipsum feugiat leo odio", "\$27.12"),

                    Divider(height: size.height*0.03),

                    _rowBold("Subtotal", "\$87.10"),
                     SizedBox(height:size.height*0.01),
                    _rowBold("Shipping", "\$2"),

                  Divider(height: size.height*0.03),

                    _rowTotal("Total Payment", "\$89.10"),

                    SizedBox(height:size.height*0.01),

                    _rowGrey("Delivery in", "10 - 15 mins"),
                   SizedBox(height:size.height*0.01),
                    _rowGrey("Time", "15.24 - 15.39"),
                  ],
                ),
              ),
               SizedBox(height: size.height * 0.04),
              PurpleButton(text: "Order Status", onTap: (){
 Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const OrderReceivedPage()
      ),
    );
              }),

         
              /// ORDER STATUS BUTTON
             SizedBox(height: size.height * 0.04),
            ],
          ),
        ),
      ),
    );
  }

  /// Helpers
  static Widget _row(String left, String right) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(left, style: const TextStyle(fontSize: 14)),
          Text(right, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }

  static Widget _rowBold(String left, String right) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(left, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(right, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }

  static Widget _rowTotal(String left, String right) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(left, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(
          right,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF6A5AE0),
          ),
        ),
      ],
    );
  }

  static Widget _rowGrey(String left, String right) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(left, style: const TextStyle(color: Colors.grey)),
        Text(right, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}