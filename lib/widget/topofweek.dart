import 'package:flutter/material.dart';
import 'package:litshelf/screen/homescreen/productbottomsheet.dart';
import 'package:litshelf/theme/text.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shimmer/shimmer.dart';

class TopOfWeekWidget extends StatefulWidget {
  final double height;

  const TopOfWeekWidget({
    super.key,
    this.height = 220, required Future<List<dynamic>> booksFuture,
  });

  @override
  State<TopOfWeekWidget> createState() => _TopOfWeekWidgetState();
}

class _TopOfWeekWidgetState extends State<TopOfWeekWidget> {
  final supabase = Supabase.instance.client;

  Future<List<dynamic>> fetchProducts() async {
    final response = await supabase
        .from('products')
        .select('id, name, price, image');

    return response;
  }

  final List<Map<String, dynamic>> productRatings = [
    {'rating': 5, 'reviews': 120},
    {'rating': 4, 'reviews': 80},
    {'rating': 3, 'reviews': 45},
    {'rating': 5, 'reviews': 200},
    {'rating': 2, 'reviews': 20},
    {'rating': 5, 'reviews': 200},
    {'rating': 4, 'reviews': 180},
  ];

  Widget buildSkeleton(Size size) {
    return SizedBox(
      height: size.height * 0.40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: size.width * 0.5,
              margin: const EdgeInsets.only(right: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: size.height * 0.3,
                    width: size.width * 0.5,
                    color: Colors.grey,
                  ),
                  SizedBox(height: size.height * 0.02),
                  Container(
                    height: 10,
                    width: 100,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 10,
                    width: 60,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Top of Week",
          style: AppTextStyles.des18bb,
        ),

        SizedBox(height: size.height * 0.02),

        FutureBuilder(
          future: fetchProducts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return buildSkeleton(size);
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text("No products found"));
            }

            final products = snapshot.data!;

            return SizedBox(
              height: size.height * 0.40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final item = products[index];
                  final details =
                      productRatings[index % productRatings.length];

                  return GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        isDismissible: true,
                        enableDrag: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20)),
                        ),
                        builder: (context) => ProductBottomSheet(
                          productId: item['id']?.toString() ?? '',
                          bookId: null,
                          name: item['name'] ?? '',
                          image: item['image'] ?? '',
                          rating: details['rating'],
                          ratingCount: details['reviews'],
                          price: (item['price'] ?? 0).toDouble(),
                        ),
                      );
                    },
                    child: Container(
                      width: size.width * 0.5,
                      margin: const EdgeInsets.only(right: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              item['image'] ?? '',
                              height: size.height * 0.3,
                              width: size.width * 0.99,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: size.height * 0.02),
                          Text(
                            item['name'] ?? '',
                            style: AppTextStyles.text14bb,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            "₹${item['price'] ?? ''}",
                            style: AppTextStyles.text14pb,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}