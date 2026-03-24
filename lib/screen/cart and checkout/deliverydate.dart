import 'package:flutter/material.dart';
import 'package:litshelf/theme/text.dart';
import 'package:litshelf/widget/datechip.dart';
import 'package:litshelf/widget/purplebutton.dart';
import 'package:litshelf/widget/timechip.dart';


class DeliveryDate extends StatefulWidget {
  const DeliveryDate({super.key});

  @override
  State<DeliveryDate> createState() => _DeliveryDateState();
}

class _DeliveryDateState extends State<DeliveryDate> {
  String selectedDateType = "Today";
  String selectedTime = "Between\n10PM - 11PM";
  DateTime selectedDate = DateTime.now();

  // 🔹 Format date like "12 Jan"
  String formatDate(DateTime date) {
    const months = [
      "Jan","Feb","Mar","Apr","May","Jun",
      "Jul","Aug","Sep","Oct","Nov","Dec"
    ];
    return "${date.day} ${months[date.month - 1]}";
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Center(
              child: Container(
                height: size.height*0.005,
                width:size.width * 0.1 ,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),           
            Text(
              "Delivery date",
              style: AppTextStyles.text16bb
            ),
            SizedBox(height: size.height*0.01),            
            Wrap(
              spacing: 10,
              children: [               
                DateChip(
                  text: "Today\n${formatDate(DateTime.now())}",
                  isSelected: selectedDateType == "Today",
                  onTap: () {
                    setState(() {
                      selectedDateType = "Today";
                      selectedDate = DateTime.now();
                    });
                  },
                ),               
                DateChip(
                  text:
                      "Tomorrow\n${formatDate(DateTime.now().add(const Duration(days: 1)))}",
                  isSelected: selectedDateType == "Tomorrow",
                  onTap: () {
                    setState(() {
                      selectedDateType = "Tomorrow";
                      selectedDate =
                          DateTime.now().add(const Duration(days: 1));
                    });
                  },
                ),               
                DateChip(
                  text: selectedDateType == "Pick"
                      ? "Picked\n${formatDate(selectedDate)}"
                      : "Pick\na date",
                  isSelected: selectedDateType == "Pick",
                  onTap: () async {
                    DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate:
                          DateTime.now().add(const Duration(days: 30)),
                    );

                    if (picked != null) {
                      setState(() {
                        selectedDateType = "Pick";
                        selectedDate = picked;
                      });
                    }
                  },
                ),
              ],
            ),
             SizedBox(height:  size.height*0.03),          
            Text(
              "Delivery time",
              style: AppTextStyles.text16bb
            ),
             SizedBox(height:  size.height*0.01),           
            Wrap(
              spacing: 10,
              children: [
                TimeChip(
                  text: "Between\n10PM - 11PM",
                  isSelected: selectedTime == "Between\n10PM - 11PM",
                  onTap: () {
                    setState(() {
                      selectedTime = "Between\n10PM - 11PM";
                    });
                  },
                ),
                TimeChip(
                  text: "Between\n11PM - 12AM",
                  isSelected: selectedTime == "Between\n11PM - 12AM",
                  onTap: () {
                    setState(() {
                      selectedTime = "Between\n11PM - 12AM";
                    });
                  },
                ),
              ],
            ),

           SizedBox(height:  size.height*0.04),
PurpleButton(
  text: "Confirm",
  onTap: () {
    Navigator.pop(context); 
  },
)
            ],
        ),
      ),
    );
  }
}