import 'package:flutter/material.dart';
import 'package:litshelf/theme/text.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:litshelf/screen/homescreen/productbottomsheet.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _controller = TextEditingController();
  final supabase = Supabase.instance.client;

  List<dynamic> results = [];


  Future<void> searchBooks(String query) async {
    if (query.isEmpty) {
      setState(() {
        results = [];
      });
      return;
    }

    final response = await supabase
        .from('book_category')
        .select()
        .ilike('name', '%$query%');

    setState(() {
      results = response;
    });

    print("SEARCH RESULT: $response");
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔹 HEADER
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                  SizedBox(width: size.width * 0.2),
                  Text("Search", style: AppTextStyles.des18bb),
                ],
              ),
              SizedBox(height: size.height * 0.03),
              TextField(
                controller: _controller,
                onChanged: (value) {
                  searchBooks(value);
                },
                decoration: InputDecoration(
                  hintText: "Search books...",
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Expanded(
                child: results.isEmpty
                    ? const Center(child: Text("No results"))
                    : ListView.builder(
                        itemCount: results.length,
                        itemBuilder: (context, index) {
                          final item = results[index];
                            final product = item['products']; 
                          return ListTile(
                            onTap: () {                             
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20)),
                                ),
                                builder: (context) {
                                  return ProductBottomSheet(
                                 productId: null,
                                bookId: item['id'],
                                name: item['name'],
                                image: item['image_url'],
                                rating: 5,
                                ratingCount: 100,
                                price: (item['price'] ?? 0).toDouble(),);
                                },
                              );
                            },
                            leading: Image.network(
                              item['image_url'] ?? '',
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.image);
                              },
                            ),
                            title: Text(item['name'] ?? ''),
                            subtitle: Text("₹${item['price'] ?? ''}"),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}