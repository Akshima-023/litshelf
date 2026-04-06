import 'package:flutter/material.dart';
import 'package:litshelf/screen/homescreen/vendorslistpage.dart';
import 'package:litshelf/theme/text.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shimmer/shimmer.dart';

class VendorsWidget extends StatelessWidget {
  VendorsWidget({super.key});

  final supabase = Supabase.instance.client;

  Future<List<dynamic>> fetchVendors() async {
    final response =
        await supabase.from('vendor_images').select('image');
    return response;
  }

  Widget buildSkeleton(Size size) {
    return SizedBox(
      height: size.height * 0.12,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: size.width * 0.3,
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey,
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
        SizedBox(height: size.height * 0.02),

        /// HEADER
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Best Vendors",
              style: AppTextStyles.des18bb,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const VendorListPage(),
                  ),
                );
              },
              child: Row(
                children: [
                  Text("See all", style: AppTextStyles.text14pb),
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                    color: Colors.purple,
                  ),
                ],
              ),
            ),
          ],
        ),

        SizedBox(height: size.height * 0.02),

        /// VENDOR LIST WITH SKELETON
        FutureBuilder(
          future: fetchVendors(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return buildSkeleton(size);
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text("No vendors found"));
            }

            final vendors = snapshot.data!;

            return SizedBox(
              height: size.height * 0.12,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: vendors.length,
                itemBuilder: (context, index) {
                  final item = vendors[index];

                  return Container(
                    width: size.width * 0.3,
                    margin: const EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color.fromARGB(255, 238, 237, 237),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        item['image'],
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
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