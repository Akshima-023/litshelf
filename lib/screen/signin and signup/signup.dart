import 'package:flutter/material.dart';
import 'package:litshelf/screen/signin%20and%20signup/Register.dart';
import 'package:litshelf/screen/signin%20and%20signup/login.dart';
import 'package:litshelf/theme/text.dart';
import 'package:litshelf/widget/customtextfield.dart';
import 'package:litshelf/widget/purplebutton.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
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
                   Text(
                     "Sign Up",
                     style: AppTextStyles.des24bb,
                   ),                  
                SizedBox(height: size.height * 0.0001),
                Text(
                  "Create account and choose favourite menu",
                  style: AppTextStyles.text18g,
                ),
               SizedBox(height: size.height * 0.02),            
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Name",
                  style: AppTextStyles.des18b,
                ),            
                SizedBox(height:size.height*0.001),            
                CustomTextField(
                  hintText: "Enter your name",
                  icon: null,
                ),           
                SizedBox(height: size.height * 0.02),
                Text(
                  "Email",
                  style: AppTextStyles.des18b,
                ),            
                SizedBox(height:size.height*0.001),            
                CustomTextField(
                  hintText: "Enter your email",
                  icon: null,
                ),           
                SizedBox(height: size.height * 0.02),              
                Text(
                  "Password",
                  style: AppTextStyles.des18b,
                ),            
                SizedBox(height:size.height*0.001),            
                CustomTextField(
                  hintText: "Enter your password",
                  obscureText: true,
                    icon: Icons.visibility_off,
                ),                      
              ],
            ),           
            SizedBox(height: size.height * 0.05),          
            PurpleButton(
              text: "Register",
              onTap: () {
               Navigator.push(
              context,
              MaterialPageRoute(
              builder: (context) =>  Register(),
              ),
              );
              },
            ),SizedBox(height: size.height*0.02,),
            Row(mainAxisAlignment: .center,
              children: [
                Text("Have an account?",style: AppTextStyles.text18g,),
                GestureDetector(onTap: (){
                   Navigator.push(
              context,
              MaterialPageRoute(
              builder: (context) =>  Login(),
              ),
              );
                },
                  child: Text("Sign in",style: AppTextStyles.text18p,))
              ],
            ),SizedBox(height: size.height*0.09,),
            Center(child: Text("By clicking Register,you agreed to our",style: AppTextStyles.text18g,)),
            Center(child: Text("Terms,Data Policy",style: AppTextStyles.text18p,))
          ]
        )
        )
      )
    )
    );
  }
}