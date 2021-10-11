import 'package:flutter/material.dart';
import 'package:slark_v2/components/customAppBar.dart';
import 'package:slark_v2/components/subscriber_charts.dart';
import 'package:slark_v2/models/dashSubs.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final List<DashSubs> data = [
    // DashSubs(
    //   year: '2021',
    //   subs: 1200000,
    //   barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    // ),
    DashSubs('2021', charts.ColorUtil.fromDartColor(Colors.blue), 120000),
    DashSubs('2018', charts.ColorUtil.fromDartColor(Colors.green), 150000),
    DashSubs('2020', charts.ColorUtil.fromDartColor(Colors.red), 140000),
    DashSubs('2015', charts.ColorUtil.fromDartColor(Colors.yellow), 130000),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: CustomAppBar(
          title: 'Dashboard',
        ),
      ),
      body: Center(
        child: SubscriberChart(
          data: data,
        ),
      ),
    );
  }
}
