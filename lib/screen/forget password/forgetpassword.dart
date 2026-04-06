import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:litshelf/screen/provider/forgetpasswordprovider.dart';
import 'package:litshelf/screen/signin%20and%20signup/login.dart';
import 'package:litshelf/screen/forget%20password/password.dart';
import 'package:litshelf/theme/text.dart';
import 'package:litshelf/widget/customtextfield.dart';
import 'package:litshelf/widget/purplebutton.dart';

class Forgetpassword extends StatefulWidget {
  const Forgetpassword({super.key});

  @override
  State<Forgetpassword> createState() => _ForgetpasswordState();
}

class _ForgetpasswordState extends State<Forgetpassword> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final auth = Provider.of<Forgetpasswordprovider>(context);

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

                /// BACK BUTTON
                IconButton(
                  icon: const Icon(Icons.arrow_back, size: 30),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Login(),
                      ),
                    );
                  },
                ),

                /// TITLE
                Text("New password", style: AppTextStyles.des24bb),

                SizedBox(height: size.height * 0.01),

                Text(
                  "Create your new password, so you can login.",
                  style: AppTextStyles.text18g,
                ),

                SizedBox(height: size.height * 0.03),

                /// NEW PASSWORD
                Text("New Password", style: AppTextStyles.des18b),
                SizedBox(height: size.height * 0.01),

                CustomTextField(
                  hintText: "Your password",
                  hintStyle: AppTextStyles.text16g,
                  controller: passwordController,
                  obscureText: auth.obscureNewPassword,
                  icon: auth.obscureNewPassword
                      ? Icons.visibility_off
                      : Icons.visibility,
                  onIconTap: auth.toggleNewPassword,
                  onChanged: (value) {},
                ),

                SizedBox(height: size.height * 0.03),

                /// CONFIRM PASSWORD
                Text("Confirm Password", style: AppTextStyles.des18b),
                SizedBox(height: size.height * 0.01),

                CustomTextField(
                  hintText: "Confirm password",
                  hintStyle: AppTextStyles.text16g,
                  controller: confirmPasswordController,
                  obscureText: auth.obscureConfirmPassword,
                  icon: auth.obscureConfirmPassword
                      ? Icons.visibility_off
                      : Icons.visibility,
                  onIconTap: auth.toggleConfirmPassword,
                  onChanged: (value) {},
                ),

                SizedBox(height: size.height * 0.06),

                /// BUTTON
                PurpleButton(
                  text: "Send",
                  onTap: () {
                    final password = passwordController.text.trim();
                    final confirmPassword =
                        confirmPasswordController.text.trim();

                    if (auth.validate(password, confirmPassword)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Password updated successfully"),
                        ),
                      );

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Password(),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Password must match & be at least 6 characters",
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}