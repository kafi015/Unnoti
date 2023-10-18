import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/app_elevated_button.dart';
import '../widgets/screen_background.dart';
import 'authentication/sign_in_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {



  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: ScreenBackground(
        backgroundImage: 'assets/splash_background.png',
        widget: Padding(
          padding:  EdgeInsets.symmetric(horizontal: width*0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               SizedBox(
                height: height *0.7,
              ),
              AppElevatedButton(
                text: 'Get Started',
                color: const Color(0xff8359e3),
                onPressed: () {
                  Get.to(const SignInScreen());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}


