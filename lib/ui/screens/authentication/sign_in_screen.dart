import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:unnoti/data/auth_utils.dart';
import 'package:unnoti/ui/screens/authentication/sign_up_screen.dart';
import 'package:unnoti/ui/screens/home_screen.dart';
import 'package:unnoti/ui/widgets/app_elevated_button.dart';
import 'package:unnoti/ui/widgets/app_text_form_field.dart';
import 'package:unnoti/ui/widgets/screen_background.dart';

import '../../../data/services/urls.dart';
import '../create_profile.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController phoneETController = TextEditingController();
  TextEditingController passwordETController = TextEditingController();

  bool inProgress = false;

  bool _passVisibility = false;

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
                    height: 430,
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
                              'Sign In',
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
                              color: const Color(0xffF5F5F5),
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
                            SizedBox(
                              height: height * 0.015,
                            ),
                            AppTextFormField(
                              suffixIcon: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: (){
                                    if(_passVisibility)
                                      {
                                        setState(() {
                                          _passVisibility = false;
                                        });
                                      }
                                    else
                                      {
                                        setState(() {
                                          _passVisibility = true;
                                        });
                                      }
                                  },
                                  child: _passVisibility?const Icon(Icons.visibility_outlined):const Icon(Icons.visibility_off_outlined),
                                ),
                              ),
                              hintText: 'Enter Password',
                              color: const Color(0xffF5F5F5),
                              controller: passwordETController,
                              obscureText: _passVisibility,
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
                              height: height * 0.02,
                            ),
                            inProgress
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      color: Color(0xFF8359E3),
                                    ),
                                  )
                                : AppElevatedButton(
                                    text: 'Log In',
                                    color: const Color(0xFF8359E3),
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        try {
                                          inProgress = true;
                                          setState(() {});

                                          final http.Response response =
                                              await http //for login check
                                                  .post(
                                                      Uri.parse(Urls.logInUrl),
                                                      headers: {
                                                        "Content-Type":
                                                            "application/json"
                                                      },
                                                      body: jsonEncode({
                                                        'phone_number':
                                                            '+88${phoneETController.text}',
                                                        'password':
                                                            passwordETController
                                                                .text
                                                      }));

                                          //print(response.statusCode);

                                          if (response.statusCode == 200) {
                                            log(response.body);
                                            Map valueMap =
                                                jsonDecode(response.body);

                                            try {
                                              final http.Response res =
                                                  await http.get(
                                                Uri.parse(Urls.profileUrl),
                                                //for profile check
                                                headers: {
                                                  "Content-Type":
                                                      "application/json",
                                                  'Authorization':
                                                      'Token ${valueMap['token']}'
                                                },
                                              );
                                              log(res.body);
                                              Map vMap = jsonDecode(res.body);
                                              AuthUtils.saveUserData(
                                                  valueMap['token'],
                                                  '+88${phoneETController.text}',
                                                  vMap['id'].toString());
                                              if (res.statusCode == 200) {
                                                //print(vMap['id']);
                                                Get.offAll(HomeScreen(
                                                  token: valueMap['token'],
                                                  phoneNumber:
                                                      '+88${phoneETController.text}',
                                                  profileID: vMap['id'],
                                                ));
                                                log('aksdjfnaskdjnflaksdnaksjd hekkki');
                                              } else if (res.statusCode ==
                                                  404) {
                                                Get.offAll(CreateProfile(
                                                  token: valueMap['token'],
                                                  phoneNumber:
                                                      '+88${phoneETController.text}',
                                                ));
                                              } else {
                                                log("Something went wrong ${res.statusCode}");
                                                Get.snackbar(
                                                  "Error!",
                                                  "LogIn Failed",
                                                  snackPosition:
                                                      SnackPosition.BOTTOM,
                                                  backgroundColor: Colors.red,
                                                  colorText: Colors.white,
                                                  snackStyle:
                                                      SnackStyle.FLOATING,
                                                );
                                              }
                                            } catch (e) {
                                              log('Error profile check: \n $e');
                                            }
                                          } else {
                                            log("Something went wrong");
                                            Get.snackbar(
                                              "Error!",
                                              "LogIn Failed",
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
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                )),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'New ?',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xff4D4D4D),
                                      fontWeight: FontWeight.w500),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Get.to(const SignUPScreen());
                                  },
                                  child: const Text(
                                    'Sign Up',
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
