import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:developer';
import 'package:http/http.dart' as http;

class NetworkUtils {
  Future<dynamic> getMethod(String url,
      {VoidCallback? onunauthorized, String? token}) async {
    try {
      final http.Response response = await http.get(
        Uri.parse(url),
        headers: {"Content-Type": "application/json", 'token': token ?? ''},
      );
      log(response.body);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 401) {
        if (onunauthorized != null) {
          onunauthorized();
        } else {
          //   moveToLogInScreen();
        }
      } else {
        log("Something went wrong ${response.statusCode}");
      }
    } catch (e) {
      log('Error $e');
    }
  }

  Future<dynamic> postMethod(String url,
      {Map<String, String>? body,
      VoidCallback? onunauthorized,
      String? token}) async {
   // print(body);

    try {
      final http.Response response = await http.post(Uri.parse(url),
          headers: {"Content-Type": "application/json", 'token': token ?? ''},
          body: jsonEncode(body));

     // print(response.statusCode);

      if (response.statusCode == 201) {
        log(response.body);
        return response.body;
      } else if (response.statusCode == 400) {
        Get.snackbar(
          "Error!",
          "User with this phone number already exists",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackStyle: SnackStyle.FLOATING,

        );
      } else if (response.statusCode == 401) {
        if (onunauthorized != null) {
          onunauthorized();
        } else {
          // moveToLogInScreen();
        }
      } else {
        log("Something went wrong");
        return null;
      }
    } catch (e) {
      log('Error $e');
    }
  }
// void moveToLogInScreen()
// {
//   AuthUtils.clearAllData();
//   Navigator.pushAndRemoveUntil(MyApp.globalKey.currentContext!, MaterialPageRoute(builder: (context)=>const LogInScreen()), (route) => false);
// }
}
