import 'package:flutter/material.dart';
import 'package:litshelf/screen/homescreen/authorspage.dart';
import 'package:litshelf/theme/text.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shimmer/shimmer.dart';

class AuthorsWidget extends StatelessWidget {
  AuthorsWidget({super.key});

  final supabase = Supabase.instance.client;

  Future<List<dynamic>> fetchAuthors() async {
    final response =
        await supabase.from('authors').select('name, image');
    return response;
  }

  Widget buildSkeleton(Size size) {
    return SizedBox(
      height: size.height * 0.28,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              margin: EdgeInsets.only(right: size.width * 0.08),
              child: Column(
                children: [
                  Container(
                    width: size.width * 0.25,
                    height: size.width * 0.25,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: size.height * 0.01),
                  Container(
                    width: size.width * 0.2,
                    height: 10,
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Authors", style: AppTextStyles.des18bb),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AuthorsPage(),
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

        FutureBuilder(
          future: fetchAuthors(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return buildSkeleton(size);
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text("No authors found"));
            }

            final authors = snapshot.data!;

            return SizedBox(
              height: size.height * 0.28,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: authors.length,
                itemBuilder: (context, index) {
                  final item = authors[index];

                  return Container(
                    margin: EdgeInsets.only(right: size.width * 0.08),
                    child: Column(
                      children: [
                        Container(
                          width: size.width * 0.25,
                          height: size.width * 0.25,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(item['image']),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.01),
                        SizedBox(
                          width: size.width * 0.25,
                          child: Text(
                            item['name'],
                            style: AppTextStyles.text14bb,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
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