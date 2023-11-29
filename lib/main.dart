import 'package:flutter/material.dart';
import 'package:unnoti/ui/screens/splash_screen.dart';
import 'package:get/get.dart';

import 'data/network_connectivity_check/network_check_controller.dart';

Future<void> main() async {
  //WidgetsFlutterBinding.ensureInitialized();

  // Only call clearSavedSettings() during testing to reset internal values.
  //await Upgrader.clearSavedSettings();
  runApp(const Unnoti());
}

class Unnoti extends StatefulWidget {
  const Unnoti({Key? key}) : super(key: key);
  static GlobalKey<NavigatorState> globalKey = GlobalKey<NavigatorState>();

  @override
  State<Unnoti> createState() => _UnnotiState();
}

class _UnnotiState extends State<Unnoti> {

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      theme: ThemeData(
        fontFamily: 'Montserrat'
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      initialBinding: GetxBinding(),
    );

  }
}


class GetxBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkController());

  }
}
