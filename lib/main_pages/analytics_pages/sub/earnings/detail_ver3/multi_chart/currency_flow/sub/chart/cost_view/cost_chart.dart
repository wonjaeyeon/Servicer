import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../../../../../../../design_standards/colors.dart';
import '../../../../../../../../../../design_standards/text_styles.dart';

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
          //height: 120,
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
                    earnings.earningsCategory,
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
      CostChartData('발생 매출', 256000, Color(0xff5985B5)),
      CostChartData('매출 변제', 50000, Color(0xFFCC7A91)),
    ];

    return chartData;
  }
}

class CostChartData {
  CostChartData(this.earningsCategory, this.earningsCost, this.color);
  final String earningsCategory;
  final int earningsCost;
  final Color? color;
}
