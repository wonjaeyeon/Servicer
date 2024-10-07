import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../../../../../../design_standards/colors.dart';
import '../../../../../../../../../../design_standards/text_styles.dart';

class RatioViewChartContainer extends StatefulWidget {
  const RatioViewChartContainer({super.key});

  @override
  State<RatioViewChartContainer> createState() =>
      _RatioViewChartContainerState();
}

class _RatioViewChartContainerState extends State<RatioViewChartContainer> {
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true, color: $$Grey, opacity: 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double _verticalPadding = 15;
    final double _horizontalPadding = 15;
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 0),
        child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 160,
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 0), //*그래프 컨테이너 바깥쪽 간격
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(0),
            ),
            child: SfCartesianChart(
              //get the number of maleOrder by using function getChartData
              //get the number of femaleOrder by using function getChartData
              // title: ChartTitle(
              //     text: getRatio(
              //         time, getChartData()[0], getChartData)),
              //"${getChartData(time)[0].maleOrder}:${getChartData(time)[0].femaleOrder}"),
              plotAreaBorderWidth: 0,
              tooltipBehavior: _tooltipBehavior,

              series: <ChartSeries>[
                StackedBar100Series<RatioChartData, String>(
                  animationDuration: 0,
                  dataSource: getChartData(),
                  xValueMapper: (RatioChartData earnings, _) =>
                      earnings.earningsCategory,
                  yValueMapper: (RatioChartData earnings, _) => earnings.profit,
                  color: Color(0xff5985B5),
                  borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(10), right: Radius.circular(0)),
                  dataLabelSettings: DataLabelSettings(
                    labelAlignment: ChartDataLabelAlignment.middle,
                    labelPosition: ChartDataLabelPosition.outside,
                    isVisible: getChartData()[0].profit == 0 ? false : true,
                    textStyle: const TextStyle(
                        fontFamily: 'IBMPlexSansKR', color: Colors.white),
                  ),
                  width: 0.4,
                  name: "매출",
                ),
                StackedBar100Series<RatioChartData, String>(
                  animationDuration: 0,
                  dataSource: getChartData(),
                  xValueMapper: (RatioChartData earnings, _) =>
                      earnings.earningsCategory,
                  yValueMapper: (RatioChartData earnings, _) =>
                      earnings.expense,
                  //color by hexcode
                  color: Color(0xFFCC7A91),
                  borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(0), right: Radius.circular(10)),
                  dataLabelSettings: DataLabelSettings(
                    labelAlignment: ChartDataLabelAlignment.middle,
                    isVisible: getChartData()[0].expense == 0 ? false : true,
                    textStyle: const TextStyle(
                        fontFamily: 'IBMPlexSansKR', color: Colors.white),
                  ),
                  width: 0.4,
                  name: "예상 매입",
                ),
              ],
              primaryXAxis: CategoryAxis(isVisible: false),
              primaryYAxis: NumericAxis(
                isVisible: false,
                labelFormat: '{value}%',
              ),
              borderColor: Colors.transparent,

              legend: Legend(
                  isVisible: true,
                  position: LegendPosition.bottom,
                  //make it height wit to fit the text
                  height: '60%',
                  overflowMode: LegendItemOverflowMode.wrap,
                  textStyle: const TextStyle(
                      fontFamily: 'IBMPlexSansKR',
                      color: Colors.black,
                      fontSize: 12),
                  // Templating the legend item
                  legendItemBuilder:
                      (String name, dynamic series, dynamic point, int index) {
                    return Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: _horizontalPadding),
                      child: Row(
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: '${name}' == '매출'
                                  ? Color(0xff5985B5)
                                  : Color(0xFFFCC7A91),
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text('${name}'),
                          Spacer(),
                          '${name}' == '매출'
                              ? Text('${getChartData()[0].profit}%')
                              : Text('${getChartData()[0].expense}%'),
                        ],
                      ),
                    );
                  }),
            )));
  }

  List<RatioChartData> getChartData() {
    List<RatioChartData> chartData = [];
    if (true) {
      chartData = [
        RatioChartData('매출비율', 79, 21),
      ];
    }
    return chartData;
  }
}

class RatioChartData {
  RatioChartData(this.earningsCategory, this.profit, this.expense);
  final String earningsCategory;
  final int profit;
  final int expense;
}
