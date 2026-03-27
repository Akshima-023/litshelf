import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:litshelf/theme/text.dart';
import 'package:litshelf/widget/customtextfield.dart';
import 'package:litshelf/widget/purplebutton.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyAccountPage extends StatefulWidget {
  const MyAccountPage({super.key});

  @override
  State<MyAccountPage> createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  File? _imageFile;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadUserData(); // 🔥 load saved data
  }

  // ✅ LOAD DATA
  void loadUserData() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      _nameController.text = prefs.getString("user_name") ?? "";
      _phoneController.text = prefs.getString("user_phone") ?? "";
      _emailController.text = prefs.getString("user_email") ?? "";
      _passwordController.text = prefs.getString("user_password") ?? "";

      String? imagePath = prefs.getString("user_image");
      if (imagePath != null) {
        _imageFile = File(imagePath);
      }
    });
  }

  // ✅ IMAGE PICK
  void _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      final prefs = await SharedPreferences.getInstance();

      setState(() {
        _imageFile = File(pickedFile.path);
      });

      // 🔥 SAVE IMAGE PATH
      await prefs.setString("user_image", pickedFile.path);
    }
  }

  // ✅ DIALOG
  void _showPickOptionsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Select option"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text("Gallery"),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text("Camera"),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
            if (_imageFile != null)
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: const Text("Remove Photo"),
                onTap: () async {
                  final prefs = await SharedPreferences.getInstance();

                  Navigator.pop(context);

                  setState(() {
                    _imageFile = null;
                  });

                  await prefs.remove("user_image"); // 🔥 remove saved image
                },
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.height * 0.02),

                // 🔹 HEADER
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
                          style: AppTextStyles.des20bw,
                        ),
                      ),
                    ),
                    SizedBox(width: size.width * 0.04),
                  ],
                ),

                SizedBox(height: size.height * 0.02),

                // 🔹 PROFILE IMAGE
                Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 55,
                        backgroundImage: _imageFile != null
                            ? FileImage(_imageFile!)
                            : const AssetImage(
                                    "assets/default_user.png")
                                as ImageProvider,
                      ),
                      SizedBox(height: size.height * 0.02),
                      GestureDetector(
                        onTap: _showPickOptionsDialog,
                        child: Text(
                          "Change Picture",
                          style: AppTextStyles.text18p,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: size.height * 0.02),

                // 🔹 NAME
                Text("Name", style: AppTextStyles.des18b),
                CustomTextField(
                  hintText: "Enter your name",
                  controller: _nameController,
                  icon: null,
                ),

                SizedBox(height: size.height * 0.02),

                // 🔹 PHONE
                Text("Phone Number", style: AppTextStyles.des18b),
                CustomTextField(
                  hintText: "Enter your phone number",
                  controller: _phoneController,
                  icon: null,
                ),

                SizedBox(height: size.height * 0.02),

                // 🔹 EMAIL
                Text("Email", style: AppTextStyles.des18b),
                CustomTextField(
                  hintText: "Enter your email",
                  controller: _emailController,
                  icon: null,
                ),

                SizedBox(height: size.height * 0.02),

                // 🔹 PASSWORD
                Text("Password", style: AppTextStyles.des18b),
                CustomTextField(
                  hintText: "Enter your password",
                  obscureText: true,
                  controller: _passwordController,
                  icon: Icons.visibility_off,
                ),

                SizedBox(height: size.height * 0.05),

                // 🔹 SAVE BUTTON
                PurpleButton(
                  text: "Save Changes",
                  onTap: () async {
                    final prefs =
                        await SharedPreferences.getInstance();

                    // 🔥 SAVE EVERYTHING
                    await prefs.setString(
                        "user_name", _nameController.text);
                    await prefs.setString(
                        "user_phone", _phoneController.text);
                    await prefs.setString(
                        "user_email", _emailController.text);
                    await prefs.setString(
                        "user_password", _passwordController.text);

                    Navigator.pop(context);
                  },
                ),

                SizedBox(height: size.height * 0.04),
              ],
            ),
          ),
        ),
      ),
    );
  }
}