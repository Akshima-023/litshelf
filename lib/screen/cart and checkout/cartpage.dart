import 'package:flutter/material.dart';
import 'package:litshelf/screen/homescreen/dashboard.dart';
import 'package:litshelf/screen/provider/cartprovider.dart';
import 'package:provider/provider.dart';
import 'package:litshelf/screen/cart%20and%20checkout/confirmorder.dart';
import 'package:litshelf/theme/text.dart';
import 'package:litshelf/widget/purplebutton.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();

    /// Load cart
    Future.microtask(() {
      context.read<CartProvider>().loadCart();
    });
  }

  /// Navigate to Home/Dashboard
  void goToHome(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const DashboardPage(selectedIndex: 0),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItems = cartProvider.cartItems;

    return WillPopScope(
      onWillPop: () async {
        goToHome(context);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("My Cart"),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              goToHome(context);
            },
          ),
        ),

        /// BODY
        body: cartItems.isEmpty
            ? const Center(child: Text("Your cart is empty"))
            : ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];

                  return Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        /// IMAGE
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            item["image"],
                            width: size.width * 0.2,
                            height: size.height * 0.1,
                            fit: BoxFit.cover,
                          ),
                        ),

                        SizedBox(width: size.width * 0.03),

                        /// DETAILS
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item["name"],
                                style: AppTextStyles.text16bb,
                              ),
                              const SizedBox(height: 5),
                              Text("₹${item["price"]}"),
                              const SizedBox(height: 5),
                              Text(
                                "Qty: ${item["quantity"]}",
                                style: AppTextStyles.text16g,
                              ),
                            ],
                          ),
                        ),

                        /// ACTIONS
                        Column(
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () =>
                                      cartProvider.decreaseQty(index),
                                  icon: const Icon(Icons.remove),
                                ),
                                Text(item["quantity"].toString()),
                                IconButton(
                                  onPressed: () =>
                                      cartProvider.increaseQty(index),
                                  icon: const Icon(Icons.add),
                                ),
                              ],
                            ),
                            IconButton(
                              onPressed: () =>
                                  cartProvider.removeItem(index),
                              icon: const Icon(Icons.delete,
                                  color: Colors.red),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),

        /// BUY NOW
        bottomNavigationBar: cartItems.isEmpty
            ? null
            : Padding(
                padding: const EdgeInsets.all(12.0),
                child: PurpleButton(
                  text: "Buy Now",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ConfirmOrderScreen(
                          cartItems: cartItems,
                        ),
                      ),
                    );
                  },
                ),
              ),
      ),
    );
  }
}