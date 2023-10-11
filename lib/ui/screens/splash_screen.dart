import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/app_elevated_button.dart';
import '../widgets/screen_background.dart';
import 'authentication/sign_in_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        backgroundImage: 'assets/splash_background.png',
        widget: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 700,
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


