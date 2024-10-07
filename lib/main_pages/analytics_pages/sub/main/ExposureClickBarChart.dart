import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ExposureClickBarChart extends StatefulWidget {
  ExposureClickBarChart({Key? key}) : super(key: key);

  @override
  State<ExposureClickBarChart> createState() => _ExposureClickBarChartState();
}

class _ExposureClickBarChartState extends State<ExposureClickBarChart> {
  List<List> dataList = [];
  bool animationStarted = false;
  @override
  void initState() {
    dataList = [
      // date, exposure, click
      ['20221010', 63, 16],
      ['20221011', 55, 19],
      ['20221012', 75, 24],
      ['20221013', 91, 20],
      ['20221014', 69, 27],
    ];
    animateNow();
    super.initState();
  }

  void animateNow() async {
    await Future.delayed(Duration(milliseconds: 300));
    // animate
    setState(() {
      animationStarted = true;
    });
  }

  BarChartData zeroData() {
    return BarChartData(
      barTouchData: BarTouchData(enabled: false),
      maxY: dataList
          .map((e) => e[1] > e[2] ? e[1] : e[2])
          .reduce((value, element) => value > element ? value : element)
          .toDouble(),
      gridData: FlGridData(show: false),
      borderData: FlBorderData(show: false),
      alignment: BarChartAlignment.spaceBetween,
      barGroups: [
        BarChartGroupData(x: int.parse(dataList[0][0]), barRods: [
          BarChartRodData(toY: 0, color: Colors.blue, width: 10),
          BarChartRodData(toY: 0, color: Colors.red, width: 10)
        ]),
        BarChartGroupData(x: int.parse(dataList[1][0]), barRods: [
          BarChartRodData(toY: 0, color: Colors.blue, width: 10),
          BarChartRodData(toY: 0, color: Colors.red, width: 10)
        ]),
        BarChartGroupData(x: int.parse(dataList[2][0]), barRods: [
          BarChartRodData(toY: 0, color: Colors.blue, width: 10),
          BarChartRodData(toY: 0, color: Colors.red, width: 10)
        ]),
        BarChartGroupData(x: int.parse(dataList[3][0]), barRods: [
          BarChartRodData(toY: 0, color: Colors.blue, width: 10),
          BarChartRodData(toY: 0, color: Colors.red, width: 10)
        ]),
        BarChartGroupData(x: int.parse(dataList[4][0]), barRods: [
          BarChartRodData(toY: 0, color: Colors.blue, width: 10),
          BarChartRodData(toY: 0, color: Colors.red, width: 10)
        ]),
      ],
      titlesData: FlTitlesData(
        show: true,

        // left, right, and top titles are not shown
        leftTitles: AxisTitles(),
        rightTitles: AxisTitles(),
        topTitles: AxisTitles(),
        bottomTitles: AxisTitles(
          axisNameSize: 16,
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) {
              return Center(
                child: Text(
                  // use the last 2 digits of the date
                  value.round().toString().substring(6),
                  style: TextStyle(color: Colors.black, fontSize: 13),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          // make legend
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    // round
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue,
                    ),
                    width: 10,
                    height: 10,
                  ),
                  SizedBox(width: 5),
                  Text('노출'),
                ],
              ),
              SizedBox(width: 10),
              Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                  ),
                  SizedBox(width: 5),
                  Text('클릭'),
                ],
              ),
            ],
          ),
        ),
        Center(
          child: Padding(
            padding: EdgeInsets.only(left: 15, right: 15, top: 35),
            child: BarChart(
              swapAnimationCurve: Curves.easeOutCirc,
              swapAnimationDuration: Duration(milliseconds: 500),
              (animationStarted)
                  ? BarChartData(
                      barTouchData: BarTouchData(enabled: false),
                      maxY: dataList
                          .map((e) => e[1] > e[2] ? e[1] : e[2])
                          .reduce((value, element) => value > element ? value : element)
                          .toDouble(),
                      gridData: FlGridData(show: false),
                      borderData: FlBorderData(show: false),
                      alignment: BarChartAlignment.spaceBetween,
                      barGroups: [
                        BarChartGroupData(x: int.parse(dataList[0][0]), barRods: [
                          BarChartRodData(toY: dataList[0][1].toDouble(), color: Colors.blue, width: 10),
                          BarChartRodData(toY: dataList[0][2].toDouble(), color: Colors.red, width: 10)
                        ]),
                        BarChartGroupData(x: int.parse(dataList[1][0]), barRods: [
                          BarChartRodData(toY: dataList[1][1].toDouble(), color: Colors.blue, width: 10),
                          BarChartRodData(toY: dataList[1][2].toDouble(), color: Colors.red, width: 10)
                        ]),
                        BarChartGroupData(x: int.parse(dataList[2][0]), barRods: [
                          BarChartRodData(toY: dataList[2][1].toDouble(), color: Colors.blue, width: 10),
                          BarChartRodData(toY: dataList[2][2].toDouble(), color: Colors.red, width: 10)
                        ]),
                        BarChartGroupData(x: int.parse(dataList[3][0]), barRods: [
                          BarChartRodData(toY: dataList[3][1].toDouble(), color: Colors.blue, width: 10),
                          BarChartRodData(toY: dataList[3][2].toDouble(), color: Colors.red, width: 10)
                        ]),
                        BarChartGroupData(x: int.parse(dataList[4][0]), barRods: [
                          BarChartRodData(toY: dataList[4][1].toDouble(), color: Colors.blue, width: 10),
                          BarChartRodData(toY: dataList[4][2].toDouble(), color: Colors.red, width: 10)
                        ]),
                      ],
                      titlesData: FlTitlesData(
                        show: true,
                        // left, right, and top titles are not shown
                        leftTitles: AxisTitles(),
                        rightTitles: AxisTitles(),
                        topTitles: AxisTitles(),
                        bottomTitles: AxisTitles(
                          axisNameSize: 16,
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              return Center(
                                child: Text(
                                  // use the last 2 digits of the date
                                  value.round().toString().substring(6),
                                  style: TextStyle(color: Colors.black, fontSize: 13),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    )
                  : zeroData(),
            ),
          ),
        ),
      ],
    );
  }
}
