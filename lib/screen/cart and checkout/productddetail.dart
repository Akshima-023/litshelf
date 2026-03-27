import 'package:flutter/material.dart';
import 'package:litshelf/theme/text.dart';

class ProductDetailBottomBar extends StatelessWidget {
  final double price;
  final VoidCallback onAddToCart;

  const ProductDetailBottomBar({
    super.key,
    required this.price,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
     final size = MediaQuery.of(context).size;
    return BottomAppBar(
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            /// 💰 Price Section
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text(
                  "Price",
                  style: AppTextStyles.text14g
                ),
                SizedBox(height: size.height*0.02),
                Text(
                  "\$${price.toStringAsFixed(2)}",
                  style: AppTextStyles.des20bw
                ),
              ],
            ),

           ],
        ),
      ),
    );
  }
}