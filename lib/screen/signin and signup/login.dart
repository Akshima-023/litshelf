import 'package:flutter/material.dart';
import 'package:litshelf/screen/forget%20password/forgetpassword.dart';
import 'package:litshelf/screen/homescreen/dashboard.dart';
import 'package:litshelf/screen/onbroading%20and%20splash/onbroading.dart';
import 'package:litshelf/screen/provider/authprovider.dart';
import 'package:litshelf/theme/text.dart';
import 'package:litshelf/widget/customtextfield.dart';
import 'package:litshelf/widget/purplebutton.dart';
import 'package:provider/provider.dart';
import 'signup.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _obscurePassword = true; // ✅ added

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
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

                /// BACK BUTTON
                IconButton(
                  icon: const Icon(Icons.arrow_back, size: 30),
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

                /// HEADER
                Row(
                  children: [
                    Text("Welcome Back", style: AppTextStyles.des24bb),
                    const SizedBox(width: 8),
                    Image.asset(
                      "assets/waving-hand.png",
                      height: size.height * 0.06,
                    ),
                  ],
                ),

                SizedBox(height: size.height * 0.0001),

                Text(
                  "Sign in to your account",
                  style: AppTextStyles.text18g,
                ),

                SizedBox(height: size.height * 0.02),

                /// EMAIL
                Text("Email", style: AppTextStyles.des18b),
                SizedBox(height: size.height * 0.01),

                CustomTextField(
                  controller: emailController,
                  hintText: "Enter your email",
                  hintStyle: AppTextStyles.text16g,
                  obscureText: false,
                  onChanged: (value) {},
                ),

                SizedBox(height: size.height * 0.02),

                /// PASSWORD
                Text("Password", style: AppTextStyles.des18b),
                SizedBox(height: size.height * 0.01),

                CustomTextField(
                  controller: passwordController,
                  hintText: "Enter your password",
                  hintStyle: AppTextStyles.text16g,

                  obscureText: _obscurePassword,

                  icon: _obscurePassword
                      ? Icons.visibility_off
                      : Icons.visibility,

                  onIconTap: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },

                  onChanged: (value) {},
                ),

                SizedBox(height: size.height * 0.01),

                /// FORGOT PASSWORD
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Forgetpassword(),
                      ),
                    );
                  },
                  child: Text(
                    "Forgot Password?",
                    style: AppTextStyles.text18p,
                  ),
                ),

                SizedBox(height: size.height * 0.01),

                /// LOGIN BUTTON
                auth.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : PurpleButton(
                        text: "Login",
                        onTap: () async {
                          final email = emailController.text.trim();
                          final password = passwordController.text.trim();

                          if (email.isEmpty || password.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text("Please enter email and password"),
                              ),
                            );
                            return;
                          }

                          await auth.login(email, password);

                          if (auth.isLoggedIn) {
                            if (!mounted) return;
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const DashboardPage(),
                              ),
                            );
                          } else if (auth.error != null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(auth.error!)),
                            );
                          }
                        },
                      ),

                SizedBox(height: size.height * 0.02),

                /// SIGN UP LINK
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?",
                        style: AppTextStyles.text18g),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Signup(),
                          ),
                        );
                      },
                      child: Text(
                        " Sign Up",
                        style: AppTextStyles.text18p,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}