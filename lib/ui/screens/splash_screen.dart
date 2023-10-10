import 'package:flutter/material.dart';

import '../widgets/screen_background.dart';

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
              SizedBox(height: 700,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff8359e3),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(34.0)),
                ),
                onPressed: () {

                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Get Started'),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(Icons.chevron_right)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


