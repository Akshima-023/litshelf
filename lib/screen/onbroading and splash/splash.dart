import 'dart:async';
import 'package:flutter/material.dart';
import 'package:litshelf/screen/onbroading%20and%20splash/onbroading.dart';
import 'package:litshelf/screen/provider/authprovider.dart';
import 'package:litshelf/screen/homescreen/dashboard.dart';
import 'package:litshelf/theme/text.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
    _navigate();
  }

  Future<void> _navigate() async {
    /// Wait for splash duration
    await Future.delayed(const Duration(seconds: 2));

    final auth = Provider.of<AuthProvider>(context, listen: false);

    /// Optional: wait if still initializing
    if (auth.isInitializing) {
      await Future.delayed(const Duration(seconds: 1));
    }

    if (!mounted) return;

    if (auth.isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const DashboardPage()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) =>Onbroading() ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 210, 185, 214),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [
           Image.asset("assets/book.png",width: size.width*0.3,
           height: size.height*0.3,),
            SizedBox(height: size.height*0.001),
            Text(
              "LitShelf",
              style: AppTextStyles.des24bb
            ),
            SizedBox(height:size.height*0.02),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}