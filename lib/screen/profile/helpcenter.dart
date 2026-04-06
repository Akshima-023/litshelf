import 'package:flutter/material.dart';
import 'package:litshelf/theme/text.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpCenterPage extends StatelessWidget {
  const HelpCenterPage({super.key});

  @override
  Widget build(BuildContext context) {
      final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        leading: const BackButton(),
        title: Center(child: Text("Order History")),
        backgroundColor: const Color(0xFF6C4AB6),
        foregroundColor: Colors.white,
        elevation: 0,
      ),

      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 30),
            decoration: const BoxDecoration(
              color: Color(0xFF6C4AB6),
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20),
              ),
            ),
            child:  Column(
              children: [
                Text(
                  "Help Center",
                  style: AppTextStyles.des22bw
                ),
                SizedBox(height: size.height*0.01),
                Text(
                  "Tell us how we can help 👋",
                  style:AppTextStyles.text14w
                ),
                SizedBox(height: size.height*0.01),
                Text(
                  "We are ready to support you anytime!",
                  style:AppTextStyles.text14w
                ),
              ],
            ),
          ),

          SizedBox(height: size.height*0.05),

          /// 🔹 OPTIONS
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [

                /// 📧 EMAIL BOX
               Expanded(
  child: GestureDetector(
   onTap: () async {
  final Uri emailUri = Uri(
    scheme: 'mailto',
    path: 'akshima865@gmail.com',
    queryParameters: {
      'subject': 'Support Needed',
      'body': 'Hello, I need help...',
    },
  );

  try {
    await launchUrl(
      emailUri,
      mode: LaunchMode.externalApplication,
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("No email app found")),
    );
  }
},child: Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(Icons.email, size: 30, color: Colors.deepPurple),
          SizedBox(height: size.height * 0.01),
          Text("Email", style: AppTextStyles.text14bb),
          SizedBox(height: size.height * 0.01),
          Text(
            "Contact support via email",
            style: AppTextStyles.text14g,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  ),
),SizedBox(width: size.width*0.05),
  Expanded(
  child: GestureDetector(
    onTap: () async {
      final Uri phoneUri = Uri(
        scheme: 'tel',
        path: '1234567890',
      );

      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Could not open dialer")),
        );
      }
    },
    child: Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(Icons.phone, size: 30, color: Colors.deepPurple),
          SizedBox(height: size.height * 0.01),
          Text("Phone Number", style: AppTextStyles.text14bb),
          SizedBox(height: size.height * 0.01),
          Text(
            "Call support team",
            style: AppTextStyles.text14g,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  ),
),],
            ),
          ),
        ],
      ),
    );
  }
}