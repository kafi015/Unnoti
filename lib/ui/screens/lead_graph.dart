import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:unnoti/ui/widgets/screen_background.dart';

import '../../data/auth_utils.dart';
import '../../data/services/urls.dart';

class LeadGraphScreen extends StatefulWidget {
  const LeadGraphScreen({super.key});

  @override
  State<LeadGraphScreen> createState() => _LeadGraphScreenState();
}

class _LeadGraphScreenState extends State<LeadGraphScreen> {
  Map? valueMap;
  List<dynamic>? rechargeLog;
  List<dynamic>? productList;
  bool inProgress = false;
  double point = 0;

  getRechargeLog() async {
    inProgress = true;
    setState(() {});

    final http.Response res = await http.get(
      Uri.parse(Urls.rechargeLogUrl),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Token ${AuthUtils.token}'
      },
    );

    //  log(res.body);
    rechargeLog = json.decode(res.body).cast<dynamic>();

    log(rechargeLog.toString());

    inProgress = false;
    setState(() {});
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRechargeLog();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        backgroundImage: 'assets/home_background.png',
        widget: SingleChildScrollView(
          child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text(
                          'Back',
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.red,
                          ),
                        )),
                    inProgress?const SizedBox(
                      height: 300,
                    ):const SizedBox(
                      height: 100,
                    ),
                     Center(
                      child: inProgress
                          ? const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFF8359E3),
                        ),
                      )
                          :SizedBox(
                        height: 500,
                        child: _MyHomePage(),
                      ),
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}


class _MyHomePage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  _MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<_MyHomePage> {
  late List<_ChartData> data;
  late TooltipBehavior _tooltip;

  @override
  void initState() {
    data = [
      _ChartData('CHN', 12),
      _ChartData('GER', 15),
      _ChartData('RUS', 30),
      _ChartData('BRZ', 6.4),
      _ChartData('IND', 14)
    ];
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Syncfusion Flutter chart'),
        ),
        body: SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            primaryYAxis: NumericAxis(minimum: 0, maximum: 40, interval: 10),
            tooltipBehavior: _tooltip,
            series: <CartesianSeries<_ChartData, String>>[
              ColumnSeries<_ChartData, String>(
                  dataSource: data,
                  xValueMapper: (_ChartData data, _) => data.x,
                  yValueMapper: (_ChartData data, _) => data.y,
                  name: 'Gold',
                  color: Color.fromRGBO(8, 142, 255, 1))
            ]));
  }
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}