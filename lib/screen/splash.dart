import 'package:flutter/material.dart';
import 'package:litshelf/screen/onbroading.dart';
import 'package:litshelf/textstyle/text.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
     Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
         builder: (context) => Onbroading(),
        ),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [  const Color.fromARGB(255, 248, 227, 247),   
            const Color.fromARGB(255, 243, 237, 253),   
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/book.png",
              width: size.width * 0.9,height: size.height*0.10,
              ),
              SizedBox(height: size.height*0.02),
              Text("LitShelf",
              style: AppTextStyles.text26bb,
              ),
            ],
          ),
        ),
      ),
    );
  }
}