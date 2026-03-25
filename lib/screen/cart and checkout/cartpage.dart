import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:litshelf/screen/cart%20and%20checkout/confirmorder.dart';
import 'package:litshelf/widget/purplebutton.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key, required List<Map<String, dynamic>> cartItems}); // No need to pass cartItems

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Map<String, dynamic>> cartItems = [];

  @override
  void initState() {
    super.initState();
    _loadCart();
  }

  Future<void> _loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    String? cartString = prefs.getString('cart');
    if (cartString != null) {
      List decoded = jsonDecode(cartString);
      setState(() {
        cartItems = decoded.cast<Map<String, dynamic>>();
      });
    }
  }

  Future<void> _saveCart() async {
    final prefs = await SharedPreferences.getInstance();
    String cartString = jsonEncode(cartItems);
    await prefs.setString('cart', cartString);
  }

  double getTotalPrice() {
    double total = 0;
    for (var item in cartItems) {
      total += item["price"] * item["quantity"];
    }
    return total;
  }

  void increaseQty(int index) {
    setState(() {
      cartItems[index]["quantity"]++;
    });
    _saveCart();
  }

  void decreaseQty(int index) {
    setState(() {
      if (cartItems[index]["quantity"] > 1) cartItems[index]["quantity"]--;
    });
    _saveCart();
  }

  void removeItem(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
    _saveCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Cart"),
        centerTitle: true,
      ),
      body: cartItems.isEmpty
          ? const Center(child: Text("Your cart is empty"))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
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
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                item["image"],
                                width: 70,
                                height: 90,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item["name"],
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 5),
                                  Text("₹${item["price"]}"),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                        onPressed: () => decreaseQty(index),
                                        icon: const Icon(Icons.remove)),
                                    Text(item["quantity"].toString()),
                                    IconButton(
                                        onPressed: () => increaseQty(index),
                                        icon: const Icon(Icons.add)),
                                  ],
                                ),
                                IconButton(
                                  onPressed: () => removeItem(index),
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: const BoxDecoration(
                    border: Border(top: BorderSide(color: Colors.grey)),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Total",
                              style:
                                  TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          Text("₹${getTotalPrice()}",
                              style:
                                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 20),
                      PurpleButton(
                        text: "Checkout",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ConfirmOrderScreen(),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
    );
  }
}