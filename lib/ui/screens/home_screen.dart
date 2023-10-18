import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unnoti/ui/screens/authentication/sign_in_screen.dart';
import 'package:unnoti/ui/screens/profile_screen.dart';
import 'package:unnoti/ui/widgets/app_elevated_button.dart';
import 'package:unnoti/ui/widgets/screen_background.dart';

import '../widgets/activity_card.dart';
import 'enter_cupon_code.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.token, required this.phoneNumber, required this.profileID}) : super(key: key);

  final String token;
  final String phoneNumber;
  final int profileID;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        backgroundImage: 'assets/home_background.png',
        widget: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppBar(
                    leading: IconButton(
                      icon: const Icon(
                        Icons.menu,
                        color: Colors.black,
                        size: 40,
                      ),
                      onPressed: () {
                        Get.to(const SignInScreen());
                      },
                    ),
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    title: const Icon(
                      Icons.notifications,
                      color: Colors.black,
                      size: 40,
                    ),
                    actions: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const SizedBox(
                            height: 8,
                          ),
                          const Text(
                            'Forhad Uddin Ahmed',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                          Row(
                            children: [
                              const Text(
                                '100 Points',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                              Image.asset(
                                'assets/jems_icon.png',
                                height: 30,
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
                            Get.to(ProfileScreen(token: widget.token, phoneNumber: widget.phoneNumber,profileID: widget.profileID,));
                          },
                          child: Image.asset('assets/example_profile.png')),
                      const SizedBox(
                        width: 8,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.grey,
                        size: 30,
                      ),
                      suffixIcon: const Icon(
                        Icons.mic,
                        color: Colors.grey,
                        size: 30,
                      ),
                      filled: true,
                      fillColor: Colors.grey[350],
                      border: InputBorder.none,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(34.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(34.0),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 100,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xff783a9d),
                      borderRadius: BorderRadius.circular(34),
                    ),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Current Point: ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                              Spacer(),
                              Text(
                                '100',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Last Earned Point: ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                              Spacer(),
                              Text(
                                '10',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Last Payment Date: ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                              Spacer(),
                              Text(
                                'May 16 2023 10:05 AM',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Row(
                    children: [
                      Text(
                        'Activity',
                        style: TextStyle(
                            fontSize: 26,
                            color: Color(0xff404040),
                            fontWeight: FontWeight.w600),
                      ),
                      Spacer(),
                      Text(
                        'See All',
                        style: TextStyle(
                            fontSize: 26,
                            color: Color(0xff404040),
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ActivityCard(
                          image: 'assets/recharge_card_icon.png',
                          title: 'Recharge Card',
                          onTap: () {
                            Get.to(const EnterCuponCode());
                          },
                        ),
                        ActivityCard(
                          image: 'assets/recharge_card_icon.png',
                          title: 'Recharge Card',
                          onTap: () {},
                        ),
                        ActivityCard(
                          image: 'assets/recharge_card_icon.png',
                          title: 'Recharge Card',
                          onTap: () {},
                        ),
                        ActivityCard(
                          image: 'assets/recharge_card_icon.png',
                          title: 'Recharge Card',
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AppElevatedButton(
                    text: 'Product View',
                    color: const Color(0xff783a9d),
                    onPressed: () {},
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Gallery',
                    style: TextStyle(
                        fontSize: 26,
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
                    height: 10,
                  ),
                  const Text(
                    'Shop Address',
                    style: TextStyle(
                        fontSize: 26,
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
                      child: Text(
                        'Hazi Abdul Aziz Hadware,\nMugoltuli, Cumilla-3500, Bangladesh.\n'
                        'support@abdulazizhadware.com\nPhone Number 01617521162',
                        style: TextStyle(
                            fontSize: 15,
                            color: Color(0xff404040),
                            fontWeight: FontWeight.w600),
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
