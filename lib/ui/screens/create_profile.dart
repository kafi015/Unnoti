
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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

  final int id = 0;

  XFile? pickedImage;
  File? imageFile;


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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: height * 0.08,
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Center(
                  child: Stack(
                    children: [
                       Container(
                         height: 150,
                      width: 200,
                      color: Colors.blue,
                      //  child: pickedImage==null? AssetImage('assets/example_profile.png'): FileImage(pickedImage),
                       // backgroundImage: AssetImage('assets/example_profile.png'),
                      //  radius: 60,
                         child: imageFile==null? Image.asset('assets/example_profile.png'): Image.file(imageFile!),
                      ),
                      Positioned(
                        top: 70,
                        left: 80,
                        child: InkWell(
                          onTap: ()  {
                            pickImage(context);
                          },
                          child: const CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/profile_upload_icon.png'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                SizedBox(
                  height: height * 0.45,
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
                          AppElevatedButton(
                            text: 'Create Profile',
                            color: const Color(0xff8359E3),
                            onPressed: () {
                             // Get.to(MyWidget());
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
                  Navigator.pop(context);
                },
                leading: const Icon(Icons.camera),
                title: const Text('Camera'),
              ),
              ListTile(
                onTap: () async {
                  pickedImage = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);

                  if (pickedImage != null) {
                    imageFile = File(pickedImage!.path);
                    setState(() {});
                  }
                  Navigator.pop(context);
                },
                leading: const Icon(Icons.image),
                title: const Text('Gallery'),
              ),
            ],
          ),
        ));
  }
}
