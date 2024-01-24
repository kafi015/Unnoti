import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unnoti/ui/screens/authentication/reset_password_otp_verification.dart';

import '../../../data/services/urls.dart';
import '../../widgets/app_elevated_button.dart';
import '../../widgets/app_text_form_field.dart';
import '../../widgets/screen_background.dart';
import 'package:http/http.dart' as http;

class EnterNumberForSendOTPScreen extends StatefulWidget {
  const EnterNumberForSendOTPScreen({super.key});

  @override
  State<EnterNumberForSendOTPScreen> createState() =>
      _EnterNumberForSendOTPScreenState();
}

class _EnterNumberForSendOTPScreenState
    extends State<EnterNumberForSendOTPScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController phoneETController = TextEditingController();
  bool inProgress = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      body: ScreenBackground(
        backgroundImage: 'assets/authentication_background.png',
        widget: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.1,
                  ),
                  const Text(
                    'Unnoti',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 28,
                        letterSpacing: 2),
                  ),
                  SizedBox(
                    height: height * 0.2,
                  ),
                  SizedBox(
                    height: 440,
                    width: double.infinity,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(34.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: width * 0.05, vertical: height * 0.02),
                        child: Column(
                          children: [
                            SizedBox(
                              height: height * 0.01,
                            ),
                            const Text(
                              'Reset Password',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 26,
                                  letterSpacing: 2),
                            ),
                            SizedBox(
                              height: height * 0.07,
                            ),
                            AppTextFormField(
                              hintText: 'Enter Phone number',
                              color: Colors.grey.shade300,
                              controller: phoneETController,
                              keyBoardType: TextInputType.number,
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
                            SizedBox(height: height * 0.05),
                            inProgress
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      color: Color(0xFF8359E3),
                                    ),
                                  )
                                : AppElevatedButton(
                                    text: 'Send OTP',
                                    color: const Color(0xFF8359E3),
                                    onPressed: () async {
                                      //  Get.to(const ResetPasswordForOTPVerification(phoneNumber: '',));
                                      if (_formKey.currentState!.validate()) {
                                        try {
                                          inProgress = true;
                                          setState(() {});

                                          final http.Response response =
                                              await http.post(
                                                  Uri.parse(Urls
                                                      .sendResetPasswordOtpUrl),
                                                  headers: {
                                                    "Content-Type":
                                                        "application/json"
                                                  },
                                                  body: jsonEncode({
                                                    'phone_number':
                                                        '+88${phoneETController.text}'
                                                  }));

                                          log(response.statusCode.toString());
                                          log(response.body);
                                          if (response.statusCode == 200) {
                                            Get.to(
                                                ResetPasswordForOTPVerification(
                                              phoneNumber:
                                                  phoneETController.text,
                                            ));
                                          }
                                          else if (response.statusCode == 404) {
                                            log("User not found");
                                            Get.snackbar(
                                              "Error!",
                                              "User not Found",
                                              snackPosition:
                                              SnackPosition.BOTTOM,
                                              backgroundColor: Colors.red,
                                              colorText: Colors.white,
                                              snackStyle: SnackStyle.FLOATING,
                                            );
                                          }
                                          else {
                                            log("Something went wrong");
                                            Get.snackbar(
                                              "Error!",
                                              "OTP Send Failed",
                                              snackPosition:
                                                  SnackPosition.BOTTOM,
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
                            SizedBox(
                              height: height * 0.02,
                            ),
                            TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: const Text(
                                'back',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
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
