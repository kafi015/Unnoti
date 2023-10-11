import 'package:flutter/material.dart';

class AppElevatedButton extends StatelessWidget {
  const AppElevatedButton({
    super.key,
    required this.text,
    required this.color,
    required this.onPressed,
  });

  final String text;
  final Color color;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(34.0)),
      ),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text,style: const TextStyle(fontSize: 22),),
            const SizedBox(
              width: 5,
            ),
            text == 'Get Started' ? const Icon(Icons.chevron_right) : const SizedBox(),
          ],
        ),
      ),
    );
  }
}