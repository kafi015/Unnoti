import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:unnoti/data/auth_utils.dart';
import 'package:unnoti/ui/screens/home_screen.dart';

import '../../data/services/urls.dart';
import '../widgets/app_elevated_button.dart';
import '../widgets/app_text_form_field.dart';
import '../widgets/screen_background.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({Key? key,})
      : super(key: key);

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController helpETController = TextEditingController();
  bool inProgressCuponSubmit = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // resizeToAvoidBottomInset: false,
      body: ScreenBackground(
        backgroundImage: 'assets/home_background.png',
        widget:
            //inProgress? const Center(child: CircularProgressIndicator(),):
            Padding(
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
                // Center(
                //     child: Image.asset(
                //       'assets/jems_icon.png',
                //       height: 80,
                //       width: 50,
                //       fit: BoxFit.fill,
                //     )),
                const SizedBox(
                  height: 30,
                ),
                const Center(
                  child: Text(
                    'If you have any problem, Write and send it!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Center(
                  child: Text(
                    '',
                    style: TextStyle(
                      fontSize: 22,
                      color: Color(0xfffd00e4),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50
                ),
                SizedBox(
                  height: 250,
                  width: double.infinity,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(34.0)
                    ),
                    color: const Color(0xffd8c5df),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 20.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            const SizedBox(height: 30,),
                            AppTextFormField(
                              hintText: 'Write your problem here',
                              color: Colors.white,
                              controller: helpETController,
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return "Write something for send!";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            inProgressCuponSubmit
                                ? const Center(
                              child: CircularProgressIndicator(
                                color: Color(0xFF8359E3),
                              ),
                            )
                                :AppElevatedButton(
                                text: 'Send',
                                color: const Color(0xff8359E3),
                                onPressed: () async {

                                  if (_formKey.currentState!.validate()) {
                                    try {
                                      inProgressCuponSubmit = true;
                                      setState(() {});

                                      AuthUtils.getAuthData();
                                      final http.Response response = await http
                                          .post(Uri.parse(Urls.helpUrl),
                                              headers: {
                                                "Content-Type":
                                                    "application/json",
                                                "Authorization":
                                                    "Token ${AuthUtils.token}",
                                              },
                                              body: jsonEncode({
                                                "message":
                                                    helpETController.text
                                              }));

                                      log(response.body);
                                      if (response.statusCode == 201) {
                                        showAlertDialog(
                                            context, 'Your message send!');
                                      }
                                      else
                                        {
                                          showAlertDialog(
                                              context, 'Send Failed!');
                                        }
                                      inProgressCuponSubmit = false;
                                      setState(() {});
                                    } catch (e) {
                                      log('Error: $e');
                                    }
                                  }
                                }),
                          ],
                        ),
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

  showAlertDialog(BuildContext context, String msg) {
    // set up the button
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
           Get.to(const HomeScreen());
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Message"),
      content: Text(msg),
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
