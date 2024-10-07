import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../design_standards/colors.dart';
import '../return_chart.dart';
import '../sm_data_handler/sm_data_handler.dart';

class RPercentChart extends StatefulWidget {
  final TooltipBehavior tooltipBehavior;
  final List<EarningsData> data;
  const RPercentChart(
      {Key? key, required this.tooltipBehavior, required this.data})
      : super(key: key);

  @override
  State<RPercentChart> createState() => _RPercentChartState();
}

class _RPercentChartState extends State<RPercentChart> with SMDataHandler {
  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      tooltipBehavior: widget.tooltipBehavior,
      series: <ChartSeries>[
        StackedBarSeries<EarningsData, String>(
          isTrackVisible: true,
          animationDuration: 0,
          dataSource: widget.data,
          xValueMapper: (EarningsData earnings, _) => earnings.earningsCategory,
          yValueMapper: (EarningsData earnings, _) =>
              getPercent(earnings.sold, earnings.sold + earnings.unSold),
          color: Color.fromARGB(255, 2, 0, 117),
          borderRadius: BorderRadius.horizontal(
              left: Radius.circular(0), right: Radius.circular(10)),
          dataLabelSettings: DataLabelSettings(
            labelAlignment: ChartDataLabelAlignment.outer,
            offset: Offset(64, 0),
            showCumulativeValues: true,
            labelPosition: ChartDataLabelPosition.outside,
            isVisible: true,
            textStyle: const TextStyle(
                fontFamily: 'IBMPlexSansKR',
                color: Color.fromARGB(255, 2, 0, 117)),
          ),
          width: 0.4,
          name: "반품률",
        ),
      ],
      primaryXAxis: CategoryAxis(
        labelStyle: const TextStyle(fontFamily: 'IBMPlexSansKR'),
      ),
      primaryYAxis: NumericAxis(
        labelFormat: '{value}%',
        //make a labeFormat for percentage of sold and unsold
        // labelFormat: '{value}',
        minimum: 0,
        maximum: 100,
        // interval: 20,
        // majorGridLines: const MajorGridLines(width: 0),

        opposedPosition: true,
        labelStyle: const TextStyle(fontFamily: 'IBMPlexSansKR'),
      ),
    );
  }
}
