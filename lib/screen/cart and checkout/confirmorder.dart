import 'package:flutter/material.dart' hide Notification;
import 'package:litshelf/screen/provider/orderprovider.dart';
import 'package:provider/provider.dart';
import 'package:litshelf/screen/cart%20and%20checkout/deliverydate.dart';
import 'package:litshelf/screen/cart%20and%20checkout/orderdetailspage.dart';
import 'package:litshelf/screen/cart%20and%20checkout/showpaymentsheet.dart';
import 'package:litshelf/screen/profile/address.dart';
import 'package:litshelf/theme/text.dart';
import 'package:litshelf/widget/customcard.dart';
import 'package:litshelf/widget/datetime.dart';
import 'package:litshelf/widget/purplebutton.dart';
import 'package:litshelf/widget/summaryrow.dart';
import 'package:litshelf/screen/homescreen/notification.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfirmOrderScreen extends StatefulWidget {
  const ConfirmOrderScreen({
    super.key,
    required this.cartItems,
  });

  final List<Map<String, dynamic>> cartItems;

  @override
  State<ConfirmOrderScreen> createState() => _ConfirmOrderScreenState();
}

class _ConfirmOrderScreenState extends State<ConfirmOrderScreen> {
  double shipping = 2;
  DateTime? selectedDate;
  String selectedPayment = "Choose payment method";
  String titleAddress = "";
  String subAddress = "";
  bool isLoading = false;

  double get price {
    double total = 0;
    for (var item in widget.cartItems) {
      total += (item["price"] ?? 0) * (item["quantity"] ?? 1);
    }
    return total;
  }

  double get total => price + shipping;

  @override
  void initState() {
    super.initState();
    loadAddress();
  }

  Future<void> loadAddress() async {
    final prefs = await SharedPreferences.getInstance();
    String type = prefs.getString("selected_type") ?? "home";
    setState(() {
      titleAddress = prefs.getString("${type}_street") ?? "No address";
      subAddress = prefs.getString("${type}_sub") ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// HEADER
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back),
                    ),
                    Text("Confirm Order", style: AppTextStyles.des18bb),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const NotificationPage(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.notifications_outlined),
                    ),
                  ],
                ),

                SizedBox(height: size.height * 0.02),

                /// ADDRESS
                CustomCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Address", style: AppTextStyles.des18bb),
                      SizedBox(height: size.height * 0.03),
                      Row(
                        children: [
                          const Icon(Icons.location_on,
                              color: Colors.purple),
                          SizedBox(width: size.height * 0.01),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(titleAddress,
                                    style: AppTextStyles.des18bb),
                                Text(subAddress,
                                    style: AppTextStyles.text16g),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Address(),
                                ),
                              );
                              loadAddress();
                            },
                            child:
                                const Icon(Icons.arrow_forward_ios, size: 16),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: size.height * 0.03),

                /// SUMMARY
                CustomCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Summary", style: AppTextStyles.des18bb),
                      SizedBox(height: size.height * 0.02),

                      SummaryRow(
                        title: "Price",
                        value: "₹${price.toStringAsFixed(2)}",
                      ),

                      SummaryRow(
                        title: "Shipping",
                        value: "₹${shipping.toStringAsFixed(2)}",
                      ),

                      const Divider(),

                      SummaryRow(
                        title: "Total Payment",
                        value: "₹${total.toStringAsFixed(2)}",
                      ),
                    ],
                  ),
                ),

                SizedBox(height: size.height * 0.03),

                /// DELIVERY DATE
                InkWell(
                  onTap: () async {
                    final result = await showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (_) => DeliveryDate(
                        name: widget.cartItems.isNotEmpty
                            ? widget.cartItems[0]['name']
                            : '',
                        image: widget.cartItems.isNotEmpty
                            ? widget.cartItems[0]['image']
                            : '',
                      ),
                    );

                    if (result != null) {
                      setState(() {
                        selectedDate = result["date"];
                      });
                    }
                  },
                  child: DateTimeCard(
                    size: size,
                    title: "Date and time",
                    subtitle: selectedDate != null
                        ? "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}"
                        : "Not selected",
                    description: "Choose date and time",
                    icon: Icons.calendar_today,
                  ),
                ),

                SizedBox(height: size.height * 0.03),

                /// PAYMENT
                DateTimeCard(
                  size: size,
                  title: "Payment",
                  subtitle: "Payment method",
                  description: "Choose payment method",
                  icon: Icons.payment,
                  onTap: () async {
                    final result = await showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      builder: (context) {
                        return const Showpaymentsheet();
                      },
                    );

                    if (result != null) {
                      setState(() {
                        selectedPayment = result;
                      });
                    }
                  },
                ),

                SizedBox(height: size.height * 0.03),

                /// ORDER BUTTON
                PurpleButton(
                  text: isLoading ? "Processing..." : "Order",
                  onTap: () async {
                    if (isLoading) return;

                    if (selectedDate == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("Please select delivery date")),
                      );
                      return;
                    }

                    setState(() {
                      isLoading = true;
                    });

                    final orderProvider =
                        Provider.of<OrderProvider>(context, listen: false);

                    for (var item in widget.cartItems) {
                      final orderData = {
                        "name": item["name"],
                        "price": item["price"],
                        "image": item["image"],
                        "quantity": item["quantity"],
                        "deliveryDate":
                            selectedDate!.toIso8601String(),
                        "createdAt": DateTime.now().toIso8601String(),
                      };

                      await orderProvider.addOrder(orderData);
                      await orderProvider.removeFromCart(item["name"]);
                    }

                    setState(() {
                      isLoading = false;
                    });

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderDetailsPage(
                          book: widget.cartItems.isNotEmpty
                              ? widget.cartItems[0]
                              : {},
                          shipping: shipping,
                          deliveryDate:
                              selectedDate!.toIso8601String(), books: widget.cartItems,  
                        ),
                      ),
                    );
                  },
                ),

                SizedBox(height: size.height * 0.04),
              ],
            ),
          ),
        ),
      ),
    );
  }
}