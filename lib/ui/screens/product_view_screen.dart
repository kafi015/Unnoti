import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:unnoti/ui/screens/profile_screen.dart';

import '../../data/services/urls.dart';
import '../widgets/screen_background.dart';
import 'authentication/sign_in_screen.dart';

class ProductViewScreen extends StatefulWidget {
  const ProductViewScreen(
      {Key? key,
      required this.token,
      required this.phoneNumber,
      required this.profileID})
      : super(key: key);

  final String token;
  final String phoneNumber;
  final int profileID;

  @override
  State<ProductViewScreen> createState() => _ProductViewScreenState();
}

class _ProductViewScreenState extends State<ProductViewScreen> {
  Map? valueMap;
  List<dynamic>? productList;
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

    final http.Response res = await http.get(
      Uri.parse(Urls.productUrl), //for profile check
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Token ${widget.token}'
      },
    );

    log(res.body);
    productList = json.decode(res.body).cast<dynamic>();
    // productList = [{"id":1,"title":"White 10L Color","description":"White is the lightest color and is achromatic (having no hue). It is the color of fresh snow, chalk, and milk, and is the opposite of black. White objects fully reflect and scatter all the visible wavelengths of light. White on television and computer screens is created by a mixture of red, blue, and green light.","image":"/media/images/unnotilogo.png","created_on":"2023-10-13","updated_on":"2023-10-13"},{"id":2,"title":"abc","description":"hhgjhg hjggh","image":"/media/images/CC.ico","created_on":"2023-10-19","updated_on":"2023-10-19"},
    //   {"id":1,"title":"White 10L Color","description":"White is the lightest color and is achromatic (having no hue). It is the color of fresh snow, chalk, and milk, and is the opposite of black. White objects fully reflect and scatter all the visible wavelengths of light. White on television and computer screens is created by a mixture of red, blue, and green light.","image":"/media/images/unnotilogo.png","created_on":"2023-10-13","updated_on":"2023-10-13"},{"id":2,"title":"abc","description":"hhgjhg hjggh","image":"/media/images/CC.ico","created_on":"2023-10-19","updated_on":"2023-10-19"},
    //   {"id":1,"title":"White 10L Color","description":"White is the lightest color and is achromatic (having no hue). It is the color of fresh snow, chalk, and milk, and is the opposite of black. White objects fully reflect and scatter all the visible wavelengths of light. White on television and computer screens is created by a mixture of red, blue, and green light.","image":"/media/images/unnotilogo.png","created_on":"2023-10-13","updated_on":"2023-10-13"},{"id":2,"title":"abc","description":"hhgjhg hjggh","image":"/media/images/CC.ico","created_on":"2023-10-19","updated_on":"2023-10-19"},
    //   {"id":1,"title":"White 10L Color","description":"White is the lightest color and is achromatic (having no hue). It is the color of fresh snow, chalk, and milk, and is the opposite of black. White objects fully reflect and scatter all the visible wavelengths of light. White on television and computer screens is created by a mixture of red, blue, and green light.","image":"/media/images/unnotilogo.png","created_on":"2023-10-13","updated_on":"2023-10-13"},{"id":2,"title":"abc","description":"hhgjhg hjggh","image":"/media/images/CC.ico","created_on":"2023-10-19","updated_on":"2023-10-19"},
    //   {"id":1,"title":"White 10L Color","description":"White is the lightest color and is achromatic (having no hue). It is the color of fresh snow, chalk, and milk, and is the opposite of black. White objects fully reflect and scatter all the visible wavelengths of light. White on television and computer screens is created by a mixture of red, blue, and green light.","image":"/media/images/unnotilogo.png","created_on":"2023-10-13","updated_on":"2023-10-13"},{"id":2,"title":"abc","description":"hhgjhg hjggh","image":"/media/images/CC.ico","created_on":"2023-10-19","updated_on":"2023-10-19"},
    //   {"id":1,"title":"White 10L Color","description":"White is the lightest color and is achromatic (having no hue). It is the color of fresh snow, chalk, and milk, and is the opposite of black. White objects fully reflect and scatter all the visible wavelengths of light. White on television and computer screens is created by a mixture of red, blue, and green light.","image":"/media/images/unnotilogo.png","created_on":"2023-10-13","updated_on":"2023-10-13"},{"id":2,"title":"abc","description":"hhgjhg hjggh","image":"/media/images/CC.ico","created_on":"2023-10-19","updated_on":"2023-10-19"},
    //   {"id":1,"title":"White 10L Color","description":"White is the lightest color and is achromatic (having no hue). It is the color of fresh snow, chalk, and milk, and is the opposite of black. White objects fully reflect and scatter all the visible wavelengths of light. White on television and computer screens is created by a mixture of red, blue, and green light.","image":"/media/images/unnotilogo.png","created_on":"2023-10-13","updated_on":"2023-10-13"},{"id":2,"title":"abc","description":"hhgjhg hjggh","image":"/media/images/CC.ico","created_on":"2023-10-19","updated_on":"2023-10-19"},
    //   {"id":1,"title":"White 10L Color","description":"White is the lightest color and is achromatic (having no hue). It is the color of fresh snow, chalk, and milk, and is the opposite of black. White objects fully reflect and scatter all the visible wavelengths of light. White on television and computer screens is created by a mixture of red, blue, and green light.","image":"/media/images/unnotilogo.png","created_on":"2023-10-13","updated_on":"2023-10-13"},{"id":2,"title":"abc","description":"hhgjhg hjggh","image":"/media/images/CC.ico","created_on":"2023-10-19","updated_on":"2023-10-19"},
    //   {"id":1,"title":"White 10L Color","description":"White is the lightest color and is achromatic (having no hue). It is the color of fresh snow, chalk, and milk, and is the opposite of black. White objects fully reflect and scatter all the visible wavelengths of light. White on television and computer screens is created by a mixture of red, blue, and green light.","image":"/media/images/unnotilogo.png","created_on":"2023-10-13","updated_on":"2023-10-13"},{"id":2,"title":"abc","description":"hhgjhg hjggh","image":"/media/images/CC.ico","created_on":"2023-10-19","updated_on":"2023-10-19"},
    //   {"id":1,"title":"White 10L Color","description":"White is the lightest color and is achromatic (having no hue). It is the color of fresh snow, chalk, and milk, and is the opposite of black. White objects fully reflect and scatter all the visible wavelengths of light. White on television and computer screens is created by a mixture of red, blue, and green light.","image":"/media/images/unnotilogo.png","created_on":"2023-10-13","updated_on":"2023-10-13"},{"id":2,"title":"abc","description":"hhgjhg hjggh","image":"/media/images/CC.ico","created_on":"2023-10-19","updated_on":"2023-10-19"},
    //   {"id":1,"title":"White 10L Color","description":"White is the lightest color and is achromatic (having no hue). It is the color of fresh snow, chalk, and milk, and is the opposite of black. White objects fully reflect and scatter all the visible wavelengths of light. White on television and computer screens is created by a mixture of red, blue, and green light.","image":"/media/images/unnotilogo.png","created_on":"2023-10-13","updated_on":"2023-10-13"},{"id":2,"title":"abc","description":"hhgjhg hjggh","image":"/media/images/CC.ico","created_on":"2023-10-19","updated_on":"2023-10-19"},
    //   {"id":1,"title":"White 10L Color","description":"White is the lightest color and is achromatic (having no hue). It is the color of fresh snow, chalk, and milk, and is the opposite of black. White objects fully reflect and scatter all the visible wavelengths of light. White on television and computer screens is created by a mixture of red, blue, and green light.","image":"/media/images/unnotilogo.png","created_on":"2023-10-13","updated_on":"2023-10-13"},{"id":2,"title":"abc","description":"hhgjhg hjggh","image":"/media/images/CC.ico","created_on":"2023-10-19","updated_on":"2023-10-19"},
    //   {"id":1,"title":"White 10L Color","description":"White is the lightest color and is achromatic (having no hue). It is the color of fresh snow, chalk, and milk, and is the opposite of black. White objects fully reflect and scatter all the visible wavelengths of light. White on television and computer screens is created by a mixture of red, blue, and green light.","image":"/media/images/unnotilogo.png","created_on":"2023-10-13","updated_on":"2023-10-13"},{"id":2,"title":"abc","description":"hhgjhg hjggh","image":"/media/images/CC.ico","created_on":"2023-10-19","updated_on":"2023-10-19"},
    //
    // ];
    log(productList!.length.toString());

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
    double height = MediaQuery.of(context).size.height;
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
            ListTile(
              leading: Icon(
                Icons.token,
                color: Colors.white,
                size: drawerIconSize,
              ),
              title: Text(
                'Token',
                style: TextStyle(fontSize: drawerFontSize, color: Colors.white),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ListTile(
              leading: Icon(
                Icons.propane_outlined,
                color: Colors.white,
                size: drawerIconSize,
              ),
              title: Text(
                'Product',
                style: TextStyle(fontSize: drawerFontSize, color: Colors.white),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ListTile(
              leading: Icon(
                Icons.local_offer_outlined,
                color: Colors.white,
                size: drawerIconSize,
              ),
              title: Text(
                'Offer',
                style: TextStyle(fontSize: drawerFontSize, color: Colors.white),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ListTile(
              leading: Icon(
                Icons.language,
                color: Colors.white,
                size: drawerIconSize,
              ),
              title: Text(
                'Language',
                style: TextStyle(fontSize: drawerFontSize, color: Colors.white),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ListTile(
              leading: Icon(
                Icons.insert_invitation_outlined,
                color: Colors.white,
                size: drawerIconSize,
              ),
              title: Text(
                'Invite Friend',
                style: TextStyle(fontSize: drawerFontSize, color: Colors.white),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ListTile(
              leading: Icon(
                Icons.help,
                color: Colors.white,
                size: drawerIconSize,
              ),
              title: Text(
                'Help',
                style: TextStyle(fontSize: drawerFontSize, color: Colors.white),
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
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600
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
                                    'Product View',
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
                                      itemBuilder: (context, index) => Card(
                                        color: const Color(0xffE6E0F4),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0)),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 5, bottom: 10),
                                          child: ListTile(
                                            leading: CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                'http://abdulazizhardware.com${productList![index]['image']}',
                                              ),
                                              radius: 25,
                                            ),
                                            title: Text(
                                                productList![index]['title']),
                                            // subtitle: Text(productList![index]['description']),
                                            subtitle: Text(productList![index]
                                                            ['description']
                                                        .length >
                                                    65
                                                ? '${productList![index]['description'].substring(0, 65)}...'
                                                : productList![index]
                                                    ['description']),
                                          ),
                                        ),
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
        ),
      ),
    );
  }
}
