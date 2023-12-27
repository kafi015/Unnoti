import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:unnoti/ui/widgets/screen_background.dart';
import 'package:http/http.dart'  as http;
import '../../data/auth_utils.dart';
import '../../data/services/urls.dart';



class LeadGraphScreen extends StatefulWidget {
  const LeadGraphScreen({super.key});

  @override
  State<LeadGraphScreen> createState() => _LeadGraphScreenState();
}

class _LeadGraphScreenState extends State<LeadGraphScreen> {
  Map? valueMap;
  List<dynamic>? recharge_log;
  List<dynamic>? productList;
  bool inProgress = false;

  getProfileData(int id) async {

    inProgress = true;
    setState(() {});

    final http.Response res = await http.get(
      Uri.parse('Urls.rechargeLogUrl'),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Token ${AuthUtils.token}'
      },
    );

    log(res.body);
    recharge_log = json.decode(res.body).cast<dynamic>();
    productList = recharge_log!.reversed.toList();
    //print(productList);

    inProgress = false;
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {

    final List<SalesData> chartData = [
      SalesData(DateTime.utc(2010, 1, 1), 35),
      SalesData(DateTime.utc(2011, 1, 1), 28),
      SalesData(DateTime.utc(2012, 1, 1), 34),
      SalesData(DateTime.utc(2013, 1, 1), 32),
      SalesData(DateTime.utc(2014, 1, 1), 40),
      SalesData(DateTime.utc(2015, 1, 1), 35),
      SalesData(DateTime.utc(2016, 1, 1), 28),
      SalesData(DateTime.utc(2017, 1, 1), 34),
      SalesData(DateTime.utc(2018, 1, 1), 32),
      SalesData(DateTime.utc(2019, 1, 1), 40),

    ];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ScreenBackground(
        backgroundImage: 'assets/home_background.png',
        widget: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 50,
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
                    height: 40,
                  ),
                  Center(
                      child: SizedBox(
                        height: 500,
                          child: SfCartesianChart(

                            borderColor: Colors.purple,
                              primaryXAxis: DateTimeAxis(),

                              series: <ChartSeries>[
                                // Renders line chart
                                LineSeries<SalesData, DateTime>(
                                    dataSource: chartData,
                                    xValueMapper: (SalesData sales, _) => sales.year,
                                    yValueMapper: (SalesData sales, _) => sales.sales
                                )
                              ]
                          )
                      )
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}




class SalesData {
  SalesData(this.year, this.sales);
  final DateTime year;
  final double sales;
}