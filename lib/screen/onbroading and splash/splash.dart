import 'package:flutter/material.dart';
import 'package:litshelf/screen/signin%20and%20signup/authprovider.dart';
import 'package:provider/provider.dart';

import '../homescreen/dashboard.dart';
import '../signin and signup/login.dart';

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
    final auth = Provider.of<AuthProvider>(context, listen: false);

    // Wait until provider finishes initialization
    while (auth.isInitializing) {
      await Future.delayed(const Duration(milliseconds: 100));
    }

    await Future.delayed(const Duration(seconds: 1)); // optional splash delay

    if (auth.isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const DashboardPage()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const Login()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}