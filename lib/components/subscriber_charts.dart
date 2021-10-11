import 'package:flutter/material.dart';
import 'package:slark_v2/models/dashSubs.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class SubscriberChart extends StatefulWidget {
  final List<DashSubs>? data;
  SubscriberChart({this.data});

  @override
  _SubscriberChartState createState() => _SubscriberChartState();
}

class _SubscriberChartState extends State<SubscriberChart> {
  @override
  Widget build(BuildContext context) {
    List<charts.Series<DashSubs, String>> series = [
      charts.Series(
        data: widget.data!,
        id: 'Subscribers',
        domainFn: (DashSubs series, _) => series.year,
        measureFn: (DashSubs series, _) => series.subs,
        colorFn: (DashSubs series, _) => series.barcolor,
      )
    ];
    return Container(
      height: 400,
      padding: EdgeInsets.all(20.0),
      child: Card(
        child: Column(
          children: [
            Text('Dashboard Admin'),
            Expanded(
              child: charts.BarChart(
                series,
                animate: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
