import 'package:flutter/material.dart';
import 'package:litshelf/screen/forget%20password/forgetpassword.dart';
import 'package:litshelf/screen/homescreen/homepage.dart';
import 'package:litshelf/screen/onbroading%20and%20splash/onbroading.dart';
import 'package:litshelf/screen/signin%20and%20signup/signup.dart';
import 'package:litshelf/theme/text.dart';
import 'package:litshelf/widget/customtextfield.dart';
import 'package:litshelf/widget/purplebutton.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
                    builder: (context) => const Onbroading(),
                  ),
                );
              },
            ),
            SizedBox(height: size.height * 0.001),
            Row(
              children: [
                Text(
                    "Welcome Back",
                    style: AppTextStyles.des24bb,
                    ),
                SizedBox(height: size.height * 0.03),
                Center(
                  child: Image.asset(
                    "assets/waving-hand.png", 
                    height: size.height*0.06,
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.0001),
            Text(
                  "Sign  to your account",
                  style: AppTextStyles.text18g,
                ),
            SizedBox(height: size.height * 0.02),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Email",
                  style: AppTextStyles.des18b,
                ),
                SizedBox(height:size.height*0.01),
                CustomTextField(
                  hintText: "Enter your email",
                  icon: null,
                ),
                SizedBox(height: size.height * 0.02),
                Text(
                  "Password",
                  style: AppTextStyles.des18b,
                ),
                SizedBox(height:size.height*0.01),
                CustomTextField(
                  hintText: "Enter your password",
                  obscureText: true,
                  icon: Icons.visibility_off,
                ),
                SizedBox(height: size.height * 0.01),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                        MaterialPageRoute(
                        builder: (context) => const Forgetpassword(),
                        ),
                      );
                    },
                    child:  Text(
                      "Forgot Password?",
                      style:AppTextStyles.text18p
                    ),
                  ),
              ],
            ),
            SizedBox(height: size.height * 0.01),
            PurpleButton(
              text: "Login",
              onTap: () { 
                 Navigator.push(
                    context,
                    MaterialPageRoute(
                    builder: (context) => const Homepage(),
                    ),
                    );
              },
            ),
            SizedBox(height: size.height*0.02,),
            Row(
              mainAxisAlignment: .center,
              children: [
                Text("Don't have an account?",style: AppTextStyles.text18g,),
                GestureDetector(
                   onTap: () {
                   Navigator.push(
                    context,
                    MaterialPageRoute(
                    builder: (context) => const Signup(),
                    ),
                    );
                    },
                    child: Text("Sign Up",style: AppTextStyles.text18p,))
              ],
            ),SizedBox(height: size.height*0.02,),
            Row(mainAxisAlignment: .spaceBetween,
              children: [
                Container(height: size.height*0.001,width: size.width*0.35,
                color: const Color.fromARGB(255, 216, 215, 215),),
                Text("Or with",style: AppTextStyles.text18g,),
                 Container(height: size.height*0.001,width: size.width*0.35,
                color: const Color.fromARGB(255, 209, 206, 206),),
              ],
            ),SizedBox(height: size.height*0.04,),
            Container(
              width: double.infinity,
              height: size.height * 0.06,
              decoration: BoxDecoration(
                border: Border.all(color: const Color.fromARGB(255, 215, 214, 214)),
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/google.png",
                    height: size.height*0.04,
                  ),
             SizedBox(width: size.width*0.02),
                  Text(
                    "Sign in with Google",
                    style: AppTextStyles.text16b,
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height*0.02,),
            Container(
              width: double.infinity,
              height: size.height * 0.06,
              decoration: BoxDecoration(
                border: Border.all(color: const Color.fromARGB(255, 206, 205, 205)),
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/apple-logo.png", 
                    height:size.height*0.04,
                  ),
                  SizedBox(width:size.width*0.02),
                  Text(
                    "Sign in with Apple",
                    style: AppTextStyles.text16b,
                  ),
                ],
              ),
            )
            ]),
          )
          ),
        ),
    );
  }
}