import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:greencare/utils/api_url.dart';

class BarCharSample extends StatefulWidget {
  const BarCharSample({super.key});

  @override
  State<BarCharSample> createState() => _BarCharSampleState();
}

class _BarCharSampleState extends State<BarCharSample> {
  double totalIncome = 0.0;
  double totalExpense = 0.0;
  double totalBalance = 0.0;

  List incomeItem = [];
  List dateItem = [];
  List expenseItem = [];
  int? userID;
  double? total;
  int? count;
  Map<String, dynamic> monthsIncome = {
    "JAN": 0.0,
    "FEB": 0.0,
    "MAR": 0.0,
    "APR": 0.0,
    "MAY": 0.0,
    "JUN": 0.0,
    "JUL": 0.0,
    "AUG": 0.0,
    "SEP": 0.0,
    "OCT": 0.0,
    "NOV": 0.0,
    "DEC": 0.0,
  };
  Map<String, dynamic> monthsExpense = {
    "JAN": 0.0,
    "FEB": 0.0,
    "MAR": 0.0,
    "APR": 0.0,
    "MAY": 0.0,
    "JUN": 0.0,
    "JUL": 0.0,
    "AUG": 0.0,
    "SEP": 0.0,
    "OCT": 0.0,
    "NOV": 0.0,
    "DEC": 0.0,
  };
  @override
  void initState() {
    super.initState();
    check();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Text(
            "สรุปค่าใช้จ่าย",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
              height: 50,
              width: 650,
              decoration: BoxDecoration(
                  color: Color(0xffE6E6E6),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 30),
                  Container(
                    height: 16,
                    width: 16,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.blueAccent, Colors.redAccent],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter),
                        borderRadius: BorderRadius.circular(14)),
                  ),
                  Text("    รายได้"),
                  SizedBox(width: 30),
                  Container(
                    height: 16,
                    width: 16,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.greenAccent, Colors.redAccent],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter),
                        borderRadius: BorderRadius.circular(14)),
                  ),
                  Text("    รายจ่าย"),
                ],
              )),
          Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                children: [
                  Container(
                      height: 250,
                      width: 650,
                      decoration: BoxDecoration(
                        color: Color(0xffE6E6E6),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(16),
                        ),
                      ),
                      child: AspectRatio(aspectRatio: 1, child: MyBarChart())),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future getTransection() async {
    var url = Uri.http(urlH(), '/api/transection/$userID');
    var response = await http.get(url);
    // var result = json.decode(response.body);
    var result = utf8.decode(response.bodyBytes);
    setState(() {
      incomeItem = json.decode(result);
      for (int i = 0; i < incomeItem.length; i++) {
        if (incomeItem[i]['transtype'] == 'Income') {
          dateItem = incomeItem[i]['date'].split(' ');
          if (dateItem[1] == 'ม.ค.') {
            monthsIncome["JAN"] += double.parse(incomeItem[i]['amount']);
          } else if (dateItem[1] == 'ก.พ.') {
            monthsIncome["FEB"] += double.parse(incomeItem[i]['amount']);
          } else if (dateItem[1] == 'มี.ค.') {
            monthsIncome["MAR"] += double.parse(incomeItem[i]['amount']);
          } else if (dateItem[1] == 'เม.ย.') {
            monthsIncome["APR"] += double.parse(incomeItem[i]['amount']);
          } else if (dateItem[1] == 'พ.ค.') {
            monthsIncome["MAY"] += double.parse(incomeItem[i]['amount']);
          } else if (dateItem[1] == 'มิ.ย.') {
            monthsIncome["JUN"] += double.parse(incomeItem[i]['amount']);
          } else if (dateItem[1] == 'ก.ค.') {
            monthsIncome["JUL"] += double.parse(incomeItem[i]['amount']);
          } else if (dateItem[1] == 'ส.ค.') {
            monthsIncome["AUG"] += double.parse(incomeItem[i]['amount']);
          } else if (dateItem[1] == 'ก.ย.') {
            monthsIncome["SEP"] += double.parse(incomeItem[i]['amount']);
          } else if (dateItem[1] == 'ต.ค.') {
            monthsIncome["OCT"] += double.parse(incomeItem[i]['amount']);
          } else if (dateItem[1] == 'พ.ย.') {
            monthsIncome["NOV"] += double.parse(incomeItem[i]['amount']);
          } else if (dateItem[1] == 'ธ.ค.') {
            monthsIncome["DEC"] += double.parse(incomeItem[i]['amount']);
          }

          // totalIncome += double.parse(incomeItem[i]['amount']);
        } else if (incomeItem[i]['transtype'] == 'Expense') {
          dateItem = incomeItem[i]['date'].split(' ');
          if (dateItem[1] == 'ม.ค.') {
            monthsExpense["JAN"] += double.parse(incomeItem[i]['amount']);
          } else if (dateItem[1] == 'ก.พ.') {
            monthsExpense["FEB"] += double.parse(incomeItem[i]['amount']);
          } else if (dateItem[1] == 'มี.ค.') {
            monthsExpense["MAR"] += double.parse(incomeItem[i]['amount']);
          } else if (dateItem[1] == 'เม.ย.') {
            monthsExpense["APR"] += double.parse(incomeItem[i]['amount']);
          } else if (dateItem[1] == 'พ.ค.') {
            monthsExpense["MAY"] += double.parse(incomeItem[i]['amount']);
          } else if (dateItem[1] == 'มิ.ย.') {
            monthsExpense["JUN"] += double.parse(incomeItem[i]['amount']);
          } else if (dateItem[1] == 'ก.ค.') {
            monthsExpense["JUL"] += double.parse(incomeItem[i]['amount']);
          } else if (dateItem[1] == 'ส.ค.') {
            monthsExpense["AUG"] += double.parse(incomeItem[i]['amount']);
          } else if (dateItem[1] == 'ก.ย.') {
            monthsExpense["SEP"] += double.parse(incomeItem[i]['amount']);
          } else if (dateItem[1] == 'ต.ค.') {
            monthsExpense["OCT"] += double.parse(incomeItem[i]['amount']);
          } else if (dateItem[1] == 'พ.ย.') {
            monthsExpense["NOV"] += double.parse(incomeItem[i]['amount']);
          } else if (dateItem[1] == 'ธ.ค.') {
            monthsExpense["DEC"] += double.parse(incomeItem[i]['amount']);
          }
        }
      }
      print(totalIncome);
      print(totalExpense);
      totalBalance = totalIncome - totalExpense;
      print("Total ${totalBalance}");
    });
  }

  void check() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final checkvalue = pref.get('user') ?? 0;
    if (checkvalue != 0) {
      getUsername();
    }
  }

  void getUsername() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      var username = pref.getInt('user');
      userID = username;
      print(userID);
      getTransection();
    });
  }

  Widget MyBarChart() {
    return BarChart(BarChartData(
        barTouchData: barTouchData,
        titlesData: titlesData,
        borderData: borderData,
        barGroups: barGroups,
        gridData: FlGridData(show: false),
        alignment: BarChartAlignment.spaceAround,
        maxY: 3100));
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: true,
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.toString(),
              const TextStyle(
                  color: Color(0xff7589a2), fontWeight: FontWeight.bold),
            );
          },
        ),
      );
  Widget getTitles(double value, TitleMeta meta) {
    final style = TextStyle(color: Colors.green, fontWeight: FontWeight.bold);
    String text;
    switch (value.toInt()) {
      case 0:
        text = "ม.ค.";
        break;
      case 1:
        text = "ก.พ.";
        break;
      case 2:
        text = "มี.ค.";
        break;
      case 3:
        text = "เม.ย.";
        break;
      case 4:
        text = "พ.ค.";
        break;
      case 5:
        text = "มิ.ย.";
        break;
      case 6:
        text = "ก.ค.";
        break;
      case 7:
        text = "ส.ค.";
        break;
      case 8:
        text = "ก.ย.";
        break;
      case 9:
        text = "ต.ค.";
        break;
      case 10:
        text = "พ.ย.";
        break;
      case 11:
        text = "ธ.ค.";
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      child: Text(
        text,
        style: style,
      ),
      axisSide: meta.axisSide,
      space: 4,
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
      show: true,
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 40,
          getTitlesWidget: getTitles,
        ),
      ),
      leftTitles: AxisTitles(
          sideTitles:
              SideTitles(showTitles: true, getTitlesWidget: leftTitles)),
      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)));

  FlBorderData get borderData => FlBorderData(show: false);
  LinearGradient get _barGradient => LinearGradient(
      colors: [Colors.blueAccent, Colors.redAccent],
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter);
  LinearGradient get _barGradient2 => LinearGradient(
      colors: [Colors.greenAccent, Colors.redAccent],
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter);

  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    if (value == 0) {
      text = '0';
    } else if (value == 1000) {
      text = '1K';
    } else if (value == 2000) {
      text = '2k';
    } else if (value == 3000) {
      text = '3k';
    } else {
      return Container();
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 0,
      child: Text(text, style: style),
    );
  }

  List<BarChartGroupData> get barGroups => [
        BarChartGroupData(
          barsSpace: 5,
          x: 0,
          barRods: [
            BarChartRodData(
              toY: monthsIncome["JAN"],
              gradient: _barGradient,
              width: 12,
            ),
            BarChartRodData(
              toY: monthsExpense["JAN"],
              gradient: _barGradient2,
              width: 12,
            )
          ],
        ),
        BarChartGroupData(
          barsSpace: 5,
          x: 1,
          barRods: [
            BarChartRodData(
              toY: monthsIncome["FEB"],
              gradient: _barGradient,
              width: 12,
            ),
            BarChartRodData(
              toY: monthsExpense["FEB"],
              gradient: _barGradient2,
              width: 12,
            )
          ],
        ),
        BarChartGroupData(
          barsSpace: 5,
          x: 2,
          barRods: [
            BarChartRodData(
              toY: monthsIncome["MAR"],
              gradient: _barGradient,
              width: 12,
            ),
            BarChartRodData(
              toY: monthsExpense["MAR"],
              gradient: _barGradient2,
              width: 12,
            )
          ],
        ),
        BarChartGroupData(
          barsSpace: 5,
          x: 3,
          barRods: [
            BarChartRodData(
              toY: monthsIncome["APR"],
              gradient: _barGradient,
              width: 12,
            ),
            BarChartRodData(
              toY: monthsExpense["APR"],
              gradient: _barGradient2,
              width: 12,
            )
          ],
        ),
        BarChartGroupData(
          barsSpace: 5,
          x: 4,
          barRods: [
            BarChartRodData(
              toY: monthsIncome["MAY"],
              gradient: _barGradient,
              width: 12,
            ),
            BarChartRodData(
              toY: monthsExpense["MAY"],
              gradient: _barGradient2,
              width: 12,
            )
          ],
        ),
        BarChartGroupData(
          barsSpace: 5,
          x: 5,
          barRods: [
            BarChartRodData(
              toY: monthsIncome["JUN"],
              gradient: _barGradient,
              width: 12,
            ),
            BarChartRodData(
              toY: monthsExpense["JUN"],
              gradient: _barGradient2,
              width: 12,
            )
          ],
        ),
        BarChartGroupData(
          barsSpace: 5,
          x: 6,
          barRods: [
            BarChartRodData(
              toY: monthsIncome["JUL"],
              gradient: _barGradient,
              width: 12,
            ),
            BarChartRodData(
              toY: monthsExpense["JUL"],
              gradient: _barGradient2,
              width: 12,
            )
          ],
        ),
        BarChartGroupData(
          barsSpace: 5,
          x: 7,
          barRods: [
            BarChartRodData(
              toY: monthsIncome["AUG"],
              gradient: _barGradient,
              width: 12,
            ),
            BarChartRodData(
              toY: monthsExpense["AUG"],
              gradient: _barGradient2,
              width: 12,
            )
          ],
        ),
        BarChartGroupData(
          barsSpace: 5,
          x: 8,
          barRods: [
            BarChartRodData(
              toY: monthsIncome["SEP"],
              gradient: _barGradient,
              width: 12,
            ),
            BarChartRodData(
              toY: monthsExpense["SEP"],
              gradient: _barGradient2,
              width: 12,
            )
          ],
        ),
        BarChartGroupData(
          barsSpace: 5,
          x: 9,
          barRods: [
            BarChartRodData(
              toY: monthsIncome["OCT"],
              gradient: _barGradient,
              width: 12,
            ),
            BarChartRodData(
              toY: monthsExpense["OCT"],
              gradient: _barGradient2,
              width: 12,
            )
          ],
        ),
        BarChartGroupData(
          barsSpace: 5,
          x: 11,
          barRods: [
            BarChartRodData(
              toY: monthsIncome["NOV"],
              gradient: _barGradient,
              width: 12,
            ),
            BarChartRodData(
              toY: monthsExpense["NOV"],
              gradient: _barGradient2,
              width: 12,
            )
          ],
        ),
        BarChartGroupData(
          barsSpace: 5,
          x: 11,
          barRods: [
            BarChartRodData(
              toY: monthsIncome["DEC"],
              gradient: _barGradient,
              width: 12,
            ),
            BarChartRodData(
              toY: monthsExpense["DEC"],
              gradient: _barGradient2,
              width: 12,
            )
          ],
        ),
      ];
}
