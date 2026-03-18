import 'package:flutter/material.dart';
import 'package:litshelf/theme/text.dart';

class AuthorsWidget extends StatelessWidget {
  final Future<List<dynamic>> booksFuture;
  final Map<String, String> authorImages;

  const AuthorsWidget({
    super.key,
    required this.booksFuture,
    required this.authorImages,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Authors",
          style: AppTextStyles.des18bb
        ),
         SizedBox(height:size.height*0.02),
        FutureBuilder(
          future: booksFuture,
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const SizedBox();

            final books = snapshot.data!;

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: books.take(3).map((book) {
                final info = book["volumeInfo"];
                String author = (info["authors"] != null) ? info["authors"][0] : "Unknown";
                String image = authorImages[author] ?? "https://via.placeholder.com/100";
                return Column(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(image),
                    ),
                    SizedBox(height:size.height*0.02),
                    Text(author,style: AppTextStyles.text14bb),
                     Text(
                      "Writer",
                      style: AppTextStyles.text14g
                    ),
                  ],
                );
              }).toList(),
            );
          },
        ),
        SizedBox(height: size.height * 0.03),
      ],
    );
  }
}