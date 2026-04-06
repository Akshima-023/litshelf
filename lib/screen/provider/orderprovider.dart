import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _orders = [];

  List<Map<String, dynamic>> get orders => _orders;

  Future<void> loadOrders() async {
    final prefs = await SharedPreferences.getInstance();

    List<String> storedOrders = prefs.getStringList("orders") ?? [];

    _orders = storedOrders
        .map((e) => Map<String, dynamic>.from(jsonDecode(e)))
        .toList();

    notifyListeners();
  }

  Future<void> addOrder(Map<String, dynamic> order) async {
    final prefs = await SharedPreferences.getInstance();

    List<String> storedOrders = prefs.getStringList("orders") ?? [];
    storedOrders.add(jsonEncode(order));

    await prefs.setStringList("orders", storedOrders);

    _orders.add(order);
    notifyListeners();
  }

  Future<void> removeFromCart(String name) async {
    final prefs = await SharedPreferences.getInstance();

    String? cartString = prefs.getString('cart');

    if (cartString != null) {
      List cart = jsonDecode(cartString);

      cart.removeWhere((item) => item["name"] == name);

      await prefs.setString('cart', jsonEncode(cart));
    }
  }
  Future<void> deleteOrder(int index) async {
  final prefs = await SharedPreferences.getInstance();

  List<String> storedOrders = prefs.getStringList("orders") ?? [];

  if (index >= 0 && index < storedOrders.length) {
    storedOrders.removeAt(index);

    await prefs.setStringList("orders", storedOrders);

    _orders.removeAt(index);

    notifyListeners();
  }
}

}