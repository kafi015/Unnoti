import 'package:flutter/material.dart';
import 'package:unnoti/ui/widgets/screen_background.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        backgroundImage: 'assets/home_background.png',
        widget: Column(
          children: [

          ],
        ),
      ),
    );
  }
}
