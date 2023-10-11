import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unnoti/ui/screens/splash_screen.dart';
import 'package:get/get.dart';

void main()
{
  runApp(const Unnoti());
}

class Unnoti extends StatelessWidget {
  const Unnoti({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

