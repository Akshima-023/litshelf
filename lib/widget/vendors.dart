import 'package:flutter/material.dart';
import 'package:litshelf/theme/text.dart';

class VendorsWidget extends StatelessWidget {
  const VendorsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: size.height * 0.02),
         Text(
          "Vendors",
          style: AppTextStyles.des18bb
        ),
        SizedBox(height: size.height * 0.02),
        SizedBox(
          height: size.height * 0.18,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: const [
              VendorCard(name: "The Reading Nook", imageUrl: "https://picsum.photos/100?1"),
              VendorCard(name: "Pages & Co.", imageUrl: "https://picsum.photos/100?2"),
              VendorCard(name: "Book Haven", imageUrl: "https://picsum.photos/100?3"),
              VendorCard(name: "LitCorner", imageUrl: "https://picsum.photos/100?4"),
              VendorCard(name: "StoryTime Sellers", imageUrl: "https://picsum.photos/100?5"),
            ],
          ),
        ),
      ],
    );
  }
}

class VendorCard extends StatelessWidget {
  final String name;
  final String imageUrl;

  const VendorCard({super.key, required this.name, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
     final Size size = MediaQuery.of(context).size;
    return Container(
      width:  size.width * 0.25,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              imageUrl,
              height: size.height * 0.10,
              width: size.width * 0.25,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: size.height * 0.01,),
          Text(
            name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}