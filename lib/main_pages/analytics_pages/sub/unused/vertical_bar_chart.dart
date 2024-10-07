import 'package:flutter/material.dart';
import 'package:servicer/MOD_PACKAGES/fl_chart_svc/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:servicer/design_standards/colors.dart';
import 'package:servicer/data_handler/mapData_handler/bar_chart/vertical_bar_chart_data.dart';

import '../../../../design_standards/text_styles.dart';
import '../../../../design_standards/widget_styles.dart';

class VerticalBarChartContainer extends StatelessWidget {
  final Color color;
  final String title;
  final Widget chart;

  const VerticalBarChartContainer({
    Key? key,
    required this.title,
    required this.color,
    required this.chart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _verticalPadding = 15;
    final double _horizontalPadding = 15;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: _horizontalPadding),
      child: Container(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: <Widget>[
              const SizedBox(
                height: 12,
              ),
              Padding(
                padding: $AnalyticsPageHorizontalPadding,
                child: Text(
                  title,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: $mediumFontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 30)),
              Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 100,
                        child: VerticalBarChartContent(),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  height: 4,
                  width: double.maxFinite,
                  color: $$lightGrey,
                ),
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 6)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  '-단위 : (원) | 3월 3일 기준 환율 적용',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: $$mediumGrey,
                    fontSize: $mediumFontSize - 6,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
////////////////////////////////////////////////////////////////////////////////////////////////////////

class VerticalBarChartContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.center,
        //maxY: 1200,
        //minY: -20,
        groupsSpace: MediaQuery.of(context).size.width * 0.065,
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
              sideTitles: SideTitles(
            reservedSize: 30,
            showTitles: true,
            getTitlesWidget: getTitles,
          )),
        ),
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false),
        barGroups: barChartGroupData,
        barTouchData: BarTouchData(
          enabled: false,
          touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.transparent,
            tooltipPadding: const EdgeInsets.all(0),
            tooltipMargin: 2,
            getTooltipItem: getTooltipItem,
          ),
        ),
      ),
    );
  }
}

Widget getTitles(double value, TitleMeta meta) {
  Widget text;
  switch (value.toInt()) {
    case 0:
      text = Text('\n2018');
      break;
    case 1:
      text = Text('2019');
      break;
    case 2:
      text = Text('2020');
      break;
    case 3:
      text = Text('2021');
      break;
    case 4:
      text = Text('2022');
      break;
    case 5:
      text = Text('2023');
      break;
    case 6:
      text = Text('2024');
      break;
    default:
      text = Text('');
      break;
  }
  return Column(
    children: [
      SizedBox(
        height: 6,
      ),
      text,
    ],
  );
}

BarTooltipItem getTooltipItem(
  BarChartGroupData group,
  int groupIndex,
  BarChartRodData rod,
  int rodIndex,
) {
  return BarTooltipItem(
    groupIndex != 4
        ? rod.toY.round().toString()
        : "추정\n" + rod.toY.round().toString(),
    TextStyle(
      color: groupIndex != 4 ? Colors.black : $$Grey,
      //fontWeight: FontWeight.bold,
    ),
  );
}
