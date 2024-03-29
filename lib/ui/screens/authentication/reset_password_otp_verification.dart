import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:unnoti/ui/screens/authentication/reset_password_screen.dart';

import '../../../data/services/urls.dart';
import '../../widgets/app_elevated_button.dart';
import '../../widgets/app_text_form_field.dart';
import '../../widgets/screen_background.dart';

class ResetPasswordForOTPVerification extends StatefulWidget {
  const ResetPasswordForOTPVerification({Key? key,required this.phoneNumber}) : super(key: key);

  final String phoneNumber;

  @override
  State<ResetPasswordForOTPVerification> createState() => _ResetPasswordForOTPVerificationState();
}

class _ResetPasswordForOTPVerificationState extends State<ResetPasswordForOTPVerification> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController otpETController = TextEditingController();

  bool inProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
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
                    height: 130,
                  ),
                  SizedBox(
                    height: 330,
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
                              'OTP',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 26,
                                  letterSpacing: 2),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            AppTextFormField(
                              hintText: 'Enter OTP',
                              color:  Colors.grey.shade300,
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
                               // Get.to(const ResetPassWordScreen());
                                if (_formKey.currentState!.validate()) {

                                  try {
                                    inProgress = true;
                                    setState(() {});

                                    final http.Response response = await http.post(Uri.parse(Urls.verifyResetPasswordOtp),
                                        headers: {"Content-Type": "application/json"},
                                        body: jsonEncode({
                                          'phone_number':
                                          widget.phoneNumber,
                                          'otp': otpETController.text
                                        }));

                                     log(response.statusCode.toString());

                                    if (response.statusCode == 200) {
                                      log(response.body);
                                      // showAlertDialog(context);
                                      Get.to( ResetPassWordScreen(phoneNumber: widget.phoneNumber,));

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
                                      fontSize: 16,
                                      color: Color(0xff4D4D4D),
                                      fontWeight: FontWeight.w500),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: const Text(
                                    'Resent',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
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
