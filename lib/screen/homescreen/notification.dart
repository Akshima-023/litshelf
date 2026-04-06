import 'package:flutter/material.dart';
import 'package:litshelf/screen/provider/orderprovider.dart';
import 'package:litshelf/theme/text.dart';
import 'package:provider/provider.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<OrderProvider>(context, listen: false).loadOrders();
    });
  }

  /// ✅ STATUS LOGIC
  String getStatus(String? date) {
    try {
      if (date == null || date.isEmpty) return "On the way";

      final selected = DateTime.parse(date);
      final now = DateTime.now();

      final selectedDateOnly =
          DateTime(selected.year, selected.month, selected.day);
      final todayDateOnly =
          DateTime(now.year, now.month, now.day);

      if (selectedDateOnly.isAfter(todayDateOnly)) {
        return "On the way"; // future
      } else if (selectedDateOnly.isAtSameMomentAs(todayDateOnly)) {
        return "On the way"; // today
      } else {
        return "Delivered"; // past
      }
    } catch (e) {
      return "On the way";
    }
  }

  /// ✅ STATUS COLOR
  Color getStatusColor(String status) {
    return status == "Delivered" ? Colors.green : Colors.orange;
  }

  /// ✅ SAFE DATE FORMAT
  String formatDate(String? raw) {
    try {
      if (raw == null || raw.isEmpty) return "No date";

      final d = DateTime.parse(raw);
      return "${d.day}-${d.month}-${d.year}";
    } catch (e) {
      return "Invalid date";
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: const Text("Notification")),

      body: Consumer<OrderProvider>(
        builder: (context, provider, child) {
          final orders = provider.orders;

          if (orders.isEmpty) {
            return Center(
              child: Text(
                "No orders yet",
                style: AppTextStyles.text16b,
              ),
            );
          }

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final item = orders[index];

              final deliveryDate = item["deliveryDate"];
              final status = getStatus(deliveryDate);

              return Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    /// IMAGE
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        item["image"] ?? "",
                        width: size.width * 0.2,
                        height: size.height * 0.1,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            const Icon(Icons.book, size: 60),
                      ),
                    ),

                    SizedBox(width: size.width * 0.02),

                    /// DETAILS
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item["name"] ?? "Unknown",
                            style: AppTextStyles.text16b,
                          ),

                          SizedBox(height: size.height * 0.01),

                          Text(
                            status,
                            style: TextStyle(
                              color: getStatusColor(status),
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                          SizedBox(height: size.height * 0.01),

                          Text(
                            "Delivery: ${formatDate(deliveryDate)}",
                            style: AppTextStyles.text14g,
                          ),
                        ],
                      ),
                    ),

                    /// DELETE BUTTON
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        provider.deleteOrder(index);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}