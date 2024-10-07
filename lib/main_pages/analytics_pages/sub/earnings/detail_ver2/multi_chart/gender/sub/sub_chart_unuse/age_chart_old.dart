import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../../../../../design_standards/colors.dart';
import '../../../../../../../../../design_standards/text_styles.dart';

class AgeChartContainer extends StatefulWidget {
  const AgeChartContainer({super.key});

  @override
  State<AgeChartContainer> createState() => _AgeChartContainerState();
}

class _AgeChartContainerState extends State<AgeChartContainer> {
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true, color: $$Grey, opacity: 1);
    super.initState();
  }

  bool toggle = false;
  // AnimatedOpacity를 위한 변수
  bool _visible = true;
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Text(
          '연령',
          style: TextStyle(
              fontSize: $smallFontSize,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
      ),
      AnimatedOpacity(
        opacity: _visible ? 1.0 : 0.0,
        duration: _visible
            ? const Duration(milliseconds: 400)
            : const Duration(milliseconds: 0),
        onEnd: () async => {
          await Future.delayed(const Duration(milliseconds: 400)),
          setState(() {
            _visible = true;
          })
        },
        child: SizedBox(
          height: 150,
          width: MediaQuery.of(context).size.width * 0.5,
          child: SfCartesianChart(
            //plotAreaBorderWidth: 0,
            tooltipBehavior: _tooltipBehavior,
            series: <ChartSeries>[
              ColumnSeries<EarningsData, String>(
                animationDuration: 0,
                dataSource: getChartData(),
                xValueMapper: (EarningsData earnings, _) =>
                    earnings.genderCategory,
                yValueMapper: (EarningsData earnings, _) => earnings.ageOrder,
                color: Colors.greenAccent[200],
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
              labelFormat: '{value}건',
              labelStyle: const TextStyle(fontFamily: 'IBMPlexSansKR'),
            ),
            borderColor: Colors.transparent,
          ),
        ),
      ),
    ]);
  }

  List<EarningsData> getChartData() {
    List<EarningsData> chartData = [];
    if (true) {
      chartData = [
        EarningsData('~20', 16),
        EarningsData('20~30', 20),
        EarningsData('30~40', 15),
        EarningsData('40~50', 10),
        EarningsData('50~60', 8),
        EarningsData('60~', 7),
      ];
    }
    return chartData;
  }
}

class EarningsData {
  EarningsData(this.genderCategory, this.ageOrder);
  final String genderCategory;
  final int ageOrder;
}
