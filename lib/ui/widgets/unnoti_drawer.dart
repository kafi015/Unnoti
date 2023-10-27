import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unnoti/ui/screens/home_screen.dart';

import '../../data/auth_utils.dart';
import '../screens/authentication/sign_in_screen.dart';
import '../screens/enter_lottery_cupon.dart';
import '../screens/product_point_view_screen.dart';
import '../screens/rechage_log_history.dart';

class UnnotiDrawer extends StatelessWidget {
  const UnnotiDrawer({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    double drawerFontSize = 18;
    double drawerIconSize = 25;
    return Drawer(
      width: 250,
      backgroundColor: Colors.black12.withOpacity(0.3),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(
            height: 50,
          ),
          InkWell(
            onTap: () {
              Get.to(const HomeScreen());
            },
            child: Row(
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
          ),
          const SizedBox(
            height: 50,
          ),
          ListTile(

            onTap: () {
              AuthUtils.getAuthData();
              Get.to(const EnterLotteryCuponCode());
            },
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
          const SizedBox(
            height: 20,
          ),
          ListTile(
            onTap: () {
              AuthUtils.getAuthData();
              Get.to(const ProductPointViewScreen());
            },
            leading: Icon(
              Icons.propane_outlined,
              color: Colors.white,
              size: drawerIconSize,
            ),
            title: Text(
              'Products Point',
              style:
              TextStyle(fontSize: drawerFontSize, color: Colors.white),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              Get.to(const RechargeLogRedeemHistory());
            },
            child: ListTile(
              leading: Icon(
                Icons.work_history,
                color: Colors.white,
                size: drawerIconSize,
              ),
              title: Text(
                'Redeem History',
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
            onTap: () async {
              AuthUtils.clearAllData();

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
    );
  }
}