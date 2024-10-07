import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MultiLineChart extends StatefulWidget {
  MultiLineChart({Key? key}) : super(key: key);

  @override
  State<MultiLineChart> createState() => _MultiLineChartState();
}

class _MultiLineChartState extends State<MultiLineChart> {
  List<FlSpot> earningsData = [];
  List<FlSpot> expenseData = [];
  List<FlSpot> sumData = [];

  @override
  void initState() {
    earningsData = [
      FlSpot(20221010, 394000),
      FlSpot(20221011, 280000),
      FlSpot(20221012, 186000),
      FlSpot(20221013, 490000),
      FlSpot(20221014, 581300),
    ];
    expenseData = [
      FlSpot(20221010, 18000),
      FlSpot(20221011, 39000),
      FlSpot(20221012, 24000),
      FlSpot(20221013, 22000),
      FlSpot(20221014, 33000),
    ];

    for (int i = 0; i < earningsData.length; i++) {
      sumData.add(FlSpot(earningsData[i].x, earningsData[i].y - expenseData[i].y));
    }

    super.initState();
  }

  bool animationStarted = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          // add legend
          Positioned(
            top: 10,
            left: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(5)),
                ),
                SizedBox(width: 5),
                Text('순이익'),
                SizedBox(width: 10),
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(5)),
                ),
                SizedBox(width: 5),
                Text('지출'),
                SizedBox(width: 10),
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(5)),
                ),
                SizedBox(width: 5),
                Text('매출'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 35, left: 15, right: 15, bottom: 15),
            child: LineChart(
              LineChartData(
                titlesData: FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                gridData: FlGridData(show: false),
                lineTouchData: LineTouchData(enabled: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: earningsData,
                    isCurved: true,
                    barWidth: 2,
                    color: Colors.green,
                    dotData: FlDotData(
                      show: false,
                    ),
                  ),
                  LineChartBarData(
                    spots: expenseData,
                    isCurved: true,
                    barWidth: 2,
                    color: Colors.red,
                    dotData: FlDotData(
                      show: false,
                    ),
                  ),
                  LineChartBarData(
                    spots: sumData,
                    isCurved: true,
                    barWidth: 2,
                    color: Colors.indigo,
                    dotData: FlDotData(
                      show: false,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
