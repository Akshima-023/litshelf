import 'package:flutter/material.dart';
import 'package:litshelf/theme/text.dart';

class TopOfWeekWidget extends StatelessWidget {
  final Future<List<dynamic>> booksFuture;
  final double height;
  const TopOfWeekWidget({
    super.key,
    required this.booksFuture,
    this.height = 220,
  });
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text(
          "Top of Week",
          style: AppTextStyles.des18bb
        ),
        SizedBox(height: size.height * 0.02),
        FutureBuilder(
          future: booksFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
           if (snapshot.hasError) {
              return const Text("Error loading books");
            }
            final books = snapshot.data!;
            return SizedBox(
              height: height,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: books.length,
                itemBuilder: (context, index) {
                  final book = books[index]["volumeInfo"];
                  final saleInfo = books[index]["saleInfo"];
                  String title = book["title"] ?? "";
                  String image = book["imageLinks"]?["thumbnail"] ?? "";
                  image = image.replaceFirst("http://", "https://");
                String price = "Free";
                if (saleInfo != null) {
                if (saleInfo["saleability"] == "FOR_SALE") {
               final listPrice = saleInfo["listPrice"];
               if (listPrice != null) {
               price = "${listPrice["currencyCode"]} ${listPrice["amount"]}";
              }
             } else if (saleInfo["saleability"] == "FREE") {
             price = "Free";
            } else {
             price = "Preview";
             }
              }
              return Container(
                    width: size.width*0.35,
                    margin: const EdgeInsets.only(right: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            image.isNotEmpty ? image : "https://via.placeholder.com/150",
                            height: size.height*0.19,
                            width: size.width*0.35,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: size.height*0.001),
                        Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.text16bb,
                        ),
                         SizedBox(height:size.height*0.001),
                        Text(
                          price,
                          style: AppTextStyles.text14g
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