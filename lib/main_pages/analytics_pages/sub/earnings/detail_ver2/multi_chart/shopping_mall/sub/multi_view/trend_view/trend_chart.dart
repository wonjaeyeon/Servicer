import 'package:flutter/material.dart';
import 'package:servicer/main_pages/analytics_pages/sub/earnings/detail/detail_report/multi_chart%20copy/shopping_mall/sub/multi_view/_multi_view_chart_maker/legend_data_handler.dart';
import 'package:servicer/servicer_modules/shopping_mall_master.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../../../../../../../design_standards/colors.dart';
import '../../../../../../../../../../design_standards/text_styles.dart';
import '../_multi_view_chart_maker/m_data_handler/name_switch_for_icon.dart';

class TrendViewChartContainer extends StatefulWidget {
  const TrendViewChartContainer({super.key});

  @override
  State<TrendViewChartContainer> createState() =>
      _TrendViewChartContainerState();
}

class _TrendViewChartContainerState extends State<TrendViewChartContainer>
    with LegendDataHandler, IconSwitcher {
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
                animationDuration: 0,
                dataSource: getChartData(),
                xValueMapper: (CostChartData earnings, _) =>
                    earnings.mallCategory,
                yValueMapper: (CostChartData earnings, _) =>
                    earnings.earningsCost,
                pointColorMapper: (CostChartData earnings, _) => earnings.color,
                sortingOrder: SortingOrder.descending,
                sortFieldValueMapper: (CostChartData earnings, _) =>
                    earnings.earningsCost,

                borderRadius: BorderRadius.vertical(
                    top: Radius.circular(2), bottom: Radius.circular(0)),
                dataLabelSettings: DataLabelSettings(
                  labelAlignment: ChartDataLabelAlignment.outer,
                  //offset: Offset(0, -6),
                  isVisible: true,
                  textStyle: const TextStyle(
                      fontFamily: 'IBMPlexSansKR',
                      color: Color.fromARGB(255, 0, 0, 0)),
                  // builder: (data, point, series, pointIndex, seriesIndex) {
                  //   return Container(
                  //       transform: Matrix4.translationValues(10, 8, 10),
                  //       height: 50,
                  //       width: 50,
                  //       child: Row(children: <Widget>[
                  //         SizedBox(
                  //           height: 15,
                  //           child: iconSwitcher('${data.mallCategory}'),
                  //         ),
                  //         SizedBox(
                  //           height: 15,
                  //           child: Text(
                  //             data.earningsCost.toString() + '%',
                  //             style: const TextStyle(
                  //               fontSize: 10,
                  //             ),
                  //           ),
                  //         )
                  //       ]));
                  // },
                ),
                width: 0.4,
                legendIconType: LegendIconType.seriesType,

                //name: '${EarningsData.earningsCategory}',
              ),
            ],
            primaryXAxis: CategoryAxis(
              isVisible: true,
              labelStyle: const TextStyle(fontFamily: 'IBMPlexSansKR'),
              axisLabelFormatter: (axisLabelRenderArgs) {
                return ChartAxisLabel(
                    axisLabelRenderArgs.text,
                    axisLabelRenderArgs.textStyle
                        .copyWith(color: Color.fromARGB(255, 0, 0, 0)));
              },
            ),
            primaryYAxis: NumericAxis(
              isVisible: true,
              opposedPosition: true,
              labelFormat: '{value}%',
              labelStyle: const TextStyle(fontFamily: 'IBMPlexSansKR'),
            ),
            // legend: Legend(
            //   isVisible: true,
            //   height: '250%',
            //   position: LegendPosition.bottom,
            //   overflowMode: LegendItemOverflowMode.wrap,
            //   textStyle: const TextStyle(
            //       fontFamily: 'IBMPlexSansKR', color: Colors.black),
            //   // legendItemBuilder:
            //   //     (String name, dynamic series, dynamic point, int index) {
            //   //   return Padding(
            //   //     padding: EdgeInsets.symmetric(horizontal: _horizontalPadding),
            //   //     child: Row(
            //   //       children: [
            //   //         Container(
            //   //           width: 10,
            //   //           height: 10,
            //   //           decoration: BoxDecoration(
            //   //             color: series.color,
            //   //             borderRadius: BorderRadius.circular(3),
            //   //           ),
            //   //         ),
            //   //         const SizedBox(width: 5),
            //   //         // Text('${name}'),
            //   //         // Text('${point}'),
            //   //         // make Text of series's mallCategory
            //   //         // Text('${name}'),
            //   //         // Text('${series.animationDuration}'),
            //   //         // Text('${series.dataSource[index].mallCategory}'),

            //   //         // Spacer(),
            //   //         // Text('${series.dataSource[index].earningsCost}'),
            //   //         // Text('${legendValueSelector(name, getChartData)}%')
            //   //       ],
            //   //     ),
            //   //   );
            //   // }),
            //   borderColor: Colors.transparent,
            // ),
          ),
        ));
  }

  List<CostChartData> getChartData() {
    List<CostChartData> chartData = [];

    chartData = [
      CostChartData(
          '스마트스토어', 20, mallMaster.themeColorOf(Mall.NaverSmartStore)),
      CostChartData('지그재그', 10, mallMaster.themeColorOf(Mall.Zigzag)),
      CostChartData('에이블리', 7.3, mallMaster.themeColorOf(Mall.Ably)),
      CostChartData('쿠팡', -10, mallMaster.themeColorOf(Mall.Coupang)),
    ];

    return chartData;
  }
}

class CostChartData {
  CostChartData(this.mallCategory, this.earningsCost, this.color);
  final String? mallCategory;
  final num? earningsCost;
  final Color? color;
}
