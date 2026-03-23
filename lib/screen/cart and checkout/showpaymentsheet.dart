import 'package:flutter/material.dart';
import 'package:litshelf/theme/text.dart';
import 'package:litshelf/widget/purplebutton.dart';



class Showpaymentsheet extends StatefulWidget {
  const Showpaymentsheet({super.key});

  @override
  State<Showpaymentsheet> createState() => _ShowpaymentsheetState();
}

class _ShowpaymentsheetState extends State<Showpaymentsheet> {
  String selectedPayment = "";

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          // 🔹 Top drag handle
          Container(
            height: size.height * 0.005,
            width: size.width * 0.1,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
          ),

          SizedBox(height: size.height * 0.02),

          // 🔹 Title
          Text(
            "Select Payment Method",
            style: AppTextStyles.des18bb,
          ),

          SizedBox(height: size.height * 0.02),

          // 🔹 UPI Option
          GestureDetector(
            onTap: () {
              setState(() {
                selectedPayment = "UPI";
              });
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: selectedPayment == "UPI"
                      ? Colors.purple
                      : Colors.grey,
                  width: selectedPayment == "UPI" ? 2 : 1,
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.account_balance_wallet, color: Colors.purple),
                  SizedBox(width: size.width * 0.03),
                  const Text("UPI / Wallet"),
                ],
              ),
            ),
          ),

          // 🔹 Card Option
          GestureDetector(
            onTap: () {
              setState(() {
                selectedPayment = "Card";
              });
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: selectedPayment == "Card"
                      ? Colors.purple
                      : Colors.grey,
                  width: selectedPayment == "Card" ? 2 : 1,
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.credit_card, color: Colors.purple),
                  SizedBox(width: size.width * 0.03),
                  const Text("Credit / Debit Card"),
                ],
              ),
            ),
          ),

          SizedBox(height: size.height * 0.01),

  PurpleButton(
  text: "Confirm",
  onTap: () {
    if (selectedPayment.isNotEmpty) {
      Navigator.pop(context, selectedPayment);
    }
  },
),
        ],
      ),
    );
  }
}