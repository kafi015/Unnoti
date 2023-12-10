import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart'  as http;

import '../../data/auth_utils.dart';
import '../../data/services/urls.dart';
import '../widgets/screen_background.dart';
import '../widgets/unnoti_appbar.dart';
import '../widgets/unnoti_drawer.dart';

class RechargeLogRedeemHistory extends StatefulWidget {
  const RechargeLogRedeemHistory({Key? key}) : super(key: key);

  @override
  State<RechargeLogRedeemHistory> createState() => _RechargeLogRedeemHistoryState();
}

class _RechargeLogRedeemHistoryState extends State<RechargeLogRedeemHistory> {
  Map? valueMap;
  List<dynamic>? pproductList;
  List<dynamic>? productList;
  bool inProgress = false;

  getProfileData(int id) async {

    AuthUtils.getAuthData();
    inProgress = true;
    setState(() {});

    final http.Response response = await http.get(
      Uri.parse(Urls.profileByIDUrl(id)), //for profile check
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Token ${AuthUtils.token}'
      },
    );
    valueMap = jsonDecode(utf8.decode(response.bodyBytes));

    final http.Response res = await http.get(
      Uri.parse(Urls.rechargeLogUrl), //for profile check
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Token ${AuthUtils.token}'
      },
    );

    log(res.body);
    pproductList = json.decode(res.body).cast<dynamic>();
    productList = pproductList!.reversed.toList();
    //print(productList);

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
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: const UnnotiDrawer(),
      body: ScreenBackground(
        backgroundImage: 'assets/home_background.png',
        widget: SafeArea(
          child: inProgress
              ? const Center(
            child: CircularProgressIndicator(
              color: Color(0xFF8359E3),
            ),
          )
              : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UnnotiAppBar(name: valueMap!['name'] ?? 'Unknown',point: valueMap!['points'] ?? 'Unknown',),

                  const SizedBox(
                    height: 10,
                  ),
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
                          children: [
                            const Text(
                              'Rechage Log',
                              style: TextStyle(
                                  fontSize: 24,
                                  color: Color(0xff404040),
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Expanded(
                              child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: productList!.length,
                                itemBuilder: (context, index) => productList![index]['key'] == 'Points Paid'?Card(
                                  color:  const Color(0xffE6E0F4),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(15.0)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5, bottom: 10),
                                    child: ListTile(

                                      title: Text(
                                          productList![index]['key'],style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w600,),),
                                       subtitle: Text(productList![index]['date'].toString().split('T').first),
                                      trailing: Text('-${productList![index]['value']}',style: const TextStyle(color: Colors.red,fontWeight: FontWeight.w600),),
                                    ),
                                  ),
                                ):
                                Card(
                                  color:  const Color(0xffE6E0F4),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(15.0)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5, bottom: 10),
                                    child: ListTile(

                                      title: Text(
                                        productList![index]['key'],style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w600,),),
                                      subtitle: Text(productList![index]['date'].toString().split('T').first),
                                      trailing: Text('+${productList![index]['value']}',style: const TextStyle(color: Colors.green,fontWeight: FontWeight.w600),),
                                    ),
                                  ),
                                )
                                ,
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
        ),
      ),
    );
  }
}
