import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unnoti/ui/widgets/screen_background.dart';

class GellaryDetailsView extends StatelessWidget {
  const GellaryDetailsView({Key? key, required this.title, required this.image})
      : super(key: key);

  final String title;
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
                const SizedBox(
                  height: 30,
                ),
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
                const SizedBox(
                  height: 50,
                ),
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 22,
                      color: Color(0xff404040),
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 40,
                ),
                Center(
                  child: Image.network('https://abdulazizhardware.com$image'),
                ),
                const SizedBox(
                  height: 20,
                ),
                // const Text(
                //   'Description : ',
                //   style: TextStyle(
                //       fontSize: 22,
                //       color: Color(0xff404040),
                //       fontWeight: FontWeight.w600),
                // ),
                // const SizedBox(height: 20,),
                // Expanded(
                //   child: SingleChildScrollView(
                //     physics: const BouncingScrollPhysics(),
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Text(
                //           description,
                //           style: const TextStyle(
                //               fontSize: 18,
                //               color: Color(0xff404040),
                //               fontWeight: FontWeight.w400),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
