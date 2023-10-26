import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:unnoti/ui/screens/home_screen.dart';

import '../../data/services/urls.dart';
import '../widgets/app_elevated_button.dart';
import '../widgets/app_text_form_field.dart';
import '../widgets/screen_background.dart';

class EnterLotteryCuponCode extends StatefulWidget {
  const EnterLotteryCuponCode({Key? key, required this.token, required this.phoneNumber, required this.profileID})
      : super(key: key);
  final String token;
  final String phoneNumber;
  final int profileID;

  @override
  State<EnterLotteryCuponCode> createState() => _EnterLotteryCuponCodeState();
}

class _EnterLotteryCuponCodeState extends State<EnterLotteryCuponCode> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController cuponETController = TextEditingController();
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
                    'Enter code for participate lottery!',
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
                  height: 80
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
                              hintText: 'Enter the Cupon code',
                              color: Colors.white,
                              controller: cuponETController,
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return "Enter a cupon code for submit";
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
                                text: 'Submit',
                                color: const Color(0xff8359E3),
                                onPressed: () async {

                                  if (_formKey.currentState!.validate()) {
                                    try {
                                      inProgressCuponSubmit = true;
                                      setState(() {});

                                      final http.Response response = await http
                                          .post(Uri.parse(Urls.lotteryUrl),
                                              headers: {
                                                "Content-Type":
                                                    "application/json",
                                                "Authorization":
                                                    "Token ${widget.token}",
                                              },
                                              body: jsonEncode({
                                                "gtoken":
                                                    cuponETController.text
                                              }));

                                      log(response.body);
                                      if (response.statusCode == 200) {
                                        showAlertDialog(
                                            context, 'Cupon code Submitted Successfully!');
                                      }
                                      else
                                        {
                                          showAlertDialog(
                                              context, 'Submit Failed!');
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
