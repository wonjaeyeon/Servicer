import 'package:flutter/material.dart';
import 'package:servicer/servicer_modules/shopping_mall_master.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../../../../../../../../design_standards/colors.dart';
import '../../../../../../../../../../../design_standards/text_styles.dart';

class CostViewChartContainer extends StatefulWidget {
  const CostViewChartContainer({super.key});

  @override
  State<CostViewChartContainer> createState() => _CostViewChartContainerState();
}

class _CostViewChartContainerState extends State<CostViewChartContainer> {
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
                width: 0.4,
                //name: '${EarningsData.earningsCategory}',
              ),
            ],
            primaryXAxis: CategoryAxis(isVisible: true),
            primaryYAxis: NumericAxis(
              isVisible: true,
              opposedPosition: true,
              labelFormat: '{value}원',
              labelStyle: const TextStyle(fontFamily: 'IBMPlexSansKR'),
            ),
            borderColor: Colors.transparent,
          ),
        ));
  }

  List<CostChartData> getChartData() {
    List<CostChartData> chartData = [];

    chartData = [
      CostChartData(
          '스마트스토어', 167000, mallMaster.themeColorOf(Mall.NaverSmartStore)),
      CostChartData('지그재그', 100000, mallMaster.themeColorOf(Mall.Zigzag)),
      CostChartData('에이블리', 100000, mallMaster.themeColorOf(Mall.Ably)),
      CostChartData('쿠팡', 100000, mallMaster.themeColorOf(Mall.Coupang)),
    ];

    return chartData;
  }
}

class CostChartData {
  CostChartData(this.mallCategory, this.earningsCost, this.color);
  final String mallCategory;
  final int earningsCost;
  final Color? color;
}
