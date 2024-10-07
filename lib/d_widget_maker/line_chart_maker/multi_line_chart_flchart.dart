import 'package:flutter/material.dart';

import '../../MOD_PACKAGES/fl_chart_svc/fl_chart.dart';

import '../../data_handler/mapData_handler/get_map_data.dart';
import '../../data_handler/mapData_handler/line_chart/multi_line/mapData_toMulitmap.dart';
import '../../data_handler/mapData_handler/mapData_picker.dart';
import '../../data_handler/mapData_handler/mapData_time.dart';
import '../../data_handler/text/chart_text.dart';
import '../../design_standards/colors.dart';
import '../../data_handler/data_standards/category.dart';
import '../../design_standards/text_styles.dart';
import '../../design_standards/widget_styles.dart';
import '../../main_pages/analytics_pages/sub/multi_chart.dart';

class MultiLineChartMaker {
  multiLineChartMaker(data, time, category, width) {
    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        //현재 그래프 기간
        Padding(
          padding: $AnalyticsPageHorizontalPadding,
          child: Text(
              ChartText().getTimeRange(
                  MapDataTimeRange().pickTimeRange(data, time, 20220830)),
              style: TextStyle(fontSize: $mediumFontSize - 2)),
        ),
        //현재 그래프별 멘트
        Padding(
          padding: $AnalyticsPageHorizontalPadding,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: ChartText().mapDataGradient(mapToMapOfFlSpot(
                  MapDataTimeRange().pickTimeRange(data, time, 20220830)))),
        ),
        const SizedBox(
          height: 37,
        ),
        Container(
          width: width,
          height: 270,
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(4),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: _LineChart(
                data: MapDataTimeRange().pickTimeRange(data, time, 20220830)),
          ),
        ),
      ],
    );
  }
}

class _LineChart extends StatelessWidget {
  final Map<String, dynamic> data;
  _LineChart({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //print(lineBarsData);
    return LineChart(
      lineChartDataMultiLine,
      swapAnimationDuration: const Duration(milliseconds: 400),
    );
  }

  LineChartData get lineChartDataMultiLine => LineChartData(
        lineTouchData: lineTouchData,
        gridData: gridData,
        titlesData: titlesData,
        borderData: borderData,

        //NOTE flSpotList comes
        lineBarsData: mapOfFlSpotToLineChartBarData(
            mapOfFlSpotXpointConverter(mapToMapOfFlSpot(data))),
      );

  LineTouchData get lineTouchData => LineTouchData(
        handleBuiltInTouches: true,
        getTouchedSpotIndicator:
            (LineChartBarData barData, List<int> spotIndexes) {
          return spotIndexes.map((spotIndex) {
            final spot = barData.spots[spotIndex];

            return TouchedSpotIndicatorData(
              FlLine(color: $$Grey, strokeWidth: 0.9),
              FlDotData(
                getDotPainter: (spot, percent, barData, index) {
                  return FlDotCirclePainter(
                      radius: 0.2,
                      //color: $$mainColor4,
                      color: barData.color,
                      strokeWidth: 5,
                      strokeColor: barData.color);
                },
              ),
            );
          }).toList();
        },
        touchTooltipData: LineTouchTooltipData(
            tooltipBgColor: $$lightGrey,
            getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
              return touchedBarSpots.map((barSpot) {
                final flSpot = barSpot;

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
                  const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    // TextSpan(
                    //   text: '$barSpot.title',
                    //   style: TextStyle(
                    //     color: $$Grey,
                    //     fontWeight: FontWeight.normal,
                    //   ),
                    // ),
                    // TextSpan(
                    //   text: '2022.08.',
                    //   style: TextStyle(
                    //     color: $$Grey,
                    //     fontWeight: FontWeight.normal,
                    //   ),
                    // ),
                    // TextSpan(
                    //   text: ChartText().dateBySubtractingXFromEndDate(
                    //       flSpot.x.toInt(), 20220830),
                    //   style: TextStyle(
                    //     color: $$Grey,
                    //     fontWeight: FontWeight.normal,
                    //   ),
                    // ),
                    TextSpan(
                      text: "Will Be Fixed",
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
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const TextSpan(
                      text: ' 원',
                      style: TextStyle(
                        //fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    // TextSpan(
                    //   text: (flSpot.y / 100).toInt().toString(),
                    //   style: TextStyle(
                    //     color: $$Grey,
                    //     fontWeight: FontWeight.normal,
                    //   ),
                    // ),
                    // TextSpan(
                    //   text: ' 건 ',
                    //   style: TextStyle(
                    //     //fontStyle: FontStyle.italic,
                    //     color: $$Grey,
                    //     fontWeight: FontWeight.normal,
                    //   ),
                    // ),
                  ],
                  textAlign: textAlign,
                );
              }).toList();
            }),
      );

  FlTitlesData get titlesData => FlTitlesData(
        bottomTitles: AxisTitles(),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(),
      );

  // Widget leftTitleWidgets(double value, TitleMeta meta) {
  //   const style = TextStyle(
  //     color: Color(0xff75729e),
  //     fontWeight: FontWeight.bold,
  //     fontSize: 14,
  //   );
  //   String text;
  //   switch (value.toInt()) {
  //     case 1:
  //       text = '1m';
  //       break;
  //     case 2:
  //       text = '2m';
  //       break;
  //     case 3:
  //       text = '3m';
  //       break;
  //     case 4:
  //       text = '5m';
  //       break;
  //     case 5:
  //       text = '6m';
  //       break;
  //     default:
  //       return Container();
  //   }

  //   return Text(text, style: style, textAlign: TextAlign.center);
  // }

  // SideTitles leftTitles() => SideTitles(
  //       getTitlesWidget: leftTitleWidgets,
  //       showTitles: true,
  //       interval: 1,
  //       reservedSize: 40,
  //     );

  // Widget bottomTitleWidgets(double value, TitleMeta meta) {
  //   const style = TextStyle(
  //     color: Color(0xff72719b),
  //     fontWeight: FontWeight.bold,
  //     fontSize: 16,
  //   );
  //   Widget text;
  //   switch (value.toInt()) {
  //     case 2:
  //       text = const Text('SEPT', style: style);
  //       break;
  //     case 7:
  //       text = const Text('OCT', style: style);
  //       break;
  //     case 12:
  //       text = const Text('DEC', style: style);
  //       break;
  //     default:
  //       text = const Text('');
  //       break;
  //   }

  //   return SideTitleWidget(
  //     axisSide: meta.axisSide,
  //     space: 10,
  //     child: text,
  //   );
  // }

  // SideTitles get bottomTitles => SideTitles(
  //       showTitles: true,
  //       reservedSize: 32,
  //       interval: 1,
  //       getTitlesWidget: bottomTitleWidgets,
  //     );

  FlGridData get gridData => FlGridData(show: false);

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(color: Colors.transparent),
          left: BorderSide(color: Colors.transparent),
          right: BorderSide(color: Colors.transparent),
          top: BorderSide(color: Colors.transparent),
        ),
      );
}
