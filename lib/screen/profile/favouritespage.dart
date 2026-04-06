import 'package:flutter/material.dart';
import 'package:litshelf/screen/provider/favourite.dart';
import 'package:litshelf/theme/text.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}


class _FavoritesPageState extends State<FavoritesPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<FavoritesProvider>(context, listen: false)
          .fetchFavorites();
    });
  }
  

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Favorites"),
        centerTitle: true,
      ),
      body: Consumer<FavoritesProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.favorites.isEmpty) {
            return const Center(child: Text("No favorite items yet"));
          }

          return ListView.separated(
            itemCount: provider.favorites.length,
            separatorBuilder: (_, __) => Divider(
              height: size.height * 0.001,
              color: const Color.fromARGB(255, 224, 224, 224),
            ),
            itemBuilder: (context, index) {
              final item = provider.favorites[index];

              // 🔥 HANDLE BOTH TABLES
              final product = item['products'];
              final book = item['book_category'];

              // ✅ COMMON DATA
              final name = product != null
                  ? product['name']
                  : book?['name'] ?? '';

              final image = product != null
                  ? product['image']
                  : book?['image_url'] ?? '';

              final price = product != null
                  ? product['price']
                  : book?['price'] ?? '';

              final productId = item['product_id'];
              final bookId = item['book_id'];

              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Row(
                  children: [
                    // 🔥 IMAGE
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        image.isNotEmpty
                            ? image
                            : 'https://via.placeholder.com/150',
                        width: size.width * 0.25,
                        height: size.height * 0.14,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            const Icon(Icons.image, size: 40),
                      ),
                    ),

                    SizedBox(width: size.width * 0.04),

                    // 🔥 TEXT
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: AppTextStyles.text16bb,
                          ),
                          SizedBox(height: size.height * 0.02),
                          Text(
                            "₹$price",
                            style: AppTextStyles.text16p,
                          ),
                        ],
                      ),
                    ),

                    // 🔥 REMOVE FAVORITE
                    IconButton(
                      icon: const Icon(Icons.favorite,
                          color: Colors.purple),
                      onPressed: () {
                        if (productId != null) {
                          provider.toggleProductFavorite(
                              productId.toString());
                        } else if (bookId != null) {
                          provider.toggleBookFavorite(bookId);
                        }
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}