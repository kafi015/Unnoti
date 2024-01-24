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
  String dateInList = '';
  List<dynamic> xValueSample = [];
  List<dynamic> yValueSample = [];

  static List<dynamic> xValue = [];
  static List<dynamic> yValue = [];

  getRechargeLog() async {
    inProgress = true;
    setState(() {});

    try {
      final http.Response res = await http.get(
        Uri.parse(Urls.rechargeLogUrl),
        headers: {
          "Content-Type": "application/json",
           'Authorization': 'Token ${AuthUtils.token}'
          // 'Authorization': 'Token 7ffc5f9aff892a14542a042ef8e3fda7477028c2'
        },
      );

      //  log(res.body);
      rechargeLog = json.decode(res.body).cast<dynamic>();

      log(rechargeLog.toString());
      log(rechargeLog!.length.toString());

      for (int i = 0; i < rechargeLog!.length; i++) {
        log('Show for index ${i.toString()}');
        if (rechargeLog![i]['key'] == 'Points Paid') {
          /// For Point
          log(rechargeLog![i]['value'].toString());
          int x = rechargeLog![i]['value'];
          log('show x:  $x');
          point -= x;
          log('show point:  $point');

          /// For Date
          log(rechargeLog![i]['date'].toString());
          dateInList = rechargeLog![i]['date'];
          log('show dateInList:  $dateInList');
          // String date1 = date.split('T').first.toString();
          // log('show date1:  ${date1}');
          //
          // dateInList = date1.split('-').toList();
          // log('show dateInList:  ${dateInList}');
        } else {
          /// For Point
          log(rechargeLog![i]['value'].toString());
          int x = rechargeLog![i]['value'];
          log('show x:  $x');
          point += x;
          log('show point:  $point');

          /// For Date
          log(rechargeLog![i]['date'].toString());
          dateInList = rechargeLog![i]['date'];
          log('show dateInList:  $dateInList');

          // /// For Date
          // log(rechargeLog![i]['date'].toString());
          // String date = rechargeLog![i]['date'];
          // log('show date:  ${date}');
          // String date1 = date.split('T').first.toString();
          // log('show date1:  ${date1}');
          //
          // dateInList = date1.split('-').toList();
          // log('show dateInList:  ${dateInList}');
          // point -= x;
          // log('show point:  ${point}');
        }

        xValueSample.add(dateInList);
        log('show xValueSample:  $xValueSample');

        yValueSample.add(point);
        log('show yValueSample:  $yValueSample');
      }

      xValue = xValueSample;
      yValue = yValueSample;
      log('show xValue:  $xValue');
      log('show yValue:  $yValue');
    } catch (e) {
      log('Catch Block Error: $e');
    }

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
          child: Column(
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
              inProgress
                  ? const SizedBox(
                      height: 300,
                    )
                  : const SizedBox(
                      height: 50,
                    ),
              Center(
                child: inProgress
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFF8359E3),
                        ),
                      )
                    : SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: SizedBox(
                          height: 700,
                          width: 3000,
                          child: _GraphPage(),
                        ),
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

class _GraphPage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  _GraphPage({Key? key}) : super(key: key);

  @override
  _GraphPageState createState() => _GraphPageState();
}

class _GraphPageState extends State<_GraphPage> {
  List<_ChartData> data = [];
  late TooltipBehavior _tooltip;
  double max = 0;

  @override
  void initState() {
    log(' _LeadGraphScreenState.xValue:   ${_LeadGraphScreenState.xValue}');
    log(' _LeadGraphScreenState.yValue:   ${_LeadGraphScreenState.yValue}');

    for (int i = 0; i < _LeadGraphScreenState.xValue.length; i++) {
      data.add(_ChartData(DateTime.parse(_LeadGraphScreenState.xValue[i]),
          _LeadGraphScreenState.yValue[i]));

      log('${_LeadGraphScreenState.xValue[i]} ===== ${_LeadGraphScreenState.yValue[i]} ');
      max = _LeadGraphScreenState.yValue[i]>max? _LeadGraphScreenState.yValue[i]: max;
    }

    // data = [
    //   _ChartData(DateTime.parse("2023-12-28T02:29:59.927917+06:00"), 12),
    //   _ChartData(DateTime.parse("2023-12-28T12:56:21.158077+06:00"), 70),
    // //  //  _ChartData(DateTime(2023, 02, 01), 15),
    // //  //  _ChartData(DateTime(2023, 03, 01), 30),
    // //  //  _ChartData(DateTime(2023, 04, 01), 6.4),
    // //  //  _ChartData(DateTime(2023, 05, 01), 14)
    // ];
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Redeem History'),
        ),
        body: SfCartesianChart(
            primaryXAxis: const DateTimeAxis(),
            primaryYAxis: NumericAxis(minimum: 0, maximum: max+20, interval: 10),
            tooltipBehavior: _tooltip,
            series: <CartesianSeries<_ChartData, DateTime>>[
              LineSeries<_ChartData, DateTime>(
                  width: 10,
                  selectionBehavior: SelectionBehavior(selectedBorderWidth: 20),
                  dataSource: data,
                  xValueMapper: (_ChartData data, _) => data.x,
                  yValueMapper: (_ChartData data, _) => data.y,
                  name: 'Point',
                  color: Colors.purple),
            ]));
  }
}

class _ChartData {
  _ChartData(this.x, this.y);

  final DateTime x;
  final double y;
}
