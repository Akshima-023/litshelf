import 'package:flutter/material.dart';
import 'package:litshelf/screen/signin%20and%20signup/login.dart';
import 'package:litshelf/screen/forget%20password/password.dart';
import 'package:litshelf/theme/text.dart';
import 'package:litshelf/widget/customfield.dart';
import 'package:litshelf/widget/purplebutton.dart';

class Forgetpassword extends StatefulWidget {
  const Forgetpassword({super.key});
  @override
  State<Forgetpassword> createState() => _ForgetpasswordState();
}

class _ForgetpasswordState extends State<Forgetpassword> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.height * 0.02),
                IconButton(
                  icon: const Icon(Icons.arrow_back,size: 30,),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                       builder: (context) => const Login(),
                      ),
                    );
                  },
                ),
                SizedBox(height: size.height * 0.001),
                Row(
                  children: [
                    Text(
                      "New password",
                      style: AppTextStyles.des24bb,
                    ),
                    SizedBox(height: size.height * 0.03),
                  ],
                ),
                SizedBox(height: size.height * 0.0001),
                Text(
                  "Create your new password,so you can login to your account.",
                  style: AppTextStyles.text18g,
                ),
               SizedBox(height: size.height * 0.03),
               Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                  "New Password",
                  style: AppTextStyles.des18b,
                  ),
                  SizedBox(height:size.height*0.01),
                  CustomTextField(
                    hintText: "Your password",
                    obscureText: true,
                    icon: Icons.visibility_off,
                  ),
                  SizedBox(height: size.height * 0.03),
                  Text(
                  "Confirm Password",
                  style: AppTextStyles.des18b,
                  ),
                  SizedBox(height:size.height*0.01),
                  CustomTextField(
                    hintText: "Your password",
                    obscureText: true,
                    icon: Icons.visibility_off,
                    ),
                  SizedBox(height: size.height * 0.08),
                ],
              ),
              PurpleButton(text: "send", onTap: (){
               Navigator.push(
                  context,
                    MaterialPageRoute(
                      builder: (context) => const Password(),
                    ),
                  );
                }
              )
            ]
          ),
        )
      )
    )
  );
            
  }
}