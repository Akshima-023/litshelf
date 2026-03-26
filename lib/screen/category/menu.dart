import 'package:flutter/material.dart' hide Notification;
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:litshelf/theme/text.dart';
import 'package:litshelf/screen/homescreen/search.dart';
import 'package:litshelf/screen/homescreen/notification.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  String selectedCategory = "All";
  List<dynamic> books = [];
  final supabase = Supabase.instance.client;

  @override
  void initState() {
    super.initState();
    fetchBooks(); // Load initially
  }

  // 🔹 FETCH BOOKS FROM SUPABASE
  Future<void> fetchBooks() async {
    var query = supabase.from('book_category').select();

    // Filter by category type
    if (selectedCategory == "Novels") {
      query = query.eq('type', 'novel');
    } else if (selectedCategory == "Self-Love") {
      query = query.eq('type', 'selflove');
    } else if (selectedCategory == "Science") {
      query = query.eq('type', 'science');
    }

    final response = await query;

    setState(() {
      books = response;
    });
  }

  // 🔹 CATEGORY SELECTION
  void changeCategory(String category) {
    setState(() {
      selectedCategory = category;
    });
    fetchBooks();
  }

  // 🔹 Build full public URL for Supabase storage
  String getPublicImageUrl(String filename) {
    return 'https://wtatapphrkkgcaykqehb.supabase.co/storage/v1/object/public/topofweek/$filename';
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔹 HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Search(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.search_outlined),
                  ),
                  Text("Category", style: AppTextStyles.des18bb),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Notification(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.notifications_outlined),
                  ),
                ],
              ),

              SizedBox(height: size.height * 0.05),

              // 🔹 CATEGORY ROW
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () => changeCategory("All"),
                    child: Text(
                      "All",
                      style: AppTextStyles.text16b.copyWith(
                        color: selectedCategory == "All"
                            ? Colors.black
                            : Colors.grey,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => changeCategory("Novels"),
                    child: Text(
                      "Novels",
                      style: AppTextStyles.text16b.copyWith(
                        color: selectedCategory == "Novels"
                            ? Colors.black
                            : Colors.grey,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => changeCategory("Self-Love"),
                    child: Text(
                      "Self-Love",
                      style: AppTextStyles.text16b.copyWith(
                        color: selectedCategory == "Self-Love"
                            ? Colors.black
                            : Colors.grey,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => changeCategory("Science"),
                    child: Text(
                      "Science",
                      style: AppTextStyles.text16b.copyWith(
                        color: selectedCategory == "Science"
                            ? Colors.black
                            : Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: size.height * 0.03),

              // 🔹 BOOK GRID
              Expanded(
                child: books.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.7,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: books.length,
                        itemBuilder: (context, index) {
                          final item = books[index];

                          final imageUrl =
                              getPublicImageUrl(item['image']); // Construct full URL

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 120,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: NetworkImage(imageUrl),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                item['name'],
                                style: AppTextStyles.text16bb,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "₹${item['price']}",
                                style: AppTextStyles.text14g,
                              ),
                            ],
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