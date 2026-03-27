import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:litshelf/theme/text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<Map<String, dynamic>> favoriteItems = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  // Load favorites from SharedPreferences
  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    String? favString = prefs.getString('favorites');
    if (favString != null) {
      List decoded = jsonDecode(favString);
      setState(() {
        favoriteItems = decoded.cast<Map<String, dynamic>>();
      });
    }
  }

  // Save favorites to SharedPreferences
  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    String favString = jsonEncode(favoriteItems);
    await prefs.setString('favorites', favString);
  }

  // Remove from favorites
  void removeFavorite(int index) {
    setState(() {
      favoriteItems.removeAt(index);
    });
    _saveFavorites();
  }

  @override
  Widget build(BuildContext context) {
     final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Favorites"),
        centerTitle: true,
      ),
      body: favoriteItems.isEmpty
    ? const Center(child: Text("No favorite items yet"))
    : ListView.separated(
        itemCount: favoriteItems.length,
        separatorBuilder: (context, index) => const Divider(
          color: Colors.grey,
          thickness: 1,
          height: 1,
        ),
        itemBuilder: (context, index) {
          final item = favoriteItems[index];

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // 📷 IMAGE
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    item['image'],
                    width: size.width*0.3,       
                    height: size.height*0.15,      
                    fit: BoxFit.cover,
                  ),
                ),
                 SizedBox(width:size.width*0.02),

                // 📄 DETAILS
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['name'],
                        style: AppTextStyles.text14bb),
                       SizedBox(height: size.height*0.01),
                      Text("₹${item['price']}"),
                    ],
                  ),
                ),

                // ❤️ FAVORITE BUTTON
                IconButton(
                  icon: const Icon(Icons.favorite, color: Colors.purple),
                  onPressed: () {
                    removeFavorite(index);
                    SharedPreferences.getInstance()
                        .then((prefs) => prefs.setBool('liked_${item['image']}', false));
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}