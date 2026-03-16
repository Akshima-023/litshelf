import 'package:flutter/material.dart';
import 'package:litshelf/screen/signin%20and%20signup/login.dart';
import 'package:litshelf/theme/text.dart';
import 'package:litshelf/widget/purplebutton.dart';

class Password extends StatefulWidget {
  const Password({super.key});
  @override
  State<Password> createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  @override
  Widget build(BuildContext context) {
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
                "Password Changed!",
                textAlign: TextAlign.center,
                style: AppTextStyles.des20bw,
              ),
              SizedBox(height: size.height * 0.02),
              Text(
                "Password changed successfully ,you can login again with a new password.",
                textAlign: TextAlign.center,
                style: AppTextStyles.text18g,
              ),
              SizedBox(height: size.height * 0.05),
              PurpleButton(
                text: "login",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  Login(),
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