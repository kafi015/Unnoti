import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unnoti/ui/screens/splash_screen.dart';

void main()
{
  runApp(Unnoti());
}

class Unnoti extends StatelessWidget {
  const Unnoti({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

