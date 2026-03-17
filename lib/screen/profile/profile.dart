import 'package:flutter/material.dart';
import 'package:litshelf/screen/profile/address.dart';
import 'package:litshelf/screen/profile/myaccount.dart';
import 'package:litshelf/theme/text.dart';
import 'package:litshelf/widget/profile_item.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
 

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20,left: 20,right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height * 0.02),
               Center(
                child: Text(
                  "Profile",
                  style:AppTextStyles.des20bw
                ),
              ),
              SizedBox(height: size.height * 0.05),
               Container(height: size.height*0.001,width: double.infinity,
                color: const Color.fromARGB(255, 216, 215, 215),),
                 SizedBox(height: size.height * 0.03),
              Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage("assets/profile_pic-removebg-preview.png"),
                  ),
                   SizedBox(width:size.height*0.02 ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Mia",
                        style: AppTextStyles.text16bb
                      ),
                      Text(
                        "(+1) 234 567 890",
                        style:AppTextStyles.text16g
                      ),
                      
                    ],
                  ),
                  const Spacer(),
                  Text(
                    "Logout",
                    style: AppTextStyles.text16r
                  ),
                ],
              ),
               SizedBox(height: size.height * 0.03),
              Container(height: size.height*0.001,width: double.infinity,
                color: const Color.fromARGB(255, 216, 215, 215),),
                SizedBox(height: size.height * 0.02),
              ProfileItem(
                icon: Icons.person,
                title: "My Account",
                onTap: () {
                  Navigator.push(context,
                  MaterialPageRoute(
                    builder: (context) => const Myaccount(),
                  ),
                );
                },
              ),
              ProfileItem(
                icon: Icons.location_on,
                title: "Address",
                onTap: () {
                  Navigator.push(context,
                  MaterialPageRoute(
                    builder: (context) => const Address(),
                  ),
                );
                },
              ),
              ProfileItem(
                icon: Icons.local_offer,
                title: "Offers & Promos",
              ),
              ProfileItem(
                icon: Icons.favorite,
                title: "Your Favorites",
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
  
