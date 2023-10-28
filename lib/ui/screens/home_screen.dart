import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:unnoti/data/auth_utils.dart';
import 'package:unnoti/ui/screens/enter_lottery_cupon.dart';
import 'package:unnoti/ui/screens/product_view_screen.dart';
import 'package:unnoti/ui/widgets/app_elevated_button.dart';
import 'package:unnoti/ui/widgets/screen_background.dart';
import 'package:unnoti/ui/widgets/unnoti_drawer.dart';

import '../../data/services/urls.dart';
import '../widgets/activity_card.dart';
import '../widgets/unnoti_appbar.dart';
import 'enter_cupon_code.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map? valueMap;
  List<dynamic>? rechargelogList;
  List<dynamic>? paidPointList;
  List<dynamic>? rechargeHistoryList;
  String? lastEarnedPoint;
  String? lastPaymentDate;

  bool inProgress = false;

  getProfileData(int id) async {
    try{
      inProgress = true;
      setState(() {});

      AuthUtils.getAuthData();

      final http.Response response = await http.get(
        Uri.parse(Urls.profileByIDUrl(id)), //for profile check
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Token ${AuthUtils.token}'
        },
      );
      log(response.body);
      valueMap = jsonDecode(response.body);


       final http.Response responseRecharge = await http.get(
         Uri.parse(Urls.rechargeLogUrl), //for profile check
         headers: {
           "Content-Type": "application/json",
           'Authorization': 'Token ${AuthUtils.token}'
         },
       );

       log(responseRecharge.body);
       rechargelogList = json.decode(responseRecharge.body).cast<dynamic>();

       //print(rechargelogList);

     if(rechargelogList!.isNotEmpty)
       {
         log('hello1');
         paidPointList = rechargelogList!.where((e) => e["key"] == 'Points Paid').toList();
         rechargeHistoryList = rechargelogList!.where((e) => e["key"] != 'Points Paid').toList();
         log('hello2');
         lastEarnedPoint = rechargeHistoryList!.last['value'].toString();
         //print(paidPointList);
         log('hello3');
         lastPaymentDate = paidPointList!.last['date'].toString().split('T').first;
         //print(notPaidPointList);

       }



      inProgress = false;
      setState(() {});
    }catch(e)
    {
      log('Error:\t $e');
      inProgress = false;
      setState(() {});
    }
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
                  child: RefreshIndicator(
                    color: Colors.purple,
                    onRefresh: () =>getProfileData(AuthUtils.profileID!),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          UnnotiAppBar(
                            name: valueMap!['name'] ?? 'Unknown',
                            point: valueMap!['points'] ?? 'Unknown',
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 35,
                            child: TextFormField(
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(top: 10),
                                hintText: 'Search',
                                prefixIcon: InkWell(
                                  onTap: () {},
                                  child: const Icon(
                                    Icons.search,
                                    color: Colors.grey,
                                    size: 25,
                                  ),
                                ),
                                suffixIcon: InkWell(
                                  onTap: () {},
                                  child: const Icon(
                                    Icons.mic,
                                    color: Colors.grey,
                                    size: 25,
                                  ),
                                ),
                                filled: true,
                                fillColor: Colors.white54,
                                border: InputBorder.none,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 100,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: const Color(0xff783a9d),
                              borderRadius: BorderRadius.circular(26),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 18),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Text(
                                        'Current Point: ',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        '${valueMap!['points'] ?? 'Unknown'}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                   Row(
                                    children: [
                                      const Text(
                                        'Last Earned Point: ',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        lastEarnedPoint ?? 'Unknown',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                   Row(
                                    children: [
                                      const Text(
                                        'Last Payment Date: ',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        lastPaymentDate ?? 'Unknown',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              const Text(
                                'Activity',
                                style: TextStyle(
                                    fontSize: 22,
                                    color: Color(0xff404040),
                                    fontWeight: FontWeight.w600),
                              ),
                              const Spacer(),
                              InkWell(
                                onTap: () {},
                                child: const Text(
                                  'See All',
                                  style: TextStyle(
                                      fontSize: 22,
                                      color: Color(0xff404040),
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ActivityCard(
                                  image: 'assets/recharge_card_icon.png',
                                  title: 'Recharge Card',
                                  onTap: () {
                                    Get.to(const EnterCuponCode());
                                  },
                                ),
                                ActivityCard(
                                  image: 'assets/lottery_icon.jpg',
                                  title: 'Lottery',
                                  onTap: () {
                                    Get.to(const EnterLotteryCuponCode());
                                  },
                                ),
                                ActivityCard(
                                  image: 'assets/lead_activity_icon.png',
                                  title: 'Lead',
                                  onTap: () {},
                                ),
                                ActivityCard(
                                  image: 'assets/certificate_activity_icon.png',
                                  title: 'Certificate',
                                  onTap: () {},
                                ),
                                ActivityCard(
                                  image: 'assets/insurance_activity_icon.png',
                                  title: 'Insurance',
                                  onTap: () {},
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          AppElevatedButton(
                            text: 'Product View',
                            color: const Color(0xff783a9d),
                            onPressed: () {
                              Get.to(const ProductViewScreen());
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            'Gallery',
                            style: TextStyle(
                                fontSize: 22,
                                color: Color(0xff404040),
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 160,
                            width: double.infinity,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(34.0)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset('assets/photo1.png'),
                                  Image.asset('assets/photo1.png'),
                                  Image.asset('assets/photo1.png'),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            'Shop Address',
                            style: TextStyle(
                                fontSize: 22,
                                color: Color(0xff404040),
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 100,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: const Color(0xff976eee),
                              borderRadius: BorderRadius.circular(34),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 16),
                              child: Text(
                                'Hazi Abdul Aziz Hadware,\nMugoltuli, Cumilla-3500, Bangladesh.\n'
                                'support@abdulazizhadware.com\nPhone Number 01617521162',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Color(0xff404040),
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
