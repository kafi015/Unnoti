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

class ResetPassWordScreen extends StatefulWidget {
  const ResetPassWordScreen({Key? key, required this.phoneNumber}) : super(key: key);

  final String phoneNumber;

  @override
  State<ResetPassWordScreen> createState() => _ResetPassWordScreenState();
}

class _ResetPassWordScreenState extends State<ResetPassWordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController phoneETController = TextEditingController();
  TextEditingController passwordETController = TextEditingController();
  TextEditingController confirmpassETController = TextEditingController();

  bool inProgress = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery
        .of(context)
        .size
        .height;
    double width = MediaQuery
        .of(context)
        .size
        .width;
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
                    height: height * 0.15,
                  ),
                  SizedBox(
                    height: 450,
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
                              height: height * 0.05,
                            ),
                            AppTextFormField(
                              hintText: 'Enter Password',
                              color:  Colors.grey.shade300,
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
                            SizedBox(
                              height: height * 0.015,
                            ),
                            AppTextFormField(
                              hintText: 'Confirm Password',
                              color:  Colors.grey.shade300,
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
                            SizedBox(
                              height: height * 0.05,
                            ),
                            inProgress
                                ? const Center(
                              child: CircularProgressIndicator(
                                color: Color(0xFF8359E3),
                              ),
                            )
                                :
                            AppElevatedButton(
                              text: 'Change Password',
                              color: const Color(0xFF8359E3),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {

                                  try {
                                    inProgress = true;
                                    setState(() {});

                                    final http.Response response = await http.post(Uri.parse(Urls.resetPassword),
                                        headers: {"Content-Type": "application/json"},
                                        body: jsonEncode({
                                          'phone_number':
                                          widget.phoneNumber,
                                          'new_password': passwordETController.text
                                        }));

                                    log(response.statusCode.toString());

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
        Get.offAll(const SignInScreen());
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Message"),
      content: const Text("Password Changed Successfully!"),
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
