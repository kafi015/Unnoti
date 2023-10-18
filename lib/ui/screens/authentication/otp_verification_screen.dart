import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:unnoti/ui/screens/authentication/sign_in_screen.dart';

import '../../../data/services/urls.dart';
import '../../widgets/app_elevated_button.dart';
import '../../widgets/app_text_form_field.dart';
import '../../widgets/screen_background.dart';

class OTPVerficationScreen extends StatefulWidget {
  const OTPVerficationScreen({Key? key,required this.otp,required this.phoneNumber}) : super(key: key);

  final String otp;
  final String phoneNumber;

  @override
  State<OTPVerficationScreen> createState() => _OTPVerficationScreenState();
}

class _OTPVerficationScreenState extends State<OTPVerficationScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController otpETController = TextEditingController();

  bool inProgress = false;

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
                    height: 230,
                  ),
                  SizedBox(
                    height: 400,
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
                             Text(
                              'OTP\n${widget.otp}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 26,
                                  letterSpacing: 2),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            AppTextFormField(
                              hintText: 'Enter OTP',
                              color: const Color(0xffF5F5F5),
                              controller: otpETController,
                              validator: (value) {
                                if (
                                (value?.isEmpty ?? true)) {
                                  return "Please enter OTP for confirm.";
                                }
                                return null;
                              },
                            ),

                            const SizedBox(
                              height: 20,
                            ),
                            inProgress? const Center(child: CircularProgressIndicator(color: Color(0xFF8359E3),),):AppElevatedButton(
                              text: 'Confirm',
                              color: const Color(0xFF8359E3),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {

                                  try {
                                    inProgress = true;
                                    setState(() {});

                                    final http.Response response = await http.post(Uri.parse(Urls.verigyOTPUrl),
                                        headers: {"Content-Type": "application/json"},
                                        body: jsonEncode({
                                          'phone_number':
                                          widget.phoneNumber,
                                          'otp': otpETController.text
                                        }));

                                    // print(response.statusCode);

                                    if (response.statusCode == 200) {
                                      log(response.body);
                                      showAlertDialog(context);
                                    }
                                     else {
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
                                    inProgress = false;
                                    setState(() {});
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
                                  'Don\'t get OTP?',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Color(0xff4D4D4D),
                                      fontWeight: FontWeight.w400),
                                ),
                                TextButton(
                                  onPressed: () {

                                  },
                                  child: const Text(
                                    'Resent',
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
  showAlertDialog(BuildContext context) {

    // set up the button
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Get.to(const SignInScreen());
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Message"),
      content: const Text("Registration Complete."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
