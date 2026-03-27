import 'dart:io';
import 'package:flutter/material.dart';
import 'package:litshelf/screen/profile/address.dart';
import 'package:litshelf/screen/profile/favouritespage.dart';
import 'package:litshelf/screen/profile/myaccount.dart';
import 'package:litshelf/screen/signin and signup/login.dart';
import 'package:litshelf/theme/text.dart';
import 'package:litshelf/widget/profile_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String name = "";
  String phone = "";
  File? imageFile;

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

 
  void loadUserData() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      name = prefs.getString("user_name") ?? "User";
      phone = prefs.getString("user_phone") ?? "No phone";

      String? imagePath = prefs.getString("user_image");
      if (imagePath != null) {
        imageFile = File(imagePath);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height * 0.02),

              Center(
                child: Text("Profile", style: AppTextStyles.des20bw),
              ),

              SizedBox(height: size.height * 0.05),

              Container(
                height: size.height * 0.001,
                width: double.infinity,
                color: const Color.fromARGB(255, 216, 215, 215),
              ),

              SizedBox(height: size.height * 0.03),

              Row(
                children: [
                  CircleAvatar(
                    radius: 55,
                    backgroundImage: imageFile != null
                        ? FileImage(imageFile!)
                        : const AssetImage("assets/default_user.png")
                            as ImageProvider,
                  ),

                  SizedBox(width: size.height * 0.02),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Text(name, style: AppTextStyles.text16bb),
                      const SizedBox(height: 10),
                      Text(phone, style: AppTextStyles.text16g),
                    ],
                  ),

                  const Spacer(),

                  
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Logout"),
                          content: const Text(
                              "Are you sure you want to logout?"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Cancel"),
                            ),
                            TextButton(
                              onPressed: () async {
                                final prefs =
                                    await SharedPreferences.getInstance();
                                await prefs.clear();

                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Login()),
                                  (route) => false,
                                );
                              },
                              child: const Text("Logout"),
                            ),
                          ],
                        ),
                      );
                    },
                    child:
                        Text("Logout", style: AppTextStyles.text16r),
                  ),
                ],
              ),

              SizedBox(height: size.height * 0.03),

              Container(
                height: size.height * 0.001,
                width: double.infinity,
                color: const Color.fromARGB(255, 216, 215, 215),
              ),

              SizedBox(height: size.height * 0.02),

              ProfileItem(
                icon: Icons.person,
                title: "My Account",
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MyAccountPage()),
                  );

                  loadUserData(); 
                },
              ),

              ProfileItem(
                icon: Icons.location_on,
                title: "Address",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Address()),
                  );
                },
              ),

              ProfileItem(
                icon: Icons.local_offer,
                title: "Offers & Promos",
              ),

              ProfileItem(
                icon: Icons.location_on,
                title: "Your Fourites",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FavoritesPage()),
                  );
                },
              ),

              ProfileItem(
                icon: Icons.receipt,
                title: "Order History",
              ),

              ProfileItem(
                icon: Icons.help,
                title: "Help Center",
              ),
            ],
          ),
        ),
      ),
    );
  }
}