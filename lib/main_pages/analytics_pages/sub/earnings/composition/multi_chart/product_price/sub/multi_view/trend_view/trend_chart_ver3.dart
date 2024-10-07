import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../../../../../../../design_standards/colors.dart';
import '../../../../../../../../../../design_standards/text_styles.dart';

class TrendViewChartContainerV3 extends StatefulWidget {
  const TrendViewChartContainerV3({super.key});

  @override
  State<TrendViewChartContainerV3> createState() =>
      _TrendViewChartContainerV3State();
}

class _TrendViewChartContainerV3State extends State<TrendViewChartContainerV3> {
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
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("가격 13000~53000원 상품 매출",
                    style: TextStyle(
                        color: Colors.black, fontFamily: 'IBMPlexSansKR')),
              ),
            ),
            Container(
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
                      color: Colors.orange,
                      width: 2,
                      name: "남자"),
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
            ),
          ],
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
        EarningsData('16:00', 18000),
        EarningsData('17:00', 13000),
        EarningsData('18:00', 40000),
        EarningsData('19:00', 13000),
        EarningsData('20:00', 13000),
        EarningsData('21:00', 13000),
        EarningsData('22:00', 14000),
        EarningsData('23:00', 17000)
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
