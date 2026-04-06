import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthorBooksProvider extends ChangeNotifier {
  final SupabaseClient supabase = Supabase.instance.client;

  List<Map<String, dynamic>> _books = [];
  bool _isLoading = false;

  List<Map<String, dynamic>> get books => _books;
  bool get isLoading => _isLoading;

  Future<void> fetchBooks(String authorId) async {
    _isLoading = true;
    notifyListeners();

    try {
      final data = await supabase
          .from('books')
          .select()
          .eq('author_id', authorId);

      _books = List<Map<String, dynamic>>.from(data);
    } catch (e) {
      print("Fetch books error: $e");
    }

    _isLoading = false;
    notifyListeners();
  }
}