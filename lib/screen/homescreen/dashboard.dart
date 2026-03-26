import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:litshelf/screen/cart%20and%20checkout/cartpage.dart';

import 'package:litshelf/screen/category/menu.dart';
import 'package:litshelf/screen/profile/profile.dart';
import 'package:litshelf/widget/_navItem.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'homepage.dart';



class DashboardPage extends StatefulWidget {
  final int selectedIndex;

  const DashboardPage({super.key, this.selectedIndex = 0});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late int _currentIndex;
  List<Map<String, dynamic>> cartItems = [];
  Future<List<Map<String, dynamic>>> loadCart() async {
  final prefs = await SharedPreferences.getInstance();
  String? cartString = prefs.getString('cart');

  if (cartString != null) {
    List decoded = jsonDecode(cartString);
    return decoded.cast<Map<String, dynamic>>();
  } else {
    return [];
  }
}

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.selectedIndex;
     loadCart().then((data) {
    setState(() {
      cartItems = data;
    });
  });
  }



  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    List<Widget> screens = [
      const HomePage(),
      const Menu(),
      CartPage(cartItems: cartItems),
   
      const Profile(),
    ];

    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,

      body: screens[_currentIndex],

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),

        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),

          child: BottomAppBar(
            color: Colors.white,

            child: SizedBox(
              height: size.height * 0.08,

              child: Row(
  mainAxisAlignment: MainAxisAlignment.spaceAround,
  children: [

    NavItem(
      index: 0,
      currentIndex: _currentIndex,
      icon: Icons.home_outlined,
      selectedIcon: Icons.home,
      onTap: (i) {
        setState(() {
          _currentIndex = i;
        });
      },
    ),

    NavItem(
      index: 1,
      currentIndex: _currentIndex,
      icon: Icons.category,
      selectedIcon: Icons.category,
      onTap: (i) {
        setState(() {
          _currentIndex = i;
        });
      },
    ),

    NavItem(
      index: 2,
      currentIndex: _currentIndex,
      icon: Icons.shopping_cart,
      selectedIcon: Icons.shopping_cart,
      onTap: (i) {
        setState(() {
          _currentIndex = i;
        });
      },
    ),

    NavItem(
      index: 3,
      currentIndex: _currentIndex,
      icon: Icons.person_outline,
      selectedIcon: Icons.person,
      onTap: (i) {
        setState(() {
          _currentIndex = i;
        });
      },
    ),

  ],
)
            ),
          ),
        ),
      ),
    );
  }

 }