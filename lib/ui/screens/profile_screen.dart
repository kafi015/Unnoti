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

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key, required this.token, required this.phoneNumber,required this.profileID}) : super(key: key);
  final String token;
  final String phoneNumber;
  final int profileID;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController nameETController = TextEditingController();
  TextEditingController phoneETController = TextEditingController();
  TextEditingController addressETController = TextEditingController();
  TextEditingController nidETController = TextEditingController();
  TextEditingController passwordETController = TextEditingController();
  String? point;
  String? imageUrl;

  Future<void> getProfileData(int id)
  async {
    final http.Response response = await http.get(
      Uri.parse(Urls.profileByIDUrl(id)),
      headers: {"Content-Type": "application/json", 'Authorization': 'Token ${widget.token}'},
    );
    if(response.statusCode == 200)
      {
        Map valueMap = jsonDecode(response.body);

        nameETController.text = valueMap['name'];
        phoneETController.text = widget.phoneNumber;
        addressETController.text = valueMap['address'];
        nidETController.text = valueMap['nid'];
        point = valueMap['points'];
        imageUrl = valueMap['image'];

      }
  }

  @override
  void initState() {
    super.initState();
    getProfileData(1);

  }

  @override
  Widget build(BuildContext context) {
    getProfileData(1);
    return Scaffold(
      body: ScreenBackground(
        backgroundImage: 'assets/home_background.png',
        widget: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 80,
                ),
                Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          Get.to(HomeScreen(token: widget.token, phoneNumber: widget.phoneNumber, profileID: widget.profileID));
                        },
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.red,
                          ),
                        )),
                    const Spacer(),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Image.asset('assets/profile_star.png'),
                            const SizedBox(width: 2,),
                             Text(
                              nameETController.text,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                             Text(
                              '${point ?? 0} Points',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                            Image.asset(
                              'assets/jems_icon.png',
                              height: 30,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                 Center(
                    child: CircleAvatar(
                      radius: 60,
                     backgroundImage: NetworkImage(imageUrl ?? ''),
                    ),

                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 450,
                  width: double.infinity,
                  child: Card(
                    color: const Color(0xffd8c5df),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 20.0),
                      child: Column(
                        children: [
                          AppTextFormField(
                            hintText: 'Enter full name',
                            color: Colors.white,
                            controller: nameETController,
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return "Enter your full name";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          AppTextFormField(
                            hintText: 'Phone Number',
                            readOnly: true,
                            color: Colors.white,
                            controller: phoneETController,

                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          AppTextFormField(
                            hintText: 'Address',
                            color: Colors.white,
                            controller: addressETController,
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return "Enter your address";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          AppTextFormField(
                            hintText: 'NID number',
                            color: Colors.white,
                            controller: nidETController,
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return "Enter your NID number";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          AppTextFormField(
                            hintText: 'Password',
                            color: Colors.white,
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
                            height: 20,
                          ),

                          AppElevatedButton(
                              text: 'Update',
                              color: const Color(0xff8359E3),
                            onPressed:() async {
                              if (_formKey.currentState!.validate()) {

                                try {
                                  final http.Response response = await http.post(Uri.parse(Urls.profileUrl),
                                      headers: {"Content-Type": "application/json"},
                                      body: jsonEncode({
                                        'phone_number':
                                        '+88${phoneETController.text}',
                                        'password': passwordETController.text
                                      }));

                                  //print(response.statusCode);

                                  if (response.statusCode == 200) {
                                    log(response.body);
                                    Map valueMap = jsonDecode(response.body);



                                   // Get.offAll( ProfileScreen(token: valueMap['token'], phoneNumber: '',));

                                  } else {
                                    log("Something went wrong");
                                    Get.snackbar(
                                      "Error!",
                                      "LogIn Failed",
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
    );
  }
}
