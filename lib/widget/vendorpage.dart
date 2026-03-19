import 'package:flutter/material.dart';

class VendorPage extends StatelessWidget {
  final String vendorName;
  final String vendorImage;

  const VendorPage({
    super.key,
    required this.vendorName,
    required this.vendorImage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(vendorName)),
      body: Center(
        child: Image.network(
          vendorImage,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}