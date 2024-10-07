import 'package:flutter/material.dart';
import 'package:servicer/MOD_PACKAGES/fl_chart_svc/fl_chart.dart';
import 'package:servicer/MOD_PACKAGES/fl_chart_svc/fl_chart.dart';
import 'package:servicer/design_standards/colors.dart';
import 'package:servicer/design_standards/text_styles.dart';
import 'package:servicer/design_standards/widget_styles.dart';

class LineChartContainer extends StatefulWidget {
  LineChartContainer({Key? key}) : super(key: key);

  @override
  State<LineChartContainer> createState() => _LineChartContainerState();
}

class _LineChartContainerState extends State<LineChartContainer> {
  List<bool> _isSelected = [true, false, false, false, false, false];
  double _chartAnimationDuration = 400;
  bool toggle = false;
  late LineChartBarData data;
  LineChartBarData dataOne = LineChartBarData(
    isCurved: true,
    curveSmoothness: 0.0,
    preventCurveOverShooting: true,
    belowBarData: BarAreaData(color: Colors.transparent, show: false),
    dotData: FlDotData(show: false),
    color: $$mainColor4,
    barWidth: 3,
    isStrokeCapRound: true,
    spots: [
      FlSpot(1, -12000),
      FlSpot(2, -10000),
      FlSpot(3, -20000),
      FlSpot(4, -15000),
      FlSpot(5, -20000),
      FlSpot(6, 2000),
      FlSpot(7, 10000),
      FlSpot(8, 10000),
      FlSpot(9, 12000),
      FlSpot(10, 26000),
      FlSpot(11, 30000),
      FlSpot(12, 10000),
      FlSpot(13, 20000),
      FlSpot(14, 24000),
      FlSpot(15, 20000),
      FlSpot(16, 18000),
      FlSpot(17, 15000),
      FlSpot(18, 19000),
      FlSpot(19, 22000),
      FlSpot(20, 26000),
      FlSpot(21, 30000),
      FlSpot(22, 26000),
      FlSpot(23, 23000),
      FlSpot(24, 25000),
      FlSpot(25, 29000),
      FlSpot(26, 28000),
      FlSpot(27, 33000),
      FlSpot(28, 40000),
      FlSpot(29, 39000),
      FlSpot(30, 40000),
    ],
  );

