import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:servicer/design_standards/colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../../../../../data_handler/data_standards/time.dart';

class RangeGraphSubChartContainer extends StatefulWidget {
  final double width;
  final Time time;
  const RangeGraphSubChartContainer(
      {Key? key, required this.time, required this.width})
      : super(key: key);

  @override
  State<RangeGraphSubChartContainer> createState() =>
      RangeGraphSubChartContainerState();
}

class RangeGraphSubChartContainerState
    extends State<RangeGraphSubChartContainer> {
  late TooltipBehavior _tooltipBehavior;
  final String unit = '원';

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true, color: $$Grey, opacity: 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: widget.width,
        child: SfCartesianChart(
          title: ChartTitle(text: '예상 수익 오차 범위 그래프'),
          plotAreaBorderWidth: 0,
          primaryXAxis: DateTimeAxis(
              dateFormat: DateFormat("MM/dd"),
              interval: 1,
              majorGridLines: const MajorGridLines(width: 0),
              edgeLabelPlacement: EdgeLabelPlacement.shift),
          primaryYAxis: NumericAxis(
              labelFormat: '{value}만원',
              axisLine: const AxisLine(width: 0),
              majorTickLines: const MajorTickLines(size: 0)),
          series: _getRangeAreaSeries(),
          tooltipBehavior: _tooltipBehavior,
        ));
  }

  /// Gets the random data for the Rnage area chart series.
  List<ChartSampleData> _getData() {
    List<ChartSampleData> chartData;
    chartData = <ChartSampleData>[];
    double value = 30;
    for (int i = 0; i < 100; i++) {
      final Random yValue = Random();
      (yValue.nextDouble() > .5)
          ? value += Random().nextDouble()
          : value -= Random().nextDouble();

      chartData.add(ChartSampleData(
          x: DateTime(2023, 2, 10, i), high: value, low: value + 10));
    }
    return chartData;
  }

  /// Returns the list of Chart series
  /// which need to render on the Range area chart.
  List<ChartSeries<ChartSampleData, DateTime>> _getRangeAreaSeries() {
    return <ChartSeries<ChartSampleData, DateTime>>[
      RangeAreaSeries<ChartSampleData, DateTime>(
        dataSource: _getData(),
        name: 'London',
        borderWidth: 2,
        opacity: 0.5,
        borderColor: const Color.fromRGBO(50, 198, 255, 1),
        color: const Color.fromRGBO(50, 198, 255, 1),
        borderDrawMode: RangeAreaBorderMode.excludeSides,
        xValueMapper: (ChartSampleData sales, _) => sales.x as DateTime,
        highValueMapper: (ChartSampleData sales, _) => sales.high,
        lowValueMapper: (ChartSampleData sales, _) => sales.low,
      )
    ];
  }
}

///Chart sample data
class ChartSampleData {
  /// Holds the datapoint values like x, y, etc.,
  ChartSampleData(
      {this.x,
      this.y,
      this.xValue,
      this.yValue,
      this.secondSeriesYValue,
      this.thirdSeriesYValue,
      this.pointColor,
      this.size,
      this.text,
      this.open,
      this.close,
      this.low,
      this.high,
      this.volume});

  /// Holds x value of the datapoint
  final dynamic x;

  /// Holds y value of the datapoint
  final num? y;

  /// Holds x value of the datapoint
  final dynamic xValue;

  /// Holds y value of the datapoint
  final num? yValue;

  /// Holds y value of the datapoint(for 2nd series)
  final num? secondSeriesYValue;

  /// Holds y value of the datapoint(for 3nd series)
  final num? thirdSeriesYValue;

  /// Holds point color of the datapoint
  final Color? pointColor;

  /// Holds size of the datapoint
  final num? size;

  /// Holds datalabel/text value mapper of the datapoint
  final String? text;

  /// Holds open value of the datapoint
  final num? open;

  /// Holds close value of the datapoint
  final num? close;

  /// Holds low value of the datapoint
  final num? low;

  /// Holds high value of the datapoint
  final num? high;

  /// Holds open value of the datapoint
  final num? volume;
}
