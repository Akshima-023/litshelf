import 'package:flutter/material.dart' hide Notification;
import 'package:litshelf/screen/cart%20and%20checkout/deliverydate.dart';
import 'package:litshelf/screen/cart%20and%20checkout/orderdetailspage.dart';
import 'package:litshelf/screen/cart%20and%20checkout/showpaymentsheet.dart';
import 'package:litshelf/screen/profile/address.dart';
import 'package:litshelf/theme/text.dart';
import 'package:litshelf/widget/customcard.dart';
import 'package:litshelf/widget/datetime.dart';
import 'package:litshelf/widget/purplebutton.dart';
import 'package:litshelf/widget/summaryrow.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:litshelf/screen/homescreen/notification.dart';

class ConfirmOrderScreen extends StatefulWidget {
  const ConfirmOrderScreen({super.key,  required this.book});
  final Map book;
  

  @override
  State<ConfirmOrderScreen> createState() => _ConfirmOrderScreenState();
}

class _ConfirmOrderScreenState extends State<ConfirmOrderScreen> {
  double price = 0;
double shipping = 2;

double get total => price + shipping;
  String titleAddress = "";
String subAddress = "";
String selectedPayment = "Choose payment method"; 
Future<void> loadAddress() async {
  final prefs = await SharedPreferences.getInstance();

  // get selected type (home / office)
  String type = prefs.getString("selected_type") ?? "home";

  setState(() {
    titleAddress =
        prefs.getString("${type}_street") ?? "No address";
    subAddress =
        prefs.getString("${type}_sub") ?? "";
  });
}

 
  @override
void initState() {
  super.initState();
  loadAddress();
    price = (widget.book["price"] ?? 0).toDouble();
}
void selectBook(Map book) {
  setState(() {
    price = book["price"]; 
  });
}
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body:  SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [            
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
                    builder: (context) =>const Notification()
                    ),
                    );
                   },                     
                      icon: const Icon(Icons.notifications_outlined),
                    ),
                  ],
                ),SizedBox(height: size.height*0.02,),
   Column(
     crossAxisAlignment: CrossAxisAlignment.start,
     children: [
     CustomCard(
      child: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
        Text(
         "Address",
         style:AppTextStyles.des18bb ,
         ),
         SizedBox(height: size.height*0.03),
          Row(
            children: [
             const Icon(Icons.location_on, color: Colors.purple),
             SizedBox(width: size.height*0.01),     
            Expanded(
             child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
             Text(
             titleAddress,
             style: AppTextStyles.des18bb,
          ),
           Text(
           subAddress,
           style: AppTextStyles.text16g
         ),
       ],
     ),
   ),
    GestureDetector(
       onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Address()
      ),
    );
    loadAddress();
  },child: Icon(Icons.arrow_forward_ios, size: 16)),
      ],
       ),    
       TextButton(
      onPressed: () {         
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Address()
      ),
    );
  },
      
      child: Text("Change",style: AppTextStyles.text16p,),
       ),
     ],
   ),
      ),
        SizedBox(height: size.height*0.03),  
      CustomCard(
   child: Column(
     crossAxisAlignment: CrossAxisAlignment.start,
     children: [
       Text("Summary",
   style:AppTextStyles.des18bb ),
       SizedBox(height: size.height*0.02),
      SummaryRow(
  title: "Price",
  value: "\$${price.toStringAsFixed(2)}",
),

SummaryRow(
  title: "Shipping",
  value: "\$${shipping.toStringAsFixed(2)}",
),

const Divider(),

SummaryRow(
  title: "Total Payment",
  value: "\$${total.toStringAsFixed(2)}",
),

     ],
   ),
      ),SizedBox(height: size.height*0.03,),
     InkWell(
        
  onTap: () async {
  final result = await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => const DeliveryDate(),
  );

  if (result != null) {
    print(result["date"]);
    print(result["time"]);
  }
},

       child: DateTimeCard(
         size: size,
         title: "Date and time",
         subtitle: "Date and time",
         description: "Choose date and time",
         icon: Icons.calendar_today,
       ),
     ),
SizedBox(height: size.height*0.03),
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

      
   SizedBox(height: size.height*0.03),             
       PurpleButton(text: "order", onTap: (){
        Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const OrderDetailsPage()
      ),
    );
       })
       
      ])])))));
    }
  }

 
 