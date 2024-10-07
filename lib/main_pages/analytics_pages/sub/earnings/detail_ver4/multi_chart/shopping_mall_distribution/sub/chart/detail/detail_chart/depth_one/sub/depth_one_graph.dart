import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


import '../../../../../../../../../../../../../design_standards/colors.dart';
import '../../../../../../../../../../../../../design_standards/text_styles.dart';
import '../../../../../../../../../../../../../design_standards/widget_styles.dart';
import 'depth_one_analysis.dart';

class D1GraphContainer extends StatefulWidget {
  const D1GraphContainer({super.key});

  @override
  State<D1GraphContainer> createState() => _D1GraphContainerState();
}

class _D1GraphContainerState extends State<D1GraphContainer> {
//late List<ExpenseData> _chartData;
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
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(0),
            ),
            child: ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  // 현재 그래프 타이틀
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: _horizontalPadding),
                    child: Text(
                      "해당 매출군 성별 분석",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: $mediumFontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // const SizedBox(
                  //   height: 4,
                  // ),
                  // //현재 그래프 기간
                  // Padding(
                  //   padding: $AnalyticsPageHorizontalPadding,
                  //   child: Text("2022.01.01 ~ 2022.12.31",
                  //       style: TextStyle(fontSize: $mediumFontSize - 2)),
                  // ),
                  const SizedBox(
                    height: 10,
                  ),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Padding(
                        padding: $AnalyticsPageHorizontalPadding,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              child: Transform.scale(
                                  scale: 1.6,
                                  child: Icon(
                                    Icons.man,
                                    color: Colors.blue,
                                  )),
                              width: 45,
                              height: 45,
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            Text(
                              "남성 소비자가 전체의 46% 차지합니다.",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        )),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SfCartesianChart(
                    legend: Legend(
                        isVisible: true, position: LegendPosition.bottom),
                    tooltipBehavior: _tooltipBehavior,
                    series: <ChartSeries>[
                      StackedColumnSeries<ExpenseData, String>(
                          dataSource: getChartData(),
                          xValueMapper: (ExpenseData exp, _) =>
                              exp.expenseCategory,
                          yValueMapper: (ExpenseData exp, _) => exp.man,
                          name: '남자',
                          color: Colors.blueAccent),
                      StackedColumnSeries<ExpenseData, String>(
                          dataSource: getChartData(),
                          xValueMapper: (ExpenseData exp, _) =>
                              exp.expenseCategory,
                          yValueMapper: (ExpenseData exp, _) => exp.woman,
                          name: '여자',
                          color: Color.fromARGB(255, 255, 114, 161)),
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
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    alignment: Alignment.topCenter,
                    child: D1ChartAnalysisContainer(),
                  ),
                ])));
  }

  List<ExpenseData> getChartData() {
    List<ExpenseData> chartData = [];
    if (false) {
      chartData = [
        ExpenseData('12:00', 35, 28),
        ExpenseData('13:00', 28, 34),
        ExpenseData('14:00', 34, 30),
        ExpenseData('15:00', 30, 32),
        ExpenseData('16:00', 32, 35),
        ExpenseData('17:00', 35, 40),
        ExpenseData('18:00', 40, 32),
        ExpenseData('19:00', 32, 35),
        ExpenseData('20:00', 35, 30),
        ExpenseData('21:00', 30, 32),
        ExpenseData('22:00', 32, 28),
        ExpenseData('23:00', 28, 34),
      ];
    } else {
      chartData = [
        ExpenseData('1/7', 35000, 28000),
        ExpenseData('1/8', 28000, 34000),
        ExpenseData('1/9', 34000, 30000),
        ExpenseData('1/10', 30000, 32000),
        ExpenseData('1/11', 32000, 35000),
        ExpenseData('1/12', 35000, 40000),
        ExpenseData('1/13', 40000, 32000),
        ExpenseData('1/14', 35000, 40000),
        ExpenseData('1/15', 40000, 32000),
      ];
    }

    return chartData;
  }
}

class ExpenseData {
  ExpenseData(this.expenseCategory, this.man, this.woman);
  final String expenseCategory;
  final num man;
  final num woman;
}
