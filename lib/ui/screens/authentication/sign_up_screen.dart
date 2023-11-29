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
                              'Sign Up',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 26,
                                  letterSpacing: 2),
                            ),
                            SizedBox(
                              height: height * 0.03,
                            ),
                            AppTextFormField(
                              hintText: 'Enter Phone number',
                              keyBoardType: TextInputType.number,
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
                            SizedBox(
                              height: height * 0.015,
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
                            SizedBox(
                              height: height * 0.015,
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
                            SizedBox(
                              height: height * 0.02,
                            ),
                            inProgress
                                ? const Center(
                              child: CircularProgressIndicator(
                                color: Color(0xFF8359E3),
                              ),
                            )
                                :
                            AppElevatedButton(
                              text: 'Create Account',
                              color: const Color(0xFF8359E3),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text(
                                          "Message", style: TextStyle(fontWeight: FontWeight.w600),),
                                        content: const Text('We are keeping your all information like Phone Number, NID, Address to verify you.', style: TextStyle(fontWeight: FontWeight.w400),),
                                        actions: [
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                                            child: const Text("OK"),
                                            // onPressed: (){
                                            //   Navigator.pop(context);
                                            // },
                                            onPressed: () async {
                                              Navigator.pop(context);
                                              try {
                                                inProgress = true;
                                                setState(() {});
                                                final http.Response response = await http.post(
                                                    Uri.parse(Urls.registrationUrl),
                                                    headers: {"Content-Type": "application/json; charset=utf-8"},
                                                    body: jsonEncode({
                                                      'phone_number':
                                                      '+88${phoneETController.text}',
                                                      'password': passwordETController.text
                                                    }));

                                                 log('Status Code: ${response.statusCode}');

                                                if (response.statusCode == 201) {
                                                  log(response.body);
                                                  Map valueMap = jsonDecode(response.body);
                                                  //print(valueMap);
                                                  //  print(valueMap['otp']);

                                                  Get.to(OTPVerficationScreen(otp: valueMap['otp'],
                                                    phoneNumber: '+88${phoneETController.text}',));
                                                } else if (response.statusCode == 400) {
                                                  Get.snackbar(
                                                    "Error!",
                                                    "User with this phone number already exists",
                                                    snackPosition: SnackPosition.BOTTOM,
                                                    backgroundColor: Colors.red,
                                                    colorText: Colors.white,
                                                    snackStyle: SnackStyle.FLOATING,

                                                  );
                                                } else {
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
                                            },
                                          ),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                                            child: const Text("No"),
                                            onPressed: () {
                                              Get.to(const SignInScreen());
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );


                                 // showAlertDialog(context, 'We are keeping your all information like Phone Number, NID, Address to verify you.');
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
                                      fontSize: 16,
                                      color: Color(0xff4D4D4D),
                                      fontWeight: FontWeight.w500),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Get.offAll(const SignInScreen());
                                  },
                                  child: const Text(
                                    'Sign In',
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

  showAlertDialog(BuildContext context, String msg) {
    // set up the button

    // set up the AlertDia

    // show the dialog
  }

}