  LineChartBarData dataTwo = LineChartBarData(
    isCurved: true,
    curveSmoothness: 0.0,
    preventCurveOverShooting: true,
    dotData: FlDotData(show: false),
    color: $$mainColor4,
    barWidth: 3,
    isStrokeCapRound: true,
    belowBarData: BarAreaData(color: Colors.transparent, show: false),
    spots: [
      FlSpot(5, -20000),
      FlSpot(6, 10000),
      FlSpot(7, 12000),
      FlSpot(8, 26000),
      FlSpot(9, 12000),
      FlSpot(10, 26000),
    ],
  );
  @override
  void initState() {
    super.initState();
    data = dataOne;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.34,
          margin: EdgeInsets.all(16), //* 그래프 컨테이너 바깥쪽 간격
          padding: EdgeInsets.all(4), //* 그래프 컨테이너 안쪽 간격
          decoration: BoxDecoration(
            // gradient: LinearGradient(
            //   colors: [Colors.black, Colors.white],
            //   begin: Alignment.topLeft,
            //   end: Alignment(0.8, 1),
            //   tileMode: TileMode.mirror,
            // ),
            color: Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(32)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: LineChart(
              //! ANCHOR 그래프 몸통 부분
              LineChartData(
                  gridData: FlGridData(
                    getDrawingHorizontalLine: (double value) => FlLine(color: Colors.transparent, strokeWidth: 1),
                    getDrawingVerticalLine: (double value) => FlLine(color: Colors.transparent, strokeWidth: 0.5),
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    topTitles: AxisTitles(
                        // axisNameWidget: Text('그래프',
                        //     style:
                        //         TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        // axisNameSize: 50,
                        ),
                    bottomTitles: AxisTitles(
                        // sideTitles: SideTitles(
                        //   showTitles: true,
                        //   reservedSize: 30,
                        //   interval: 5,
                        // ),
                        ),
                    rightTitles: AxisTitles(),
                    leftTitles: AxisTitles(
                        // sideTitles: SideTitles(
                        //   showTitles: true,
                        //   interval: 10000,
                        //   reservedSize: 50,
                        //   getTitlesWidget: (double value, TitleMeta meta) {
                        //     return Padding(
                        //       padding: const EdgeInsets.all(2.0),
                        //       child: Text(
                        //         '${(value.toInt() / 10000).toInt().toString()}만원',
                        //         style: TextStyle(
                        //             color: Colors.black,
                        //             fontWeight: FontWeight.bold,
                        //             fontSize: 10),
                        //       ),
                        //     );
                        //   },
                        // ),
                        ),
                  ),
                  clipData: FlClipData.none(),
                  backgroundColor: Colors.transparent,
                  lineBarsData: [
                    data,
                  ],
                  borderData: FlBorderData(
                    border: Border.all(
                      color: Colors.green,
                      style: BorderStyle.solid,
                      width: 0,
                    ),
                  ),
                  // extraLinesData: ExtraLinesData(horizontalLines: [
                  //   HorizontalLine(
                  //     y: 12000,
                  //     color: $$Grey,
                  //     strokeWidth: 1,
                  //     dashArray: [20, 2],
                  //   ),
                  // ]),
                  lineTouchData: LineTouchData(
                    getTouchedSpotIndicator: (LineChartBarData barData, List<int> spotIndexes) {
                      return spotIndexes.map((spotIndex) {
                        final spot = barData.spots[spotIndex];

                        return TouchedSpotIndicatorData(
                          FlLine(color: $$Grey, strokeWidth: 0.9),
                          FlDotData(
                            getDotPainter: (spot, percent, barData, index) {
                              return FlDotCirclePainter(
                                  radius: 0.2, color: $$mainColor4, strokeWidth: 5, strokeColor: $$mainColor4);
                            },
                          ),
                        );
                      }).toList();
                    },
                    touchTooltipData: LineTouchTooltipData(
                        tooltipBgColor: Colors.transparent,
                        getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                          return touchedBarSpots.map((barSpot) {
                            final flSpot = barSpot;
                            // if (flSpot.x == 0 || flSpot.x == 6) {
                            //   return null;
                            // }

                            TextAlign textAlign;
                            switch (flSpot.x.toInt()) {
                              case 0:
                                textAlign = TextAlign.left;
                                break;

                              default:
                                textAlign = TextAlign.center;
                            }

                            return LineTooltipItem(
                              '',
                              TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                              children: [
                                TextSpan(
                                  text: '2022.12.',
                                  style: TextStyle(
                                    color: $$Grey,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                TextSpan(
                                  text: (flSpot.x).toInt().toString(),
                                  style: TextStyle(
                                    color: $$Grey,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                TextSpan(
                                  text: '\n',
                                  style: TextStyle(
                                    color: $$Grey,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                TextSpan(
                                  text: (flSpot.y).toInt().toString(),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                TextSpan(
                                  text: ' 원 \n',
                                  style: TextStyle(
                                    //fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                TextSpan(
                                  text: (flSpot.y / 100).toInt().toString(),
                                  style: TextStyle(
                                    color: $$Grey,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                TextSpan(
                                  text: ' 건 ',
                                  style: TextStyle(
                                    //fontStyle: FontStyle.italic,
                                    color: $$Grey,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                              textAlign: textAlign,
                            );
                          }).toList();
                        }),
                  )),
              swapAnimationDuration: Duration(milliseconds: _chartAnimationDuration.toInt()),
              swapAnimationCurve: Curves.easeOutCirc,
            ),
          ),
        ),
        Center(
          child: ToggleButtons(
            splashColor: Colors.transparent,
            renderBorder: false,
            //borderRadius: BorderRadius.circular(15),
            constraints: BoxConstraints.expand(
              height: 25,
              width: MediaQuery.of(context).size.width * 0.13,
            ),
            color: $$Grey,
            fillColor: Colors.transparent,
            selectedColor: $$mainColor4,
            children: [
              Text('1일'),
              Text('1주'),
              Text('1개월'),
              Text('3개월'),
              Text('1년'),
              Text('5년'),
            ],
            isSelected: _isSelected,
            onPressed: (int newIndex) {
              setState(() {
                for (int i = 0; i < _isSelected.length; i++) {
                  if (i == newIndex) {
                    _isSelected[i] = true;
                  } else {
                    _isSelected[i] = false;
                    data = newIndex == 1 ? dataTwo : dataOne;
                  }
                  //print(_isSelected);
                }
              });
            },
          ),
        ),
      ],
    );
  }
}
