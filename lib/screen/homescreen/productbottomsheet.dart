import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:litshelf/screen/cart%20and%20checkout/cartpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:litshelf/theme/text.dart';

class ProductBottomSheet extends StatefulWidget {
  final String name;
  final String image;
  final int rating;
  final int ratingCount;
  final double price;

  const ProductBottomSheet({
    super.key,
    required this.name,
    required this.image,
    required this.rating,
    required this.ratingCount,
    required this.price,
  });

  @override
  State<ProductBottomSheet> createState() => _ProductBottomSheetState();
}

class _ProductBottomSheetState extends State<ProductBottomSheet> {
  bool isLiked = false;
  int quantity = 1;
  String activeButton = "";
  String selectedAction = "";
  List<Map<String, dynamic>> cartItems = [];

  @override
  void initState() {
    super.initState();
    _loadLikedState();
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

  void _loadLikedState() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isLiked = prefs.getBool('liked_${widget.image}') ?? false;
    });
  }

  void _saveLikedState() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('liked_${widget.image}', isLiked);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 100,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // IMAGE
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  widget.image,
                  height: 300,
                  width: 300,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: size.height * 0.02),

            // TITLE & LIKE
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.name,
                    style: AppTextStyles.des20bw,
                  ),
                ),
                GestureDetector(
  onTap: () async {
    setState(() {
      isLiked = !isLiked; // toggle favorite
    });

    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('liked_${widget.image}', isLiked);

    // Load current favorites
    List<Map<String, dynamic>> favorites = [];
    String? favString = prefs.getString('favorites');
    if (favString != null) {
      List decoded = jsonDecode(favString);
      favorites = decoded.cast<Map<String, dynamic>>();
    }

    if (isLiked) {
      // Add item to favorites if not already added
      if (!favorites.any((item) => item['image'] == widget.image)) {
        favorites.add({
          'name': widget.name,
          'image': widget.image,
          'price': widget.price,
        });
      }
    } else {
      // Remove item from favorites
      favorites.removeWhere((item) => item['image'] == widget.image);
    }

    // Save updated favorites
    await prefs.setString('favorites', jsonEncode(favorites));

    // Optional: show a small snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(isLiked
            ? "Added to Favorites"
            : "Removed from Favorites"),
        duration: const Duration(seconds: 1),
      ),
    );
  },
  child: Icon(
    isLiked ? Icons.favorite : Icons.favorite_border,
    color: Colors.purple,
    size: 28,
  ),
),
              ],
            ),
            SizedBox(height: size.height * 0.02),

            // DESCRIPTION
            const Text(
              "A long fictional story that explores characters, emotions, and experiences through engaging storytelling. It takes readers on a journey through different worlds, relationships, and ideas.",
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            SizedBox(height: size.height * 0.04),

            // REVIEW
            Text("Review", style: AppTextStyles.des18bb),
            SizedBox(height: size.height * 0.01),
            Row(
              children: [
                for (int i = 1; i <= 5; i++)
                  Icon(
                    i <= widget.rating ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                    size: 26,
                  ),
                SizedBox(width: size.width * 0.04),
                Text(
                  "(${widget.ratingCount} reviews)",
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.04),

            // QUANTITY + PRICE
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    // MINUS
                    GestureDetector(
                      onTap: () {
                        if (quantity > 1) {
                          setState(() {
                            quantity--;
                            activeButton = "minus";
                          });
                        }
                      },
                      child: Container(
                        height: size.height * 0.04,
                        width: size.width * 0.1,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: activeButton == "minus"
                              ? Colors.purple
                              : Colors.grey[300],
                        ),
                        child: Icon(
                          Icons.remove,
                          color: activeButton == "minus" ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(width: size.width * 0.02),

                    // QUANTITY NUMBER
                    Text(quantity.toString(), style: AppTextStyles.text16p),
                    SizedBox(width: size.width * 0.02),

                    // PLUS
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          quantity++;
                          activeButton = "plus";
                        });
                      },
                      child: Container(
                        height: size.height * 0.04,
                        width: size.width * 0.1,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: activeButton == "plus"
                              ? Colors.purple
                              : Colors.grey[300],
                        ),
                        child: Icon(
                          Icons.add,
                          color: activeButton == "plus" ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  "₹ ${(widget.price * quantity).toStringAsFixed(2)}",
                  style: AppTextStyles.text18p,
                ),
              ],
            ),
            SizedBox(height: size.height * 0.02),

            // ADD TO CART / VIEW CART BUTTONS
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        setState(() {
                          selectedAction = "add";
                        });
                        // Add to cart
                        bool exists = false;
                        for (var item in cartItems) {
                          if (item["name"] == widget.name) {
                            item["quantity"] += quantity;
                            exists = true;
                            break;
                          }
                        }
                        if (!exists) {
                          cartItems.add({
                            "name": widget.name,
                            "image": widget.image,
                            "price": widget.price,
                            "quantity": quantity,
                          });
                        }

                        await _saveCart();

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Added to cart")),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: selectedAction == "add" ? Colors.purple : Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "Add to cart",
                          style: AppTextStyles.text16b.copyWith(
                            color: selectedAction == "add" ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedAction = "cart";
                        });

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CartPage(cartItems: cartItems),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: selectedAction == "cart" ? Colors.purple : Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "View Cart",
                          style: selectedAction == "cart"
                              ? AppTextStyles.text16bb
                              : AppTextStyles.text16b,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}