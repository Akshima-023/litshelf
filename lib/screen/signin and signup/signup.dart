import 'package:flutter/material.dart';
import 'package:litshelf/screen/signin%20and%20signup/authprovider.dart';
import 'package:litshelf/theme/text.dart';
import 'package:litshelf/widget/customtextfield.dart';
import 'package:litshelf/widget/purplebutton.dart';
import 'package:provider/provider.dart';
import 'register.dart';
import 'login.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

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
                      MaterialPageRoute(builder: (context) => const Login()),
                    );
                  },
                ),
                SizedBox(height: size.height * 0.001),
                Text("Sign Up", style: AppTextStyles.des24bb),
                SizedBox(height: size.height * 0.0001),
                Text("Create account and choose favourite menu",
                    style: AppTextStyles.text18g),
                SizedBox(height: size.height * 0.02),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Name", style: AppTextStyles.des18b),
                    SizedBox(height: size.height * 0.001),
                    CustomTextField(
                      hintText: "Enter your name",
                      controller: _nameController,
                      icon: null,
                    ),
                    SizedBox(height: size.height * 0.02),
                    Text("Email", style: AppTextStyles.des18b),
                    SizedBox(height: size.height * 0.001),
                    CustomTextField(
                      hintText: "Enter your email",
                      controller: _emailController,
                      icon: null,
                    ),
                    SizedBox(height: size.height * 0.02),
                    Text("Password", style: AppTextStyles.des18b),
                    SizedBox(height: size.height * 0.001),
                    CustomTextField(
                      hintText: "Enter your password",
                      obscureText: true,
                      controller: _passwordController,
                      icon: Icons.visibility_off,
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.05),
                auth.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : PurpleButton(
                        text: "Register",
                        onTap: () async {
                          final name = _nameController.text.trim();
                          final email = _emailController.text.trim();
                          final password = _passwordController.text.trim();

                          if (name.isEmpty || email.isEmpty || password.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Please fill all fields")),
                            );
                            return;
                          }

                          await auth.signUp(name, email, password);

                          if (auth.isLoggedIn) {
                            if (!mounted) return;
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (_) => const Register()),
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
                    Text("Have an account?", style: AppTextStyles.text18g),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Login()),
                        );
                      },
                      child: Text("Sign in", style: AppTextStyles.text18p),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.09),
                Center(
                    child: Text("By clicking Register,you agreed to our",
                        style: AppTextStyles.text18g)),
                Center(
                    child:
                        Text("Terms,Data Policy", style: AppTextStyles.text18p)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}