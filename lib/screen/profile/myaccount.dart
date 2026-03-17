import 'package:flutter/material.dart';
import 'package:litshelf/theme/text.dart';
import 'package:litshelf/widget/customtextfield.dart';
import 'package:litshelf/widget/purplebutton.dart';

class Myaccount extends StatefulWidget {
  const Myaccount({super.key});

  @override
  State<Myaccount> createState() => _MyaccountState();
}

class _MyaccountState extends State<Myaccount> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return  Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20,right: 20,left: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.height * 0.02),              
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          "My Account",
                          style: AppTextStyles.des20bw
                        ),
                      ),
                    ),
                   SizedBox(width: size.width*0.04), 
                  ],
                ),
                SizedBox(height: size.height * 0.02),               
                Center(
                  child: Column(
                    children: [
                      const CircleAvatar(
                        radius: 55,
                        backgroundImage:
                            AssetImage("assets/profile_pic-removebg-preview.png"),
                      ),
                       SizedBox(height:size.height*0.02),
                       Text(
                        "Change Picture",
                        style:AppTextStyles.text18p
                      ),
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.01),
                
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
                  "Phone Number",
                  style: AppTextStyles.des18b,
                ),            
                SizedBox(height:size.height*0.001),            
                CustomTextField(
                  hintText: "Enter your phone number",
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
                SizedBox(height:size.height*0.05),    
                 PurpleButton(
              text: "Save Changes",
              onTap: () {
               
              },                           
            )],
            
            
          )
        )
      )
      )
    );

  }
}
