import 'package:flutter/material.dart';
//import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../../../../../../design_standards/colors.dart';
import '../../../../../../../../../../design_standards/text_styles.dart';

/// Gauge imports
import 'package:syncfusion_flutter_gauges/gauges.dart';

class RatioViewChartContainerV2 extends StatefulWidget {
  const RatioViewChartContainerV2({super.key});

  @override
  State<RatioViewChartContainerV2> createState() =>
      _RatioViewChartContainerV2State();
}

class _RatioViewChartContainerV2State extends State<RatioViewChartContainerV2> {
  @override
  void initState() {
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
            height: 160,
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 0), //*그래프 컨테이너 바깥쪽 간격
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(0),
            ),
            child: SfRadialGauge(
              axes: <RadialAxis>[
                RadialAxis(
                    showLabels: false,
                    showTicks: false,
                    startAngle: 115,
                    endAngle: 420,
                    radiusFactor: 0.8,
                    axisLineStyle: const AxisLineStyle(
                        thicknessUnit: GaugeSizeUnit.factor, thickness: 0.15),
                    annotations: <GaugeAnnotation>[
                      GaugeAnnotation(
                          angle: 180,
                          widget: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                '70',
                                style: TextStyle(
                                    fontFamily: 'Times',
                                    fontSize: 22,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.italic),
                              ),
                              Text(
                                ' / 100',
                                style: TextStyle(
                                    fontFamily: 'Times',
                                    fontSize: 22,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.italic),
                              ),
                            ],
                          )),
                    ],
                    pointers: <GaugePointer>[
                      RangePointer(
                          value: 50,
                          cornerStyle: CornerStyle.bothCurve,
                          enableAnimation: true,
                          animationDuration: 1200,
                          sizeUnit: GaugeSizeUnit.factor,
                          gradient: SweepGradient(colors: <Color>[
                            Color(0xff5985B5),
                            Color.fromARGB(255, 136, 181, 228)
                          ], stops: <double>[
                            0.25,
                            0.75
                          ]),
                          color: Color(0xFF00A8B5),
                          width: 0.15),
                    ]),
              ],
            )));
  }

  List<RatioChartData> getChartData() {
    List<RatioChartData> chartData = [];
    if (true) {
      chartData = [
        RatioChartData('매출비율', 79, 21),
      ];
    }
    return chartData;
  }
}

class RatioChartData {
  RatioChartData(this.earningsCategory, this.profit, this.expense);
  final String earningsCategory;
  final int profit;
  final int expense;
}
