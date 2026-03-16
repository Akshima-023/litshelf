import 'package:flutter/material.dart';
import 'package:litshelf/screen/signin%20and%20signup/login.dart';
import 'package:litshelf/theme/text.dart';
import 'package:litshelf/widget/onbroad.dart';
import 'package:litshelf/widget/purplebutton.dart';


class Onbroading extends StatefulWidget {
  const Onbroading({super.key});

  @override
  State<Onbroading> createState() => _OnbroadingState();
}

class _OnbroadingState extends State<Onbroading> {

  final PageController _controller = PageController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {

    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20,left: 20,right: 20),

          child: Column(
            children: [

              SizedBox(height: size.height * 0.05),

            
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(context, 
                      MaterialPageRoute(
        builder: (context) => const Login(),
      ),);
                    },
                    child: Text(
                      "Skip",
                      style: AppTextStyles.text18p,
                    ),
                  )
                ],
              ),

              

             
              SizedBox(
  height: size.height * 0.50,
                child: PageView(
                  controller: _controller,
                  onPageChanged: (index){
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  children: const [
                                
                    OnboardingWidget(
                      image: "assets/onbroad_3-removebg.png",
                      title: "Now Reading books will be easier",
                      description:
                      "Discover new words, join a vibrant reading community. Start your reading adventure effortlessly with us.",
                    ),
                                
                    OnboardingWidget(
                      image: "assets/onbroad1-removebg.png",
                      title: "Your Bookish Soulmate Awaits",
                      description:
                      "Discover new words, join a vibrant reading community. Start your reading adventure effortlessly with us.",
                    ),
                                
                    OnboardingWidget(
                      image: "assets/onbroad_2-removebg.png",
                      title: "Start Your Adventure",
                      description:
                      "Discover new words, join a vibrant reading community. Start your reading adventure effortlessly with us.",
                    ),
                                
                  ],
                ),
              ),

              SizedBox(height: size.height * 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  3,
                  (index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    height:size.height*0.01,
                    width: currentIndex == index ? 20 : 8,
                    decoration: BoxDecoration(
                      color: currentIndex == index
                          ?  const Color.fromARGB(255, 90, 40, 207)
                          : Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),

              SizedBox(height: size.height * 0.06),
              

/// Get Started Button
PurpleButton(
  text: currentIndex == 0 ? "Continue" : "Get Started",
  onTap: () {
    if (currentIndex < 2) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      
    }
  },
),

SizedBox(height: size.height * 0.015),

/// Sign In
Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children:  [
   
    GestureDetector( onTap: () {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const Login(),
      ),
    );
  },
      child: Text(
        "Sign in",
         style: AppTextStyles.text18p
      ),
    ),
  ],
),
            ],
          ),
        ),
      ),
    );
  }
}