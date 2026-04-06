import 'package:flutter/material.dart';
import 'package:litshelf/screen/cart%20and%20checkout/cartpage.dart';
import 'package:litshelf/widget/actionbutton.dart';
import 'package:litshelf/theme/text.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ProductBottomSheet extends StatefulWidget {
  final String? productId; 
  final int? bookId;       

  final String name;
  final String image;
  final int rating;
  final int ratingCount;
  final double price;

  const ProductBottomSheet({
    super.key,
    this.productId,
    this.bookId,
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
  final supabase = Supabase.instance.client;
String activeButton = ""; 
  bool isLiked = false;
  int quantity = 1;
  String selectedAction = "";
  List<Map<String, dynamic>> cartItems = [];

  @override
  void initState() {
    super.initState();
    checkFavorite();
    _loadCart();
  }

  String get column =>
      widget.productId != null ? 'product_id' : 'book_id';
  dynamic get value =>
      widget.productId ?? widget.bookId;


  Future<void> checkFavorite() async {
    try {
      final response = await supabase
          .from('favorites')
          .select('id')
          .eq(column, value)
          .maybeSingle();

      if (mounted) {
        setState(() {
          isLiked = response != null;
        });
      }
    } catch (e) {
      print("Check favorite error: $e");
    }
  }

  Future<void> toggleFavorite() async {
    try {
      final existing = await supabase
          .from('favorites')
          .select('id')
          .eq(column, value)
          .maybeSingle();

      if (existing != null) {
        await supabase
            .from('favorites')
            .delete()
            .eq(column, value);

        setState(() => isLiked = false);
        showBottomToast("Removed from Favorites");
      } else {
        await supabase.from('favorites').insert(
          widget.productId != null
              ? {'product_id': widget.productId}
              : {'book_id': widget.bookId},
        );

        setState(() => isLiked = true);
        showBottomToast("Added to Favorites");
      }
    } catch (e) {
      print("Favorite toggle error: $e");
      showBottomToast("Error updating favorite");
    }
  }

  void showBottomToast(String message) {
    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 20,
        left: 20,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.85),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);
    Future.delayed(const Duration(seconds: 1), () {
      overlayEntry.remove();
    });
  }

  Future<void> _loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    String? cartString = prefs.getString('cart');

    if (cartString != null) {
      List decoded = jsonDecode(cartString);
      if (mounted) {
        setState(() {
          cartItems = decoded.cast<Map<String, dynamic>>();
        });
      }
    }
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
          bottom: MediaQuery.of(context).viewInsets.bottom +70 ,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  widget.image.isNotEmpty
                      ? widget.image
                      : 'https://via.placeholder.com/150',
                  height: size.height * 0.30,
                  width: size.width * 0.85,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            SizedBox(height: size.height * 0.02),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(widget.name,
                      style: AppTextStyles.des20bw),
                ),
                GestureDetector(
                  onTap: toggleFavorite,
                  child: Icon(
                    isLiked ? Icons.favorite : Icons.favorite_border,
                    color: Colors.purple,
                    size: 28,
                  ),
                ),
              ],
            ),

            SizedBox(height: size.height * 0.02),

            Text("A captivating story that takes readers on an emotional journey through compelling characters, unexpected twists, and meaningful life lessons. Perfect for readers who enjoy immersive storytelling and rich narratives",
            style: AppTextStyles.text16g,),

            SizedBox(height: size.height * 0.04),

            Text("Review", style: AppTextStyles.text16bb),

            Row(
              children: [
                for (int i = 1; i <= 5; i++)
                  Icon(
                    i <= widget.rating ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                  ),
                SizedBox(width: size.width * 0.02),
                Text("(${widget.ratingCount} reviews)"),
              ],
            ),

            SizedBox(height: size.height * 0.04),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
 Row(
  children: [
    // 🔻 MINUS
    GestureDetector(
      onTap: () {
        if (quantity > 1) {
          setState(() {
            quantity--;
            activeButton = "minus";
          });

          Future.delayed(const Duration(milliseconds: 200), () {
            if (mounted) {
              setState(() => activeButton = "");
            }
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: activeButton == "minus"
              ? Colors.purple
              : Colors.grey.shade300,
        ),
        child: Icon(
          Icons.remove,
          color: activeButton == "minus"
              ? Colors.white
              : Colors.black,
        ),
      ),
    ),

    SizedBox(width: size.width * 0.04),

    Text(
      quantity.toString(),
      style: AppTextStyles.text16p,
    ),

    SizedBox(width: size.width * 0.04),

    // 🔺 PLUS
    GestureDetector(
      onTap: () {
        setState(() {
          quantity++;
          activeButton = "plus";
        });

        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) {
            setState(() => activeButton = "");
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: activeButton == "plus"
              ? Colors.purple
              : Colors.grey.shade300,
        ),
        child: Icon(
          Icons.add,
          color: activeButton == "plus"
              ? Colors.white
              : Colors.black,
        ),
      ),
    ),
  ],
),
Text( "₹ ${(widget.price * quantity).toStringAsFixed(2)}",
                  style: AppTextStyles.text18bp,
                ),
              ],
            ),

            SizedBox(height: size.height * 0.05),

            SizedBox(
              height: size.height * 0.05,
              child: Row(
                children: [
                  Expanded(
                    child: ActionButton(
                      text: "Add to cart",
                      isSelected: selectedAction == "add",
                      onTap: () async {
                        setState(() => selectedAction = "add");

                        final prefs = await SharedPreferences.getInstance();
                        String? cartString = prefs.getString('cart');

                        List cart = cartString != null
                            ? jsonDecode(cartString)
                            : [];

                        int index = cart.indexWhere(
                          (item) => item["name"] == widget.name,
                        );

                        if (index != -1) {
                          cart[index]["quantity"] =
                              (cart[index]["quantity"] ?? 1) + quantity;
                        } else {
                          cart.add({
                            "name": widget.name,
                            "image": widget.image,
                            "price": widget.price,
                            "quantity": quantity,
                          });
                        }

                        await prefs.setString('cart', jsonEncode(cart));
                        showBottomToast("Added to cart");
                      },
                    ),
                  ),
                  SizedBox(width: size.width * 0.1),
                  Expanded(
                    child: ActionButton(
                      text: "View Cart",
                      isSelected: selectedAction == "cart",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                CartPage(),
                          ),
                        );
                      },
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