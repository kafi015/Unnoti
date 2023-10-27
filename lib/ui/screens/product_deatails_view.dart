import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unnoti/ui/widgets/screen_background.dart';

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView(
      {Key? key,
      required this.title,
      required this.description,
      required this.image})
      : super(key: key);

  final String title;
  final String description;
  final String image;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ScreenBackground(
          backgroundImage: 'assets/home_background.png',
          widget: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Row(
                      children: [
                        Icon(
                          Icons.arrow_back,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Back',
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    )),
                Center(
                  child: Image.network(image),
                ),
                const SizedBox(height: 20,),
                Text(
                  'Title : $title',
                  style: const TextStyle(
                      fontSize: 22,
                      color: Color(0xff404040),
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 20,),
                const Text(
                  'Description : ',
                  style: TextStyle(
                      fontSize: 22,
                      color: Color(0xff404040),
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 20,),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          description,
                          style: const TextStyle(
                              fontSize: 18,
                              color: Color(0xff404040),
                              fontWeight: FontWeight.w400),
                        ),
                      ],
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
