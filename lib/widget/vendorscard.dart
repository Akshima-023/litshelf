import 'package:flutter/material.dart';
import '../theme/text.dart';

class VendorCard extends StatelessWidget {
  final dynamic vendor;

  const VendorCard({super.key, required this.vendor});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 🔥 Bigger Image Container
        AspectRatio(
          aspectRatio: 1, // keeps square shape
          child: Container(
            padding: const EdgeInsets.all(16), // ⬆ increased
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Image.network(
              vendor['image_url'],
              fit: BoxFit.contain,
            ),
          ),
        ),

        const SizedBox(height: 12), // ⬆ more space

        // Vendor Name
        Text(
          vendor['name'],
          textAlign: TextAlign.center,
          style: AppTextStyles.des18bb,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),

        const SizedBox(height: 8),

        // Rating
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.star, size: 18, color: Colors.amber),
            const SizedBox(width: 4),
            Text(
              vendor['rating'].toString(),
              style: AppTextStyles.text14g,
            ),
          ],
        ),
      ],
    );
  }
}