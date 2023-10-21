import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:unnoti/ui/screens/authentication/sign_in_screen.dart';
import 'package:unnoti/ui/screens/enter_lottery_cupon.dart';
import 'package:unnoti/ui/screens/product_view_screen.dart';
import 'package:unnoti/ui/screens/profile_screen.dart';
import 'package:unnoti/ui/widgets/app_elevated_button.dart';
import 'package:unnoti/ui/widgets/screen_background.dart';

import '../../data/services/urls.dart';
import '../widgets/activity_card.dart';
import 'enter_cupon_code.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen(
      {Key? key,
      required this.token,
      required this.phoneNumber,
      required this.profileID})
      : super(key: key);

  final String token;
  final String phoneNumber;
  final int profileID;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map? valueMap;
  bool inProgress = false;
  double drawerFontSize = 18;
  double drawerIconSize = 25;

  getProfileData(int id) async {
    inProgress = true;
    setState(() {});

    final http.Response response = await http.get(
      Uri.parse(Urls.profileByIDUrl(id)), //for profile check
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Token ${widget.token}'
      },
    );
    valueMap = jsonDecode(response.body);
    inProgress = false;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfileData(widget.profileID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: Drawer(
        width: 250,
        backgroundColor: Colors.black12.withOpacity(0.3),
        child: ListView(
          children: [
            const SizedBox(
              height: 50,
            ),
            Row(
              children: [
                Image.asset(
                  'assets/app_icon.png',
                  scale: 1,
                ),
                const SizedBox(
                  width: 15,
                ),
                const Text(
                  'Unnoti',
                  style: TextStyle(fontSize: 28, color: Colors.white),
                ),
                const Spacer(),
                Image.asset('assets/drawer_bar.png'),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            InkWell(
              onTap: () {
                Get.to(EnterLotteryCuponCode(
                  token: widget.token,
                  phoneNumber: widget.phoneNumber,
                  profileID: widget.profileID,
                ));
              },
              child: ListTile(
                leading: Icon(
                  Icons.token,
                  color: Colors.white,
                  size: drawerIconSize,
                ),
                title: Text(
                  'Token',
                  style:
                      TextStyle(fontSize: drawerFontSize, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                leading: Icon(
                  Icons.propane_outlined,
                  color: Colors.white,
                  size: drawerIconSize,
                ),
                title: Text(
                  'Product',
                  style:
                      TextStyle(fontSize: drawerFontSize, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                leading: Icon(
                  Icons.local_offer_outlined,
                  color: Colors.white,
                  size: drawerIconSize,
                ),
                title: Text(
                  'Offer',
                  style:
                      TextStyle(fontSize: drawerFontSize, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                leading: Icon(
                  Icons.language,
                  color: Colors.white,
                  size: drawerIconSize,
                ),
                title: Text(
                  'Language',
                  style:
                      TextStyle(fontSize: drawerFontSize, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                leading: Icon(
                  Icons.insert_invitation_outlined,
                  color: Colors.white,
                  size: drawerIconSize,
                ),
                title: Text(
                  'Invite Friend',
                  style:
                      TextStyle(fontSize: drawerFontSize, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                leading: Icon(
                  Icons.help,
                  color: Colors.white,
                  size: drawerIconSize,
                ),
                title: Text(
                  'Help',
                  style:
                      TextStyle(fontSize: drawerFontSize, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Get.offAll(const SignInScreen());
              },
              child: ListTile(
                leading: Icon(
                  Icons.logout_outlined,
                  color: Colors.white,
                  size: drawerIconSize,
                ),
                title: Text(
                  'Logout',
                  style:
                      TextStyle(fontSize: drawerFontSize, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
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
                        AppBar(
                          leading: Builder(
                            builder: (BuildContext context) {
                              return IconButton(
                                icon: const Icon(
                                  Icons.menu,
                                  color: Colors.black,
                                  size: 28,
                                ),
                                onPressed: () {
                                  Scaffold.of(context).openDrawer();
                                },
                                tooltip: MaterialLocalizations.of(context)
                                    .openAppDrawerTooltip,
                              );
                            },
                          ),

                          elevation: 0,
                          backgroundColor: Colors.transparent,
                          //  title:
                          actions: [
                            const SizedBox(
                              width: 55,
                            ),
                            const Icon(
                              Icons.notifications,
                              color: Colors.black,
                              size: 28,
                            ),
                            const Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  valueMap!['name'] ?? 'Unknown',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '${valueMap!['points'] ?? 'Unknown'} Points',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,

                                      ),
                                    ),
                                    Image.asset(
                                      'assets/jems_icon.png',
                                      height: 25,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            InkWell(
                                onTap: () {
                                  Get.to(ProfileScreen(
                                    token: widget.token,
                                    phoneNumber: widget.phoneNumber,
                                    profileID: widget.profileID,
                                  ));
                                },
                                child:
                                    Image.asset('assets/example_profile.png')),
                            const SizedBox(
                              width: 8,
                            ),
                          ],
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
                                const Row(
                                  children: [
                                    Text(
                                      'Last Earned Point: ',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      'Unknown',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Row(
                                  children: [
                                    Text(
                                      'Last Payment Date: ',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      'Unknown',
                                      style: TextStyle(
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
                              onTap: (){},
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
                                  Get.to(EnterCuponCode(
                                    token: widget.token,
                                    phoneNumber: widget.phoneNumber,
                                    profileID: widget.profileID,
                                  ));
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
                            Get.to(ProductViewScreen(
                                token: widget.token,
                                phoneNumber: widget.phoneNumber,
                                profileID: widget.profileID));
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
    );
  }
}
