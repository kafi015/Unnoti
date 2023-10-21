import 'package:flutter/material.dart';

class ActivityCard extends StatelessWidget {
  const ActivityCard({
    super.key, required this.image, required this.title, required this.onTap,
  });
  final String image;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 130,
        width: 100,
        child: Card(
          color: const Color(0xffE6E0F4),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)),
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0,bottom: 10.0),
            child: Column(
              children: [

                Expanded(
                  flex: 8,
                  child: Image.asset(
                    image,
                    scale: 2,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xff404040),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
