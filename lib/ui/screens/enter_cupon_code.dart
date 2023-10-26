import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:unnoti/data/auth_utils.dart';
import 'package:unnoti/ui/screens/home_screen.dart';
import 'package:unnoti/ui/widgets/app_elevated_button.dart';
import 'package:unnoti/ui/widgets/screen_background.dart';

import '../../data/services/urls.dart';
import '../widgets/app_text_form_field.dart';

class EnterCuponCode extends StatefulWidget {
  const EnterCuponCode({Key? key, }) : super(key: key);


  @override
  State<EnterCuponCode> createState() => _EnterCuponCodeState();
}

class _EnterCuponCodeState extends State<EnterCuponCode> {



  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController cuponETController = TextEditingController();

  Map? profileMap;
  bool inProgress = false;
  bool inProgressCuponSubmit = false;

  getProfileData(int id)
  async {

    AuthUtils.getAuthData();
    inProgress = true;
    setState(() {});

    final http.Response response =
    await http.get(
      Uri.parse(Urls.profileByIDUrl(id)), //for profile check
      headers: {
        "Content-Type": "application/json",
        'Authorization':
        'Token ${AuthUtils.token}'
      },
    );
    profileMap = jsonDecode(response.body);
    inProgress = false;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfileData(AuthUtils.profileID!);

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // resizeToAvoidBottomInset: false,
      body: ScreenBackground(
        backgroundImage: 'assets/home_background.png',
        widget: inProgress? const Center(child: CircularProgressIndicator(),):Padding(
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
                Center(
                    child: Image.asset(
                  'assets/jems_icon.png',
                  height: 72,
                  width: 69,
                  fit: BoxFit.fill,
                )),
                const SizedBox(
                  height: 30,
                ),
                const Center(
                  child: Text(
                    'Your Current point',
                    style: TextStyle(fontSize: 22),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                 Center(
                  child: Text(
                    '${profileMap!['points'] ?? 'Unknown'}',
                    style: const TextStyle(
                      fontSize: 22,
                      color: Color(0xfffd00e4),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
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
                              validator: (value){
                                if(value?.isEmpty ?? true)
                                  {
                                    return "Enter a cupon code for submit";
                                  }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            inProgressCuponSubmit
                                ? const Center(
                              child: CircularProgressIndicator(
                                color: Color(0xFF8359E3),
                              ),
                            )
                                : AppElevatedButton(
                                text: 'Submit',
                                color: const Color(0xff8359E3),
                                onPressed: () async {
                                  if(_formKey.currentState!.validate()){
                                    try{
                                      inProgressCuponSubmit = true;
                                      setState(() {});

                                      final http.Response response = await http
                                          .post(Uri.parse(Urls.rechargeUrl),
                                          headers: {
                                            "Content-Type": "application/json",
                                            "Authorization" : "Token ${AuthUtils.token}",
                                          },
                                          body: jsonEncode({
                                            "dial_code": cuponETController.text
                                          }));

                                      log(response.statusCode.toString());
                                      log(response.body);
                                      if(response.statusCode == 200)
                                        {
                                          Map valueMap = jsonDecode(response.body);
                                          showAlertDialog(context,valueMap['message']);

                                          inProgressCuponSubmit = false;
                                          setState(() {});
                                        }
                                      else if(response.statusCode == 400)
                                      {
                                        Map valueMap = jsonDecode(response.body);
                                        showAlertDialog(context,valueMap['message']);

                                        inProgressCuponSubmit = false;
                                        setState(() {});
                                      }

                                      inProgressCuponSubmit = false;
                                      setState(() {});

                                    }
                                    catch(e)
                                  {
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
      content:  Text(msg),
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


