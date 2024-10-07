import 'package:flutter/material.dart';
import 'package:servicer/main_pages/analytics_pages/sub/earnings/composition/multi_chart/shopping_mall/sub/multi_view/_multi_view_chart_maker/m_data_handler/legend_data_handler.dart';
import 'package:servicer/servicer_modules/shopping_mall_master.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../../../../../../../design_standards/colors.dart';
import '../../../../../../../../../../../design_standards/text_styles.dart';

class RatioViewChartContainer extends StatefulWidget {
  const RatioViewChartContainer({super.key});

  @override
  State<RatioViewChartContainer> createState() =>
      _RatioViewChartContainerState();
}

class _RatioViewChartContainerState extends State<RatioViewChartContainer>
    with LegendDataHandler {
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
            height: 220,
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 0), //*그래프 컨테이너 바깥쪽 간격
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(0),
            ),
            child: SfCartesianChart(
              plotAreaBorderWidth: 0,
              tooltipBehavior: _tooltipBehavior,
              series: <ChartSeries>[
                StackedBar100Series<RatioChartData, String>(
                  animationDuration: 0,
                  dataSource: getChartData(),
                  xValueMapper: (RatioChartData earnings, _) =>
                      earnings.earningsCategory,
                  yValueMapper: (RatioChartData earnings, _) =>
                      earnings.naverSmartStore,
                  color: mallMaster
                      .themeColorOf(Mall.NaverSmartStore)
                      .withOpacity(0.8),
                  borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(10), right: Radius.circular(0)),
                  dataLabelSettings: DataLabelSettings(
                    labelAlignment: ChartDataLabelAlignment.middle,
                    labelPosition: ChartDataLabelPosition.outside,
                    isVisible:
                        getChartData()[0].naverSmartStore == 0 ? false : true,
                    textStyle: const TextStyle(
                        fontFamily: 'IBMPlexSansKR', color: Colors.white),
                  ),
                  width: 0.4,
                  name: "스마트스토어",
                ),
                StackedBar100Series<RatioChartData, String>(
                  animationDuration: 0,
                  dataSource: getChartData(),
                  xValueMapper: (RatioChartData earnings, _) =>
                      earnings.earningsCategory,
                  yValueMapper: (RatioChartData earnings, _) => earnings.zigzag,
                  //color by hexcode
                  color: mallMaster.themeColorOf(Mall.Zigzag).withOpacity(0.8),
                  borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(0), right: Radius.circular(0)),
                  dataLabelSettings: DataLabelSettings(
                    labelAlignment: ChartDataLabelAlignment.middle,
                    isVisible: getChartData()[0].zigzag == 0 ? false : true,
                    textStyle: const TextStyle(
                        fontFamily: 'IBMPlexSansKR', color: Colors.white),
                  ),
                  width: 0.4,
                  name: "지그재그",
                ),
                StackedBar100Series<RatioChartData, String>(
                  animationDuration: 0,
                  dataSource: getChartData(),
                  xValueMapper: (RatioChartData earnings, _) =>
                      earnings.earningsCategory,
                  yValueMapper: (RatioChartData earnings, _) => earnings.ably,
                  //color by hexcode
                  color: mallMaster.themeColorOf(Mall.Ably).withOpacity(0.8),
                  borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(0), right: Radius.circular(0)),
                  dataLabelSettings: DataLabelSettings(
                    labelAlignment: ChartDataLabelAlignment.middle,
                    isVisible: getChartData()[0].ably == 0 ? false : true,
                    textStyle: const TextStyle(
                        fontFamily: 'IBMPlexSansKR', color: Colors.white),
                  ),
                  width: 0.4,
                  name: "에이블리",
                ),
                StackedBar100Series<RatioChartData, String>(
                  animationDuration: 0,
                  dataSource: getChartData(),
                  xValueMapper: (RatioChartData earnings, _) =>
                      earnings.earningsCategory,
                  yValueMapper: (RatioChartData earnings, _) => earnings.zigzag,
                  //color by hexcode
                  color: mallMaster.themeColorOf(Mall.Coupang).withOpacity(0.8),
                  borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(0), right: Radius.circular(10)),
                  dataLabelSettings: DataLabelSettings(
                    labelAlignment: ChartDataLabelAlignment.middle,
                    isVisible: getChartData()[0].coupang == 0 ? false : true,
                    textStyle: const TextStyle(
                        fontFamily: 'IBMPlexSansKR', color: Colors.white),
                  ),
                  width: 0.4,
                  name: "쿠팡",
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
                  height: '90%',
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
                              color: series.color,
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text('${name}'),
                          Spacer(),
                          Text('${legendValueSelector(name, getChartData)}%')
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
        RatioChartData(
            '매출비율',
            (167 / 467 * 100).toInt() + 2,
            (100 / 467 * 100).toInt(),
            (100 / 467 * 100).toInt(),
            (100 / 467 * 100).toInt()),
      ];
    }
    return chartData;
  }
}

class RatioChartData {
  RatioChartData(this.earningsCategory, this.naverSmartStore, this.zigzag,
      this.ably, this.coupang);
  final String earningsCategory;
  final int naverSmartStore;
  final int zigzag;
  final int ably;
  final int coupang;
}
