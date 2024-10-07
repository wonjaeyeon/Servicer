import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../../../../../../../design_standards/colors.dart';
import '../../../../../../../../../../design_standards/text_styles.dart';

class TrendViewChartContainer extends StatefulWidget {
  const TrendViewChartContainer({super.key});

  @override
  State<TrendViewChartContainer> createState() =>
      _TrendViewChartContainerState();
}

class _TrendViewChartContainerState extends State<TrendViewChartContainer> {
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
            enableAxisAnimation: false,
            tooltipBehavior: _tooltipBehavior,
            series: <ChartSeries>[
              LineSeries<EarningsData, String>(
                  animationDuration: 0,
                  dataSource: getMaleChartData(),
                  xValueMapper: (EarningsData earnings, _) =>
                      earnings.earningsCategory,
                  yValueMapper: (EarningsData earnings, _) =>
                      earnings.sales,
                  color: Colors.blueAccent,
                  width: 2,
                  name: "남자"),
              LineSeries<EarningsData, String>(
                  animationDuration: 0,
                  dataSource: getFemaleChartData(),
                  xValueMapper: (EarningsData earnings, _) =>
                      earnings.earningsCategory,
                  yValueMapper: (EarningsData earnings, _) =>
                      earnings.sales,
                  color: Color.fromARGB(255, 255, 114, 161),
                  width: 2,
                  name: "여자"),
            ],
            primaryXAxis: CategoryAxis(
              labelStyle: const TextStyle(fontFamily: 'IBMPlexSansKR'),
            ),
            primaryYAxis: NumericAxis(
              labelFormat: '{value}원',
              opposedPosition: true,
              labelStyle: const TextStyle(fontFamily: 'IBMPlexSansKR'),
            ),
          ),
        ));
  }

  List<EarningsData> getMaleChartData() {
    List<EarningsData> chartData = [];
    if (true) {
      chartData = [
        EarningsData('12:00', 20000),
        EarningsData('13:00', 30000),
        EarningsData('14:00', 20000),
        EarningsData('15:00', 40000),
        EarningsData('16:00', 10000),
        EarningsData('17:00', 10000),
        EarningsData('18:00', 9000),
        EarningsData('19:00', 13000),
        EarningsData('20:00', 12000),
        EarningsData('21:00', 11000),
        EarningsData('22:00', 14000),
        EarningsData('23:00', 17000)
      ];
    }
    return chartData;
  }

  List<EarningsData> getFemaleChartData() {
    List<EarningsData> chartData = [];
    if (true) {
      chartData = [
        EarningsData('12:00', 30000),
        EarningsData('13:00', 50000),
        EarningsData('14:00', 40000),
        EarningsData('15:00', 50000),
        EarningsData('16:00', 40000),
        EarningsData('17:00', 50000),
        EarningsData('18:00', 40000),
        EarningsData('19:00', 50000),
        EarningsData('21:00', 50000),
        EarningsData('22:00', 60000),
        EarningsData('23:00', 30000)
      ];
    }
    return chartData;
  }
}

class EarningsData {
  EarningsData(this.earningsCategory, this.sales);
  final String earningsCategory;
  final int sales;
}
