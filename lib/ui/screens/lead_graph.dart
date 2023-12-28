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
  List<SalesData> chartData = [];
  double point = 0;

  getProfileData() async {

    inProgress = true;
    setState(() {});

    final http.Response res = await http.get(
      Uri.parse(Urls.rechargeLogUrl),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Token ${AuthUtils.token}'
      },
    );

    log(res.body);
    recharge_log = json.decode(res.body).cast<dynamic>();

    print(recharge_log);

    chartData.add(SalesData(DateTime.utc(2023, 10, 1), 0));
    for(int i=0; i< recharge_log!.length;i++)
      {
        if(recharge_log![i]['key'] == 'Points Paid')
          {
            String value = recharge_log![i]['value'].toString();
            point -= int.parse(value);
            if(point<0) point = 0;
          }
        else
          {
            String value = recharge_log![i]['value'].toString();
            point += int.parse(value);
          }
        String date = recharge_log![i]['date'].toString().split('T').first;
        int year = int.parse(date.split('-').first);
        int month = int.parse(date.split('-')[1]);
        int day = int.parse(date.split('-').last);
        chartData.add(SalesData(DateTime.utc(year, month, day), point));
      }


    // chartData.add(SalesData(DateTime.utc(2023, 1, 5), 40));
    // chartData.add(SalesData(DateTime.utc(2023, 2, 1), 20));
    // chartData.add(SalesData(DateTime.utc(2023, 2, 10), 15));
    // chartData.add(SalesData(DateTime.utc(2023, 3, 20), 16));
    // chartData.add(SalesData(DateTime.utc(2023, 4, 15), 22));
    // chartData.add(SalesData(DateTime.utc(2023, 5, 30), 100));
    // chartData.add(SalesData(DateTime.utc(2023, 5 , 31), 40));


    inProgress = false;
    setState(() {});
  }




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfileData();
  }

  @override
  Widget build(BuildContext context) {

    // final List<SalesData> chartData = [
    //   SalesData(DateTime.utc(2010, 1, 1), 35),
    //   SalesData(DateTime.utc(2011, 1, 1), 28),
    //   SalesData(DateTime.utc(2012, 1, 1), 34),
    //   SalesData(DateTime.utc(2013, 1, 1), 32),
    //   SalesData(DateTime.utc(2014, 1, 1), 40),
    //   SalesData(DateTime.utc(2015, 1, 1), 35),
    //   SalesData(DateTime.utc(2016, 1, 1), 28),
    //   SalesData(DateTime.utc(2017, 1, 1), 34),
    //   SalesData(DateTime.utc(2018, 1, 1), 32),
    //   SalesData(DateTime.utc(2019, 1, 1), 40),
    //
    // ];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ScreenBackground(
        backgroundImage: 'assets/home_background.png',
        widget: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3.0),
            child: inProgress
                ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF8359E3),
              ),
            )
                :SingleChildScrollView(
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
                        height: 350,
                          width: 50000,
                          child: SfCartesianChart(
                            backgroundColor: Colors.black26,
                            borderColor: Colors.purple,
                              borderWidth: 2,
                              primaryYAxis: NumericAxis(
                                title: AxisTitle(text: 'Point'),
                              ),
                              primaryXAxis: DateTimeAxis(
                                axisLine: const AxisLine(
                                  width: 2,
                                ),
                                rangePadding: ChartRangePadding.values.last,
                                borderWidth: 1,
                                title: AxisTitle(text: 'Date'),
                              ),
                              series: <ChartSeries>[
                                // Renders line chart
                                LineSeries<SalesData, DateTime>(
                                  xAxisName: 'Date',
                                    yAxisName: 'Point',
                                    color: Colors.purple,
                                    width: 5,
                                    dataSource: chartData,
                                    xValueMapper: (SalesData sales, _) => sales.year,
                                    yValueMapper: (SalesData sales, _) => sales.sales,
                                  dataLabelMapper: (SalesData sales, int index) => 'Sales: \$${sales.sales}',
                                  name: 'Recharge Log',

                                )
                              ]
                          )
                      )
                  ),
                  const SizedBox(
                    height: 40,
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




class SalesData {
  SalesData(this.year, this.sales);
  final DateTime year;
  final double sales;
}