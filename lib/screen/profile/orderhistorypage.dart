import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:litshelf/theme/text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({super.key});

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  List<Map<String, dynamic>> orders = [];

  @override
  void initState() {
    super.initState();
    loadOrders();
  }
  Future<void> loadOrders() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> storedOrders = prefs.getStringList("orders") ?? [];

    setState(() {
      orders = storedOrders
          .map((item) {
            try {
              return jsonDecode(item) as Map<String, dynamic>;
            } catch (e) {
              return null;
            }
          })
          .whereType<Map<String, dynamic>>()
          .toList()
          .reversed
          .toList();
    });
  }
  String getStatus(String? date) {
    try {
      if (date == null || date.isEmpty) return "On the way";

      final selected = DateTime.parse(date);
      final now = DateTime.now();

      return now.isAfter(selected) ? "Delivered" : "On the way";
    } catch (e) {
      return "On the way";
    }
  }
  Color getStatusColor(String status) {
    return status == "Delivered" ? Colors.green : Colors.orange;
  }

  @override
  Widget build(BuildContext context) {
        final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order History"),
      ),
      backgroundColor: Colors.grey[100],

      body: orders.isEmpty
          ? const Center(child: Text("No orders yet"))

          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final item = orders[index];
                final status = getStatus(item["deliveryDate"]);

                return Row(
                  children: [
                    /// 📸 IMAGE
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        item["image"] ?? "",
                        width: size.width*0.2,
                        height: size.height*0.1,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            const Icon(Icons.book, size: 60),
                      ),
                    ),
                
                   SizedBox(width:size.width*0.02),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item["name"] ?? "Unknown",
                            style: AppTextStyles.text16bb
                          ),
                           SizedBox(height: size.height*0.0),
                          Row(
                            children: [
                              Text(
                                status,
                                style: TextStyle(
                                  color: getStatusColor(status),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                               SizedBox(width: 6),
                              Text(
                                "• ${item["quantity"] ?? 1} items",
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
    );
  }
}