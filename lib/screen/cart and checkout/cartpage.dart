import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:litshelf/screen/cart%20and%20checkout/confirmorder.dart';
import 'package:litshelf/theme/text.dart';
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
      final size = MediaQuery.of(context).size;
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
                      return InkWell( borderRadius: BorderRadius.circular(12),
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ConfirmOrderScreen(book: item,),
      ),
    );
  },
                        child: Container(
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
                                  width: size.width*0.19,
                                  height: size.height*0.1,
                                  fit: BoxFit.cover,
                                ),
                              ),
                               SizedBox(width: size.width*0.01),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(item["name"],
                                        style: AppTextStyles.text16bb),
                                     SizedBox(height: size.height*0.01),
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
                        ),
                      );
                    },
                  ),
                ),
               ],
            ),
    );
  }
}