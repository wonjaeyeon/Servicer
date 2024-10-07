import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:servicer/design_standards/colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../../../../../../../data_handler/data_standards/time.dart';

///Chart import
import 'package:syncfusion_flutter_charts/charts.dart' hide LabelPlacement;

import '../../../../../../../../../../design_standards/text_styles.dart';
import '../../../../../../../../../../design_standards/widget_styles.dart';
import '../../../p_data_handler/y_axis_unit.dart';

class UnitPersonPriceSubChartContainerV2 extends StatefulWidget {
  final double width;
  final Time time;
  const UnitPersonPriceSubChartContainerV2(
      {Key? key, required this.time, required this.width})
      : super(key: key);

  @override
  State<UnitPersonPriceSubChartContainerV2> createState() =>
      UnitPersonPriceSubChartContainerV2State();
}

class UnitPersonPriceSubChartContainerV2State
    extends State<UnitPersonPriceSubChartContainerV2> with PChartYAxisUnit {
  List<ChartSampleData>? chartData;

  @override
  void initState() {
    chartData = <ChartSampleData>[
      ChartSampleData(
          x: "10%",
          y: 13,
          secondSeriesYValue: 69.8,
          pointColor: Colors.orangeAccent[100]),
      ChartSampleData(
          x: "20%",
          y: 26,
          secondSeriesYValue: 87.8,
          pointColor: Colors.orangeAccent[100]),
      ChartSampleData(
          x: "30%",
          y: 13,
          secondSeriesYValue: 78.8,
          pointColor: Color.fromARGB(255, 243, 162, 57)),
      ChartSampleData(
          x: "40%",
          y: 22,
          secondSeriesYValue: 75.2,
          pointColor: Color.fromARGB(255, 234, 158, 57)),
      ChartSampleData(
          x: "50%",
          y: 14,
          secondSeriesYValue: 68,
          pointColor: Colors.orangeAccent[700]),
      ChartSampleData(
          x: "60%",
          y: 23,
          secondSeriesYValue: 78.8,
          pointColor: Colors.orange[900]),
      ChartSampleData(
          x: "70%",
          y: 21,
          secondSeriesYValue: 80.6,
          pointColor: Colors.deepOrange[900]),
      ChartSampleData(
          x: "80%",
          y: 22,
          secondSeriesYValue: 73.4,
          pointColor: Color.fromARGB(255, 168, 44, 7)),
      ChartSampleData(
          x: "90%",
          y: 16,
          secondSeriesYValue: 78.8,
          pointColor: Color.fromARGB(255, 148, 36, 1)),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('가격대별 객단가/주문 그래프',
                style: (TextStyle(
                  fontSize: $mediumFontSize,
                ))),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 10),
            Text("객단가"),
            Spacer(),
            Text("주문건수"),
            const SizedBox(width: 10),
          ],
        ),
        _buildMultipleAxisLineChart(),
      ],
    );
  }

  /// Returns the chart with multiple axes.
  SfCartesianChart _buildMultipleAxisLineChart() {
    return SfCartesianChart(
      //title: ChartTitle(text: '가격대별 객단가/주문 그래프'),
      legend: Legend(isVisible: true, position: LegendPosition.bottom),

      /// API for multiple axis. It can returns the various axis to the chart.
      axes: <ChartAxis>[
        NumericAxis(
            //title: AxisTitle(text: '주문건수'),
            opposedPosition: true,
            name: 'yAxis1',
            majorGridLines: const MajorGridLines(width: 0),
            labelFormat: '{value}건',
            minimum: 40,
            maximum: 100,
            interval: 10)
      ],
      primaryXAxis: CategoryAxis(
        title: AxisTitle(text: '가격 백분위'),
        majorGridLines: const MajorGridLines(width: 0),
        labelPlacement: LabelPlacement.onTicks,
      ),
      primaryYAxis: NumericAxis(
        //title: AxisTitle(text: '객단가'),
        majorGridLines: const MajorGridLines(width: 0),
        opposedPosition: false,
        minimum: 0,
        maximum: 50,
        interval: 10,
        labelFormat: '{value},000원',
      ),
      series: _getMultipleAxisLineSeries(),
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }

  /// Returns the list of chart series which need to
  /// render on the multiple axes chart.
  List<ChartSeries<ChartSampleData, String>> _getMultipleAxisLineSeries() {
    return <ChartSeries<ChartSampleData, String>>[
      ColumnSeries<ChartSampleData, String>(
          dataSource: chartData!,
          xValueMapper: (ChartSampleData sales, _) => sales.x,
          yValueMapper: (ChartSampleData sales, _) => sales.y,
          pointColorMapper: (ChartSampleData sales, _) => sales.pointColor,
          name: '객단가',
          color: Colors.orange),
      LineSeries<ChartSampleData, String>(
          dataSource: chartData!,
          yAxisName: 'yAxis1',
          xValueMapper: (ChartSampleData sales, _) => sales.x,
          yValueMapper: (ChartSampleData sales, _) => sales.secondSeriesYValue,
          name: '주문건')
    ];
  }

  @override
  void dispose() {
    chartData!.clear();
    super.dispose();
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
