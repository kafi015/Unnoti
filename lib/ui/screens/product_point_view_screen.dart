import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../data/services/urls.dart';
import '../widgets/screen_background.dart';
import '../widgets/unnoti_appbar.dart';
import '../widgets/unnoti_drawer.dart';

class ProductPointViewScreen extends StatefulWidget {
  const ProductPointViewScreen({Key? key, required this.token, required this.phoneNumber, required this.profileID}) : super(key: key);

  final String token;
  final String phoneNumber;
  final int profileID;

  @override
  State<ProductPointViewScreen> createState() => _ProductPointViewScreenState();
}

class _ProductPointViewScreenState extends State<ProductPointViewScreen> {

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
      Uri.parse(Urls.productPointUrl), //for profile check
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

                                      title: Text(
                                          productList![index]['title']),
                                      // subtitle: Text(productList![index]['description']),
                                     trailing: Text(productList![index]['point']),
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
