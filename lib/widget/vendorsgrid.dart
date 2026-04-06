import 'package:flutter/material.dart';
import 'package:litshelf/widget/vendorscard.dart';


class VendorGrid extends StatelessWidget {
  final List vendors;

  const VendorGrid({super.key, required this.vendors});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        itemCount: vendors.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.58,
        ),
        itemBuilder: (context, index) {
          return VendorCard(vendor: vendors[index]);
        },
      ),
    );
  }
}