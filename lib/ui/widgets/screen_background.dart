import 'package:flutter/material.dart';

class ScreenBackground extends StatelessWidget {

  const ScreenBackground(
      {super.key, required this.backgroundImage, required this.widget});

  final String backgroundImage;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          backgroundImage,
          fit: BoxFit.fitHeight,
        ),
        widget,

      ],
    );
  }
}