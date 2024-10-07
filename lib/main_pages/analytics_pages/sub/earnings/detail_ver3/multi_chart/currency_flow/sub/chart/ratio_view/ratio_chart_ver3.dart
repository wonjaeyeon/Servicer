import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
//import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../../../../../../data_handler/data_standards/time.dart';
import '../../../../../../../../../../design_standards/colors.dart';
import '../../../../../../../../../../design_standards/text_styles.dart';

class RatioViewChartContainerV3 extends StatefulWidget {
  const RatioViewChartContainerV3({super.key});

  @override
  State<RatioViewChartContainerV3> createState() =>
      _RatioViewChartContainerV3State();
}

class _RatioViewChartContainerV3State extends State<RatioViewChartContainerV3> {
  late TooltipBehavior _tooltipBehavior;
  late Time time;
  @override
  void initState() {
    time = Time.day;
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
          height: 260,
          margin: const EdgeInsets.fromLTRB(0, 0, 0, 0), //*그래프 컨테이너 바깥쪽 간격
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(0),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("실제매출 비율", style: TextStyle(fontSize: $smallFontSize)),
                  Text("71.11%", style: TextStyle(fontSize: $smallFontSize)),
                  Text("7:9", style: TextStyle(fontSize: $smallFontSize)),
                ],
              ),
              Container(
                width: 800,
                height: 800,
                child: SfCircularChart(
                  tooltipBehavior: _tooltipBehavior,
                  series: <CircularSeries>[
                    DoughnutSeries<EarningsData, String>(
                      animationDuration: 0,
                      dataSource: getChartData(time),
                      xValueMapper: (EarningsData earnings, _) =>
                          earnings.earningsCategory,
                      yValueMapper: (EarningsData earnings, _) =>
                          earnings.salesRate,
                      pointColorMapper: (EarningsData earnings, _) =>
                          earnings.color,
                      innerRadius: '80%',
                      startAngle: 210,
                      endAngle: 150,
                      cornerStyle: CornerStyle.bothCurve,
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  List<EarningsData> getChartData(Time time) {
    List<EarningsData> chartData = [];
    chartData = [
      EarningsData('sold', 6, Color.fromARGB(255, 78, 168, 186)),
      EarningsData('unsold', 3, $$lightGrey),
    ];
    return chartData;
  }
}

class EarningsData {
  EarningsData(this.earningsCategory, this.salesRate, this.color);
  final String earningsCategory;
  final int salesRate;
  final Color color;
}
