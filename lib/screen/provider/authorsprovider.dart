import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthorsProvider extends ChangeNotifier {
  final SupabaseClient supabase = Supabase.instance.client;

  List<Map<String, dynamic>> _authors = [];
  bool _isLoading = false;

  List<Map<String, dynamic>> get authors => _authors;
  bool get isLoading => _isLoading;

  Future<void> fetchAuthors() async {
    _isLoading = true;
    notifyListeners();

    try {
      final data = await supabase
          .from('authorpage')
          .select()
          .order('created_at', ascending: false);

      _authors = List<Map<String, dynamic>>.from(data);
    } catch (e) {
      print("ERROR: $e");
      _authors = [];
    }

    _isLoading = false;
    notifyListeners();
  }
}