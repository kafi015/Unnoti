import 'package:flutter/material.dart';
import 'package:unnoti/ui/widgets/app_elevated_button.dart';
import 'package:unnoti/ui/widgets/app_text_form_field.dart';
import 'package:unnoti/ui/widgets/screen_background.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        backgroundImage: 'assets/authentication_background.png',
        widget: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 100,
                ),
                const Text(
                  'Unnoti',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 28,
                      letterSpacing: 2),
                ),
                const SizedBox(
                  height: 200,
                ),
                SizedBox(
                  height: 465,
                  width: double.infinity,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(34.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 20),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Sign In',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 26,
                                letterSpacing: 2),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          AppTextFormField(
                            hintText: 'Enter Phone number',
                            color: const Color(0xffF5F5F5),
                            controller: TextEditingController(),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          AppTextFormField(
                            hintText: 'Enter Password',
                            color: const Color(0xffF5F5F5),
                            controller: TextEditingController(),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          AppElevatedButton(
                            text: 'Log In',
                            color: const Color(0xFF8359E3),
                            onPressed: () {},
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Divider(
                            color: Colors.grey,
                            thickness: 1,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Forget Password ?',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400),
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'New ?',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Color(0xff4D4D4D),
                                    fontWeight: FontWeight.w400),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: const Text(
                                  'Sign Up',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          ),
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
