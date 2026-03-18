import 'dart:convert';
import 'package:http/http.dart' as http;

class BookApi {
  static Future<List<dynamic>> fetchBooks() async {
    final res = await http.get(
      Uri.parse("https://www.googleapis.com/books/v1/volumes?q=bestseller"),
    );

    final data = json.decode(res.body);
    return data["items"];
  }
  static Future<String> getAuthorImage(String name) async {
    return "https://source.unsplash.com/featured/?person,$name";
  }
}