import 'package:flutter/material.dart';
import 'package:litshelf/screen/cart%20and%20checkout/order.dart';
import 'package:litshelf/theme/text.dart';
import 'package:litshelf/widget/orderrow.dart';
import 'package:litshelf/widget/purplebutton.dart';

class OrderDetailsPage extends StatelessWidget {
  final List<Map> books;
  final double shipping;

  const OrderDetailsPage({
    super.key,
    required this.books,
    required this.shipping, required String deliveryDate, required Map<dynamic, dynamic> book,
  });

  void _showCancelDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Cancel Order"),
          content: const Text("Are you sure you want to cancel this order?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("No"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Order Cancelled")),
                );
                Navigator.pop(context);
              },
              child: const Text("Yes"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // ✅ Subtotal calculation
    double subtotal = books.fold(
      0,
      (sum, item) => sum + (item["price"] ?? 0).toDouble(),
    );

    final double total = subtotal + shipping;

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
                  children: [
                    Text("Thankyou 👋", style: AppTextStyles.text16p),
                    SizedBox(height: size.height * 0.01),
                    Text(
                      "Your order is confirmed",
                      style: AppTextStyles.des18bb,
                    ),
                    SizedBox(height: size.height * 0.01),
                    Text(
                      "Order #2930541",
                      style: AppTextStyles.text14g,
                    ),
                  ],
                ),
              ),

              SizedBox(height: size.height * 0.02),

              /// CANCEL OPTION
              Row(
                children: [
                  Text(
                    "Do you want to cancel your order? ",
                    style: AppTextStyles.text14g,
                  ),
                  GestureDetector(
                    onTap: () {
                      _showCancelDialog(context);
                    },
                    child: Text(
                      "Cancel",
                      style: AppTextStyles.text14pb,
                    ),
                  ),
                ],
              ),

              SizedBox(height: size.height * 0.02),

              /// TITLE
              Text("Order Details", style: AppTextStyles.text16bb),

              SizedBox(height: size.height * 0.02),

              /// ORDER DETAILS CARD
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    /// BOOK LIST
                    Column(
                      children: books.map((book) {
                        return Column(
                          children: [
                            OrderRowWidget(
                              left: "1x ${book["name"]}",
                              right:
                                  "\$${(book["price"] ?? 0).toStringAsFixed(2)}",
                            ),
                            const Divider(),
                          ],
                        );
                      }).toList(),
                    ),

                    /// SUBTOTAL
                    OrderRowWidget(
                      left: "Subtotal",
                      right: "\$${subtotal.toStringAsFixed(2)}",
                      isBold: true,
                    ),

                    /// SHIPPING
                    OrderRowWidget(
                      left: "Shipping",
                      right: "\$${shipping.toStringAsFixed(2)}",
                      isBold: true,
                    ),

                    const Divider(),

                    /// TOTAL
                    OrderRowWidget(
                      left: "Total Payment",
                      right: "\$${total.toStringAsFixed(2)}",
                      isTotal: true,
                    ),

                    const Divider(),

                    /// DELIVERY INFO
                    OrderRowWidget(
                      left: "Delivery in",
                      right: "10 - 15 mins",
                      isGrey: true,
                    ),

                    OrderRowWidget(
                      left: "Time",
                      right: "15:24 - 15:39",
                      isGrey: true,
                    ),
                  ],
                ),
              ),

              SizedBox(height: size.height * 0.04),

              /// BUTTON
              PurpleButton(
                text: "Order Status",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          OrderReceivedPage(orderId: 'orderid'),
                    ),
                  );
                },
              ),

              SizedBox(height: size.height * 0.04),
            ],
          ),
        ),
      ),
    );
  }
}