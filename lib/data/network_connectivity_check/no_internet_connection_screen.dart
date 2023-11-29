import 'package:flutter/material.dart';
import 'package:get/get.dart';


class NoInternetConnectionScreen extends GetView {
  const NoInternetConnectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //Config().init(context);
    return WillPopScope(
      onWillPop: () => Future(() => false),
      child: const Scaffold(
          //  backgroundColor: Theme.of(context).colorScheme.background,
          body: SafeArea(
              child: Center(
        child: Icon(Icons.signal_wifi_statusbar_connected_no_internet_4_outlined,size: 250,color: Colors.red,),
      ))),
    );
  }
}
