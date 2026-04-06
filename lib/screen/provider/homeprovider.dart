import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeProvider extends ChangeNotifier {
  final supabase = Supabase.instance.client;

  List books = [];

  List<String> promotionImages = [];
  bool isLoadingPromo = true;

  Future<void> fetchBooks() async {
    try {
      final response = await supabase.from('books').select();
      books = response;
      notifyListeners();
    } catch (e) {
      print("Books Error: $e");
    }
  }

  Future<void> fetchPromotion() async {
    isLoadingPromo = true;
    notifyListeners();

    try {
      final start = DateTime.now();

      final response = await supabase
          .from('promotion')
          .select('image')
          .limit(5); // ✅ limit for speed

      print("API TIME: ${DateTime.now().difference(start)}");

      promotionImages = (response as List)
          .map((e) => e['image']?.toString() ?? '')
          .where((url) => url.isNotEmpty)
          .toList();
    } catch (e) {
      print("Promo Error: $e");
    }

    isLoadingPromo = false;
    notifyListeners();
  }
}