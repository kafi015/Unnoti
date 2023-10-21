import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unnoti/data/auth_utils.dart';
import 'package:unnoti/ui/screens/home_screen.dart';

import '../widgets/app_elevated_button.dart';
import '../widgets/screen_background.dart';
import 'authentication/sign_in_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;
  bool inProgress = false;

  @override
  void initState() {
    getConnectivity();
    super.initState();
    Future.delayed(const Duration(seconds: 1))
        .then((value) => {
          checkUserAuthState()
        });

  }
  Future<void> checkUserAuthState() async {
    inProgress = true;
    setState(() {});
    final bool result = await AuthUtils.checkLoginState();

    if (result) {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      AuthUtils.getAuthData();
      Get.offAll(HomeScreen(token: sharedPreferences.getString('token').toString(), phoneNumber: sharedPreferences.getString('phoneNumber').toString(), profileID: int.parse(sharedPreferences.getString('profileID').toString())));
    }
    // else {
    //   Get.to(const SignInScreen());
    // }
    inProgress = false;
    setState(() {});

  }

  getConnectivity() =>
      subscription = Connectivity().onConnectivityChanged.listen(
            (ConnectivityResult result) async {
          isDeviceConnected = await InternetConnectionChecker().hasConnection;
          if (!isDeviceConnected && isAlertSet == false) {
            showDialogBox();
            setState(() => isAlertSet = true);
          }
        },
      );

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: ScreenBackground(
        backgroundImage: 'assets/splash_background.png',
        widget: Padding(
          padding:  EdgeInsets.symmetric(horizontal: width*0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               SizedBox(
                height: height *0.7,
              ),
             // inProgress? const Center(child: CircularProgressIndicator(color: Color(0xFF8359E3),),):

              AppElevatedButton(
                text: 'Get Started',
                color: const Color(0xff8359e3),
                onPressed: () {
                  Get.to(const SignInScreen());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
  showDialogBox() => showCupertinoDialog<String>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: const Text('No Connection'),
      content: const Text('Please check your internet connectivity'),
      actions: <Widget>[
        TextButton(
          onPressed: () async {
            Navigator.pop(context, 'Cancel');
            setState(() => isAlertSet = false);
            isDeviceConnected =
            await InternetConnectionChecker().hasConnection;
            if (!isDeviceConnected && isAlertSet == false) {
              showDialogBox();
              setState(() => isAlertSet = true);
            }
          },
          child: const Text('OK'),
        ),
      ],
    ),
  );
}


