import 'package:flutter/material.dart';
import 'package:litshelf/screen/homescreen/dashboard.dart';
import 'package:litshelf/theme/text.dart';
import 'package:litshelf/widget/purplebutton.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    final Size size = MediaQuery.of(context).size;
   return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [            
              Image.asset(
                "assets/congratulation.png",
                height: size.height * 0.20,
              ),
              SizedBox(height: size.height * 0.04),           
              Text(
                "Account Created Successfully!",
                textAlign: TextAlign.center,
                style: AppTextStyles.des20bw,
              ),
              SizedBox(height: size.height * 0.02),
              Text(
                "Welcome to LitShelf. Start exploring your favorite books.",
                textAlign: TextAlign.center,
                style: AppTextStyles.text18g,
              ),
              SizedBox(height: size.height * 0.05),
              PurpleButton(
  text: "Get Started",
  onTap: () async {
    final prefs = await SharedPreferences.getInstance();

    
    await prefs.setString("user_name", nameController.text);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => DashboardPage()
      ),
    );
  },
),
          ]
        )        
      ),
    ),
  );
  
  }
}


    

    