import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unnoti/ui/widgets/app_elevated_button.dart';
import 'package:unnoti/ui/widgets/screen_background.dart';

import '../widgets/app_text_form_field.dart';

class EnterCuponCode extends StatelessWidget {
  const EnterCuponCode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        backgroundImage: 'assets/home_background.png',
        widget: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 100,
                ),
                TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.red,
                      ),
                    )),
                const SizedBox(
                  height: 50,
                ),
                Center(
                    child: Image.asset(
                  'assets/jems_icon.png',
                  height: 80,
                  width: 50,
                  fit: BoxFit.fill,
                )),
                const SizedBox(
                  height: 30,
                ),
                const Center(
                  child: Text(
                    'Your Current point',
                    style: TextStyle(fontSize: 22),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Center(
                  child: Text(
                    '100',
                    style: TextStyle(
                      fontSize: 22,
                      color: Color(0xfffd00e4),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: Card(
                    color: const Color(0xffd8c5df),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 20.0),
                      child: Column(
                        children: [
                          AppTextFormField(
                            hintText: 'Enter the Cupon code',
                            color: Colors.white,
                            controller: TextEditingController(),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          AppElevatedButton(
                              text: 'Submit',
                              color: const Color(0xff8359E3),
                              onPressed: () {})
                        ],
                      ),
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


