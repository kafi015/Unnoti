import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:unnoti/data/services/urls.dart';
import 'package:unnoti/ui/screens/authentication/sign_in_screen.dart';

import '../../widgets/app_elevated_button.dart';
import '../../widgets/app_text_form_field.dart';
import '../../widgets/screen_background.dart';
import 'otp_verification_screen.dart';

class SignUPScreen extends StatefulWidget {
  const SignUPScreen({Key? key}) : super(key: key);
  @override
  State<SignUPScreen> createState() => _SignUPScreenState();
}

class _SignUPScreenState extends State<SignUPScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController phoneETController = TextEditingController();
  TextEditingController passwordETController = TextEditingController();
  TextEditingController confirmpassETController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        backgroundImage: 'assets/authentication_background.png',
        widget: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
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
                    height: 150,
                  ),
                  SizedBox(
                    height: 530,
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
                              'Sign Up',
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
                              controller: phoneETController,
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return "Enter your mobile number";
                                }
                                if (value?.length != 11) {
                                  return "Phone number should be 11 digit";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            AppTextFormField(
                              hintText: 'Enter Password',
                              color: const Color(0xffF5F5F5),
                              controller: passwordETController,
                              validator: (value) {
                                if (
                                    //(value?.isEmpty ?? true) &&
                                    ((value?.length ?? 0) < 6)) {
                                  return "Enter password more then 6 letter";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            AppTextFormField(
                              hintText: 'Confirm Password',
                              color: const Color(0xffF5F5F5),
                              controller: confirmpassETController,
                              validator: (value) {
                                if ((value?.isEmpty ?? true) &&
                                    ((value?.length ?? 0) < 6)) {
                                  return "Enter password more then 6 letter";
                                }
                                if (passwordETController.text !=
                                    confirmpassETController.text) {
                                  return "Password don't match";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            AppElevatedButton(
                              text: 'Create Account',
                              color: const Color(0xFF8359E3),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {

                                  try {
                                    final http.Response response = await http.post(Uri.parse(Urls.registrationUrl),
                                        headers: {"Content-Type": "application/json"},
                                        body: jsonEncode({
                                          'phone_number':
                                          '+88${phoneETController.text}',
                                          'password': passwordETController.text
                                        }));

                                    // print(response.statusCode);

                                    if (response.statusCode == 201) {
                                      log(response.body);
                                      Map valueMap = jsonDecode(response.body);
                                      //print(valueMap);
                                    //  print(valueMap['otp']);

                                      Get.to(OTPVerficationScreen(otp: valueMap['otp'],phoneNumber: '+88${phoneETController.text}',));

                                    } else if (response.statusCode == 400) {
                                      Get.snackbar(
                                        "Error!",
                                        "User with this phone number already exists",
                                        snackPosition: SnackPosition.BOTTOM,
                                        backgroundColor: Colors.red,
                                        colorText: Colors.white,
                                        snackStyle: SnackStyle.FLOATING,

                                      );
                                    }  else {
                                      log("Something went wrong");
                                      Get.snackbar(
                                        "Error!",
                                        "Registration Failed",
                                        snackPosition: SnackPosition.BOTTOM,
                                        backgroundColor: Colors.red,
                                        colorText: Colors.white,
                                        snackStyle: SnackStyle.FLOATING,

                                      );
                                    }
                                  } catch (e) {
                                    log('Error $e');
                                  }

                                }


                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Divider(
                              color: Colors.grey,
                              thickness: 1,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Already have an account ?',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Color(0xff4D4D4D),
                                      fontWeight: FontWeight.w400),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Get.offAll(const SignInScreen());
                                  },
                                  child: const Text(
                                    'Sign In',
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
      ),
    );
  }
}
