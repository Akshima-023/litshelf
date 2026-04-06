import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _cartItems = [];

  List<Map<String, dynamic>> get cartItems => _cartItems;

  bool isLoading = false;

  /// LOAD CART
  Future<void> loadCart() async {
    isLoading = true;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    String? cartString = prefs.getString('cart');

    if (cartString != null) {
      List decoded = jsonDecode(cartString);
      _cartItems = decoded.cast<Map<String, dynamic>>();
    } else {
      _cartItems = [];
    }

    isLoading = false;
    notifyListeners();
  }

  /// SAVE CART
  Future<void> _saveCart() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('cart', jsonEncode(_cartItems));
  }

  /// ✅ ADD TO CART (YOU WERE MISSING THIS)
  void addToCart(Map<String, dynamic> product, int quantity) {
    int index = _cartItems.indexWhere(
      (item) => item["name"] == product["name"],
    );

    if (index != -1) {
      _cartItems[index]["quantity"] += quantity;
    } else {
      _cartItems.add({
        ...product,
        "quantity": quantity,
      });
    }

    _saveCart();
    notifyListeners();
  }

  /// INCREASE QTY
  void increaseQty(int index) {
    _cartItems[index]["quantity"]++;
    _saveCart();
    notifyListeners();
  }

  /// DECREASE QTY
  void decreaseQty(int index) {
    if (_cartItems[index]["quantity"] > 1) {
      _cartItems[index]["quantity"]--;
      _saveCart();
      notifyListeners();
    }
  }

  /// REMOVE ITEM
  void removeItem(int index) {
    _cartItems.removeAt(index);
    _saveCart();
    notifyListeners();
  }

  /// ✅ CLEAR CART (YOU LEFT EMPTY)
  void clearCart() async {
    _cartItems.clear();
    await _saveCart();
    notifyListeners();
  }

  /// ✅ TOTAL PRICE (BONUS)
  double get totalPrice {
    double total = 0;
    for (var item in _cartItems) {
      total += item["price"] * item["quantity"];
    }
    return total;
  }
}