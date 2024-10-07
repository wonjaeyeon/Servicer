import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../design_standards/colors.dart';
import '../return_chart.dart';

class RCountChart extends StatefulWidget {
  final TooltipBehavior tooltipBehavior;
  final List<EarningsData> data;
  const RCountChart(
      {Key? key, required this.tooltipBehavior, required this.data})
      : super(key: key);

  @override
  State<RCountChart> createState() => _RCountChartState();
}

class _RCountChartState extends State<RCountChart> {
  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      tooltipBehavior: widget.tooltipBehavior,
      series: <ChartSeries>[
        StackedBarSeries<EarningsData, String>(
          animationDuration: 0,
          dataSource: widget.data,
          xValueMapper: (EarningsData earnings, _) => earnings.earningsCategory,
          yValueMapper: (EarningsData earnings, _) => earnings.sold,
          color: Color.fromARGB(255, 2, 0, 117),
          borderRadius: BorderRadius.horizontal(
              left: Radius.circular(0), right: Radius.circular(0)),
          dataLabelSettings: DataLabelSettings(
            labelAlignment: ChartDataLabelAlignment.outer,
            offset: Offset(32, 0),
            showCumulativeValues: true,
            labelPosition: ChartDataLabelPosition.outside,
            isVisible: true,
            textStyle: const TextStyle(
                fontFamily: 'IBMPlexSansKR',
                color: Color.fromARGB(255, 2, 0, 117)),
          ),
          width: 0.4,
          name: "반품건수",
        ),
        StackedBarSeries<EarningsData, String>(
          animationDuration: 0,
          dataSource: widget.data,
          xValueMapper: (EarningsData earnings, _) => earnings.earningsCategory,
          yValueMapper: (EarningsData earnings, _) => earnings.unSold,
          color: $$mediumGrey,
          borderRadius: BorderRadius.horizontal(
              left: Radius.circular(0), right: Radius.circular(10)),
          dataLabelSettings: DataLabelSettings(
            labelAlignment: ChartDataLabelAlignment.outer,
            offset: Offset(42, 0),
            showCumulativeValues: true,
            isVisible: true,
            textStyle: const TextStyle(
                fontFamily: 'IBMPlexSansKR', color: Colors.black),
          ),
          width: 0.4,
          name: "판매완료건수",
        ),
      ],
      primaryXAxis: CategoryAxis(
        labelStyle: const TextStyle(fontFamily: 'IBMPlexSansKR'),
      ),
      primaryYAxis: NumericAxis(
        labelFormat: '{value}건',
        //make a labeFormat for percentage of sold and unsold
        // labelFormat: '{value}',
        // minimum: 0,
        // maximum: 100,
        // interval: 20,
        // majorGridLines: const MajorGridLines(width: 0),

        opposedPosition: true,
        labelStyle: const TextStyle(fontFamily: 'IBMPlexSansKR'),
      ),
    );
  }
}
