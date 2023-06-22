import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MoneyWidget extends StatefulWidget {
  const MoneyWidget({super.key});

  @override
  State<MoneyWidget> createState() => _MoneyWidgetState();
}

class _MoneyWidgetState extends State<MoneyWidget> {
  List<FlSpot> dataSet = [];
  DateTime today = DateTime.now();

  List<FlSpot> getPlotPoints(Map entireData) {
    dataSet = [];
    entireData.forEach((key, value) {
      if (value['type'] == 'Income' &&
          (value['date'] as DateTime).month == today.month) {
        dataSet.add(FlSpot((value['date'] as DateTime).month.toDouble(),
            (value['amount'] as int).toDouble()));
      }
    });
    return dataSet;
  }

  @override
  Widget build(BuildContext context) {
    return dataSet.length < 2
        ? Container(
            decoration: BoxDecoration(
              color: Color(0xffE6E6E6),
              borderRadius: BorderRadius.circular(16),
              // boxShadow: [
              //   BoxShadow(
              //       color: Colors.black.withOpacity(0.5),
              //       spreadRadius: 5,
              //       blurRadius: 6,
              //       offset: Offset(0, 4))
              // ]
            ),
            padding: EdgeInsets.symmetric(vertical: 20),
            margin: EdgeInsets.all(22.0),
            height: 300,
            child: Text('no data'))
        : Container(
            decoration: BoxDecoration(
              color: Color(0xffE6E6E6),
              borderRadius: BorderRadius.circular(16),
              // boxShadow: [
              //   BoxShadow(
              //       color: Colors.black.withOpacity(0.5),
              //       spreadRadius: 5,
              //       blurRadius: 6,
              //       offset: Offset(0, 4))
              // ]
            ),
            padding: EdgeInsets.symmetric(vertical: 20),
            margin: EdgeInsets.all(22.0),
            height: 300,
            child: LineChart(
              LineChartData(
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                      spots: getPlotPoints(s),
                      isCurved: false,
                      barWidth: 2.5,
                      color: Colors.red),
                ],
              ),
            ),
          );
  }
}
