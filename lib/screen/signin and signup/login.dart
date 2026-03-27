import 'package:flutter/material.dart';
import 'package:litshelf/screen/forget%20password/forgetpassword.dart';
import 'package:litshelf/screen/homescreen/dashboard.dart';
import 'package:litshelf/screen/onbroading%20and%20splash/onbroading.dart';
import 'package:litshelf/screen/signin%20and%20signup/authprovider.dart';
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
                IconButton(
                  icon: const Icon(Icons.arrow_back, size: 30),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const Onbroading()),
                    );
                  },
                ),
                SizedBox(height: size.height * 0.001),
                Row(
                  children: [
                    Text("Welcome Back", style: AppTextStyles.des24bb),
                    SizedBox(height: size.height * 0.03),
                    Center(
                      child: Image.asset(
                        "assets/waving-hand.png",
                        height: size.height * 0.06,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.0001),
                Text("Sign in to your account", style: AppTextStyles.text18g),
                SizedBox(height: size.height * 0.02),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Email", style: AppTextStyles.des18b),
                    SizedBox(height: size.height * 0.01),
                    CustomTextField(
                      controller: emailController,
                      hintText: "Enter your email",
                      icon: null,
                    ),
                    SizedBox(height: size.height * 0.02),
                    Text("Password", style: AppTextStyles.des18b),
                    SizedBox(height: size.height * 0.01),
                    CustomTextField(
                      controller: passwordController,
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
                              builder: (context) => const Forgetpassword()),
                        );
                      },
                      child: Text("Forgot Password?", style: AppTextStyles.text18p),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.01),
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
                                  content: Text(
                                      "Please enter email and password")),
                            );
                            return;
                          }

                          await auth.login(email, password);

                          if (auth.isLoggedIn) {
                            if (!mounted) return;
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const DashboardPage()),
                            );
                          } else if (auth.error != null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(auth.error!)),
                            );
                          }
                        },
                      ),
                SizedBox(height: size.height * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?", style: AppTextStyles.text18g),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Signup()),
                        );
                      },
                      child: Text(" Sign Up", style: AppTextStyles.text18p),
                    ),
                  ],
                ),
                // Or with Google / Apple UI remains the same
              ],
            ),
          ),
        ),
      ),
    );
  }
}