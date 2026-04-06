import 'package:flutter/material.dart';

class OrderRowWidget extends StatelessWidget {
  final String left;
  final String right;
  final bool isBold;
  final bool isTotal;
  final bool isGrey;

  const OrderRowWidget({
    super.key,
    required this.left,
    required this.right,
    this.isBold = false,
    this.isTotal = false,
    this.isGrey = false,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle style;

    if (isTotal) {
      style = const TextStyle(
        fontWeight: FontWeight.bold,
        color: Color(0xFF6A5AE0),
      );
    } else if (isBold) {
      style = const TextStyle(fontWeight: FontWeight.bold);
    } else if (isGrey) {
      style = const TextStyle(color: Colors.grey);
    } else {
      style = const TextStyle(fontSize: 14);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(left, style: style),
          Text(right, style: style),
        ],
      ),
    );
  }
}