import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FavoritesProvider extends ChangeNotifier {
  final supabase = Supabase.instance.client;

  List<dynamic> favorites = [];
  bool isLoading = false;


  Future<void> fetchFavorites() async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await supabase
          .from('favorites')
          .select('''
            id,
            product_id,
            book_id,
            products!fk_product (name, image, price),
            book_category!fk_book (name, image_url, price)
          ''');

      favorites = response;

      print("FAVORITES: $response");
    } catch (e) {
      print("Fetch error: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // ✅ REMOVE PRODUCT FAVORITE
  Future<void> toggleProductFavorite(String productId) async {
    try {
      await supabase
          .from('favorites')
          .delete()
          .eq('product_id', productId);

      await fetchFavorites();
    } catch (e) {
      print("Product remove error: $e");
    }
  }

  // ✅ REMOVE BOOK FAVORITE
  Future<void> toggleBookFavorite(int bookId) async {
    try {
      await supabase
          .from('favorites')
          .delete()
          .eq('book_id', bookId);

      await fetchFavorites();
    } catch (e) {
      print("Book remove error: $e");
    }
  }
}