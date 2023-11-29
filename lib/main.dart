import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unnoti/ui/screens/splash_screen.dart';
import 'package:get/get.dart';

void main() {
  runApp(const Unnoti());
}

class Unnoti extends StatefulWidget {
  const Unnoti({Key? key}) : super(key: key);
  static GlobalKey<NavigatorState> globalKey = GlobalKey<NavigatorState>();

  @override
  State<Unnoti> createState() => _UnnotiState();
}

class _UnnotiState extends State<Unnoti> {

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      theme: ThemeData(
        fontFamily: 'Montserrat'
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
