import 'package:flutter/material.dart';
import 'package:servicer/main_pages/analytics_pages/sub/earnings/detail/detail_report/multi_chart%20copy/shopping_mall/sub/multi_view/_multi_view_chart_maker/legend_data_handler.dart';
import 'package:servicer/servicer_modules/shopping_mall_master.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../../../../../../../design_standards/colors.dart';
import '../../../../../../../../../../design_standards/text_styles.dart';

class TrendViewChartContainer extends StatefulWidget {
  const TrendViewChartContainer({super.key});

  @override
  State<TrendViewChartContainer> createState() =>
      _TrendViewChartContainerState();
}

class _TrendViewChartContainerState extends State<TrendViewChartContainer>
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
        height: 400,

        margin: const EdgeInsets.fromLTRB(0, 0, 0, 0), //*그래프 컨테이너 바깥쪽 간격
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(0),
        ),
        child: SfCartesianChart(
          //plotAreaBorderWidth: 0,
          tooltipBehavior: _tooltipBehavior,
          series: <ChartSeries>[
            ColumnSeries<CostChartData, String>(
              name: "스마트스토어",
              color: mallMaster
                  .themeColorOf(Mall.NaverSmartStore)
                  .withOpacity(0.5),
              animationDuration: 0,
              dataSource: [
                CostChartData('스마트스토어', 160,
                    mallMaster.themeColorOf(Mall.NaverSmartStore)),
              ],
              xValueMapper: (CostChartData earnings, _) =>
                  earnings.mallCategory,
              yValueMapper: (CostChartData earnings, _) =>
                  earnings.earningsCost,
              pointColorMapper: (CostChartData earnings, _) => earnings.color,
              borderRadius: BorderRadius.vertical(
                  top: Radius.circular(2), bottom: Radius.circular(0)),
              dataLabelSettings: DataLabelSettings(
                labelAlignment: ChartDataLabelAlignment.top,
                offset: Offset(0, 30),
                isVisible: true,
                textStyle: const TextStyle(
                    fontFamily: 'IBMPlexSansKR',
                    color: Color.fromARGB(255, 0, 0, 0)),
              ),
              //width: 0.4,
              //legendIconType: LegendIconType.seriesType,

              //name: '${EarningsData.earningsCategory}',
            ),
            ColumnSeries<CostChartData, String>(
              name: "지그재그",
              color: mallMaster.themeColorOf(Mall.Zigzag).withOpacity(0.5),
              animationDuration: 0,
              dataSource: [
                CostChartData(
                    '지그재그', 100, mallMaster.themeColorOf(Mall.Zigzag)),
              ],
              xValueMapper: (CostChartData earnings, _) =>
                  earnings.mallCategory,
              yValueMapper: (CostChartData earnings, _) =>
                  earnings.earningsCost,
              pointColorMapper: (CostChartData earnings, _) => earnings.color,
              borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(2), bottom: Radius.circular(0)),
              dataLabelSettings: const DataLabelSettings(
                labelAlignment: ChartDataLabelAlignment.top,
                offset: Offset(0, 30),
                isVisible: true,
                textStyle: TextStyle(
                    fontFamily: 'IBMPlexSansKR',
                    color: Color.fromARGB(255, 0, 0, 0)),
              ),
              //width: 1,
              //legendIconType: LegendIconType.seriesType,
              //name: '${EarningsData.earningsCategory}',
            ),
            ColumnSeries<CostChartData, String>(
              name: "에이블리",
              color: mallMaster.themeColorOf(Mall.Ably).withOpacity(0.5),

              animationDuration: 0,
              dataSource: [
                CostChartData('에이블리', 100, mallMaster.themeColorOf(Mall.Ably)),
              ],
              xValueMapper: (CostChartData earnings, _) =>
                  earnings.mallCategory,
              yValueMapper: (CostChartData earnings, _) =>
                  earnings.earningsCost,
              pointColorMapper: (CostChartData earnings, _) => earnings.color,
              borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(2), bottom: Radius.circular(0)),
              dataLabelSettings: const DataLabelSettings(
                labelAlignment: ChartDataLabelAlignment.top,
                offset: Offset(0, 30),
                isVisible: true,
                textStyle: TextStyle(
                    fontFamily: 'IBMPlexSansKR',
                    color: Color.fromARGB(255, 0, 0, 0)),
              ),
              //width: 0.4,
              //legendIconType: LegendIconType.seriesType,
              //name: '${EarningsData.earningsCategory}',
            ),
            ColumnSeries<CostChartData, String>(
              name: "쿠팡",
              color: mallMaster.themeColorOf(Mall.Coupang).withOpacity(0.5),

              animationDuration: 0,
              dataSource: [
                CostChartData('쿠팡', -30, mallMaster.themeColorOf(Mall.Coupang)),
              ],
              xValueMapper: (CostChartData earnings, _) =>
                  earnings.mallCategory,
              yValueMapper: (CostChartData earnings, _) =>
                  earnings.earningsCost,
              pointColorMapper: (CostChartData earnings, _) => earnings.color,
              borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(2), bottom: Radius.circular(0)),
              dataLabelSettings: const DataLabelSettings(
                labelAlignment: ChartDataLabelAlignment.top,
                offset: Offset(0, 30),
                isVisible: true,
                textStyle: TextStyle(
                    fontFamily: 'IBMPlexSansKR',
                    color: Color.fromARGB(255, 0, 0, 0)),
              ),
              //width: 0.4,
              //legendIconType: LegendIconType.seriesType,
              //name: '${EarningsData.earningsCategory}',
            ),
          ],
          primaryXAxis: CategoryAxis(
              isVisible: true, labelAlignment: LabelAlignment.center),
          primaryYAxis: NumericAxis(
            isVisible: true,
            opposedPosition: true,
            labelFormat: '{value}%',
            labelStyle: const TextStyle(fontFamily: 'IBMPlexSansKR'),
          ),
          legend: Legend(
              isVisible: true,
              height: '250%',
              position: LegendPosition.bottom,
              overflowMode: LegendItemOverflowMode.wrap,
              textStyle: const TextStyle(
                  fontFamily: 'IBMPlexSansKR', color: Colors.black),
              legendItemBuilder:
                  (String name, dynamic series, dynamic point, int index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: _horizontalPadding),
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
                      // Text('${point}'),
                      // make Text of series's mallCategory
                      // Text('${name}'),
                      // Text('${series.animationDuration}'),
                      // Text('${series.dataSource[index].mallCategory}'),

                      // Spacer(),
                      // Text('${series.dataSource[index].earningsCost}'),
                      // Text('${legendValueSelector(name, getChartData)}%')
                    ],
                  ),
                );
              }),
          borderColor: Colors.transparent,
        ),
      ),
    );
  }

  List<CostChartData> getChartData() {
    List<CostChartData> chartData = [];

    chartData = [
      CostChartData(
          '스마트스토어', 160, mallMaster.themeColorOf(Mall.NaverSmartStore)),
      // CostChartData('지그재그', 100, mallMaster.themeColorOf(Mall.Zigzag)),
      // CostChartData('에이블리', 50, mallMaster.themeColorOf(Mall.Ably)),
      // CostChartData('쿠팡', -30, mallMaster.themeColorOf(Mall.Coupang)),
    ];

    return chartData;
  }
}

class CostChartData {
  CostChartData(this.mallCategory, this.earningsCost, this.color);
  final String? mallCategory;
  final int? earningsCost;
  final Color? color;
}
