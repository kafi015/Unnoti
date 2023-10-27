import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unnoti/ui/screens/notification_screen.dart';

import '../../data/auth_utils.dart';
import '../screens/profile_screen.dart';

class UnnotiAppBar extends StatelessWidget {
  const UnnotiAppBar({Key? key, required this.name, required this.point})
      : super(key: key);

  final String name;
  final int point;

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
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
        IconButton(
          onPressed: () {
            Get.to(const NotificationScreen());
          },
          icon: const Icon(
            Icons.notifications,
            color: Colors.black,
            size: 28,
          ),
        ),
        const Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const SizedBox(
              height: 8,
            ),
            Text(
              name,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
            Row(
              children: [
                Text(
                  '$point Points',
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
              AuthUtils.getAuthData();
              Get.to(const ProfileScreen());
            },
            child: Image.asset('assets/example_profile.png')),
        const SizedBox(
          width: 8,
        ),
      ],
    );
  }
}
