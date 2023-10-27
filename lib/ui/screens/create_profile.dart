
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:unnoti/data/auth_utils.dart';
import 'package:unnoti/ui/screens/home_screen.dart';

import '../../data/services/urls.dart';
import '../../main.dart';
import '../widgets/app_elevated_button.dart';
import '../widgets/app_text_form_field.dart';
import '../widgets/screen_background.dart';

class CreateProfile extends StatefulWidget {
  const CreateProfile(
      {Key? key, required this.token, required this.phoneNumber})
      : super(key: key);

  final String token;
  final String phoneNumber;

  @override
  State<CreateProfile> createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController nameETController = TextEditingController();
  TextEditingController phoneETController = TextEditingController();
  TextEditingController addressETController = TextEditingController();
  TextEditingController nidETController = TextEditingController();
  TextEditingController passwordETController = TextEditingController();

  bool inProgress = false;

   XFile? pickedImage;
  // File? imageFile;
  // String? base64Image;

  // Future<File> getImageFileFromAssets(String path) async {
  //   final byteData = await rootBundle.load('assets/$path');
  //   final file = File('${(await getTemporaryDirectory()).path}/$path');
  //   await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
  //   return file;
  // }
  // Future<List<int>> convertFileToBytes(File file) async {
  //   return await file.readAsBytes();
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    phoneETController.text = widget.phoneNumber;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: ScreenBackground(
        backgroundImage: 'assets/home_background.png',
        widget: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: height * 0.08,
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  const Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage('assets/example_profile.png'),
                          radius: 60,
                        ),
                        // Positioned(
                        //   top: 70,
                        //   left: 80,
                        //   child: InkWell(
                        //     onTap: ()  {
                        //    //   pickImage(context);
                        //     },
                        //     child: const CircleAvatar(
                        //       backgroundImage:
                        //           AssetImage('assets/profile_upload_icon.png'),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  SizedBox(
                    height: height * 0.50,
                    width: double.infinity,
                    child: Card(
                      color: const Color(0xffd8c5df),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: width * 0.05, vertical: height * 0.03),
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
                            SizedBox(
                              height: height * 0.02,
                            ),
                            AppTextFormField(
                              hintText: 'Phone Number',
                              readOnly: true,
                              color: Colors.white,
                              controller: phoneETController,
                            ),
                            SizedBox(
                              height: height * 0.02,
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
                            SizedBox(
                              height: height * 0.02,
                            ),
                            AppTextFormField(
                              hintText: 'NID number',
                              color: Colors.white,
                              keyBoardType: TextInputType.number,
                              controller: nidETController,
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return "Enter your NID number";
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            inProgress? const Center(child: CircularProgressIndicator(color: Color(0xFF8359E3),),):AppElevatedButton(
                              text: 'Create Profile',
                              color: const Color(0xff8359E3),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {


                                  try {
                                    inProgress = true;
                                    setState(() {});

                                    final http.Response response = await http.post(Uri.parse(Urls.profileUrl),
                                        headers: {"Content-Type": "application/json", "Authorization" : "Token ${widget.token}",},
                                        body: jsonEncode({
                                          'name': nameETController.text,
                                          'nid': nidETController.text,
                                          'address': addressETController.text,
                                         // 'image' : 'https://www.google.com/url?sa=i&url=https%3A%2F%2Ficonscout.com%2Ffree-icon%2Fperson-1780868&psig=AOvVaw3xih8gOuD2HSo6XIUN4vrH&ust=1697729803975000&source=images&cd=vfe&opi=89978449&ved=0CBEQjRxqFwoTCJiW-sD2_4EDFQAAAAAdAAAAABAJ'
                                        }));


                                     log(response.statusCode.toString());
                                    log(response.body);
                                    if (response.statusCode == 200) {
                                      log(response.body);
                                      Map valueMap = jsonDecode(response.body);
                                      //print(valueMap);
                                      //  print(valueMap['otp']);
                                      AuthUtils.saveUserData(widget.token, widget.phoneNumber, valueMap['id']);
                                      Get.offAll(const HomeScreen());

                                    }
                                    else {
                                      log(response.statusCode.toString());
                                      log("Something went wrong");
                                      Get.snackbar(
                                        "Error!",
                                        "Failed Create profile",
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
  void pickImage(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                onTap: () async {
                  pickedImage = await ImagePicker()
                      .pickImage(source: ImageSource.camera);

                  if (pickedImage != null) {
                    setState(() {});
                  }


                  Navigator.pop(Unnoti.globalKey.currentContext!);
                },
                leading: const Icon(Icons.camera),
                title: const Text('Camera'),
              ),
              ListTile(
                onTap: () async {
                  pickedImage = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);

                  if (pickedImage != null) {
                    setState(() {});
                  }
                  Navigator.pop(Unnoti.globalKey.currentContext!);
                },
                leading: const Icon(Icons.image),
                title: const Text('Gallery'),
              ),
            ],
          ),
        ));
  }
}
