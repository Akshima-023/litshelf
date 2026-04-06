import 'package:flutter/material.dart' hide Notification;
import 'package:litshelf/screen/homescreen/productbottomsheet.dart';
import 'package:litshelf/widget/categorytext.dart';
import 'package:litshelf/widget/skeletongrid.dart';
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
  bool isLoading = true;

  final supabase = Supabase.instance.client;

  @override
  void initState() {
    super.initState();
    fetchBooks();
  }

  Future<void> fetchBooks() async {
    setState(() {
      isLoading = true;
    });

    var query = supabase.from('book_category').select();

    if (selectedCategory == "Novels") {
      query = query.ilike('type', 'novel');
    } else if (selectedCategory == "Self-Love") {
      query = query.ilike('type', 'self-love');
    } else if (selectedCategory == "Science") {
      query = query.ilike('type', 'science');
    } else if (selectedCategory == "Romantic") {
      query = query.ilike('type', 'romantic');
    }

    final response = await query;

    setState(() {
      books = response;
      isLoading = false;
    });
  }

  void changeCategory(String category) {
    setState(() {
      selectedCategory = category;
    });
    fetchBooks();
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
              /// TOP BAR
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
                          builder: (context) => NotificationPage(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.notifications_outlined),
                  ),
                ],
              ),

              SizedBox(height: size.height * 0.05),

              /// CATEGORY ROW
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CategoryText(
                    title: "All",
                    selectedCategory: selectedCategory,
                    onTap: changeCategory,
                  ),
                  CategoryText(
                    title: "Novels",
                    selectedCategory: selectedCategory,
                    onTap: changeCategory,
                  ),
                  CategoryText(
                    title: "Self-Love",
                    selectedCategory: selectedCategory,
                    onTap: changeCategory,
                  ),
                  CategoryText(
                    title: "Science",
                    selectedCategory: selectedCategory,
                    onTap: changeCategory,
                  ),
                  CategoryText(
                    title: "Romantic",
                    selectedCategory: selectedCategory,
                    onTap: changeCategory,
                  ),
                ],
              ),

              SizedBox(height: size.height * 0.03),

              /// GRID
              Expanded(
                child: isLoading
                    ? const SkeletonGrid()
                    : books.isEmpty
                        ? const Center(child: Text("No books found"))
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
                              final imageUrl = item['image_url'] ?? '';

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(20),
                                          ),
                                        ),
                                        builder: (context) {
                                          return ProductBottomSheet(
                                            productId: null,
                                            bookId: item['id'],
                                            name: item['name'],
                                            image: item['image_url'],
                                            rating: 5,
                                            ratingCount: 100,
                                            price: (item['price'] ?? 0).toDouble(),
                                          );
                                        },
                                      );
                                    },
                                    child: Container(
                                      height: size.height * 0.2,
                                      width: size.width * 0.5,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          image: imageUrl.isNotEmpty
                                              ? NetworkImage(imageUrl)
                                              : const AssetImage(
                                                      'assets/placeholder.png')
                                                  as ImageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),

                                  SizedBox(height: size.height * 0.02),

                                  Text(
                                    item['name'] ?? '',
                                    style: AppTextStyles.text16bb,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),

                                  Text(
                                    "₹${item['price'] ?? ''}",
                                    style: AppTextStyles.text14pb,
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