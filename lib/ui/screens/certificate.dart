import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:unnoti/data/auth_utils.dart';
import 'package:unnoti/ui/widgets/screen_background.dart';

import '../../data/services/urls.dart';

class CertificateViewScreen extends StatefulWidget {
  const CertificateViewScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CertificateViewScreen> createState() => _CertificateViewScreenState();
}

class _CertificateViewScreenState extends State<CertificateViewScreen> {
  TextEditingController cuponETController = TextEditingController();

  bool inProgress = false;
  List<dynamic>? productList;

  getCertificate(int id) async {
    inProgress = true;
    setState(() {});
    final http.Response res = await http.get(
      Uri.parse(Urls.certificateUrl), //for profile check
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Token ${AuthUtils.token}'
      },
    );

    log(res.body);
    productList = json.decode(res.body).cast<dynamic>();
    log(productList!.length.toString());

    inProgress = false;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCertificate(AuthUtils.profileID!);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: ScreenBackground(
        backgroundImage: 'assets/home_background.png',
        widget: inProgress
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                      height: 10,
                    ),
                    SizedBox(
                      height: height * 0.8,
                      width: double.infinity,
                      child: Card(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(34.0),
                                bottomRight: Radius.circular(34.0),
                                bottomLeft: Radius.circular(34.0))),
                        color: const Color(0xffd8c5df),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4.0, vertical: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              const Center(
                                child: Text(
                                  'CERTIFICATE',
                                  style: TextStyle(
                                      letterSpacing: 2,
                                      fontSize: 24,
                                      color: Color(0xff404040),
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: productList!.length,
                                  itemBuilder: (context, index) => Container(
                                    margin: const EdgeInsets.only(
                                      top: 40.0,
                                    ),
                                    height: 200,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                      image: NetworkImage(
                                        'https://abdulazizhardware.com${productList![index]['image']}',
                                      ),
                                    )),
                                  ),
                                ),
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
    );
  }
}
