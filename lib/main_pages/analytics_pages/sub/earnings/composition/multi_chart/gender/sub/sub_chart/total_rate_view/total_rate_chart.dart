import 'package:flutter/material.dart';
import 'package:servicer/design_standards/colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../../../../../../data_handler/data_standards/time.dart';

class TotalRateSubChartContainer extends StatefulWidget {
  final double width;
  final Time time;
  const TotalRateSubChartContainer(
      {Key? key, required this.time, required this.width})
      : super(key: key);

  @override
  State<TotalRateSubChartContainer> createState() =>
      TotalRateSubChartContainerState();
}

class TotalRateSubChartContainerState
    extends State<TotalRateSubChartContainer> {
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true, color: $$Grey, opacity: 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: SfCircularChart(
        title: ChartTitle(text: '성별 매출 총 비율'),
        legend: Legend(
            isVisible: true,
            position: LegendPosition.bottom,
            overflowMode: LegendItemOverflowMode.wrap),
        series: <DoughnutSeries<ChartSampleData, String>>[
          DoughnutSeries<ChartSampleData, String>(
              animationDuration: 0,
              radius: '80%',
              //explode: true,
              //explodeOffset: '10%',
              // dataSource: <ChartSampleData>[
              //   ChartSampleData(x: '남자', y: 55, text: '55%'),
              //   ChartSampleData(x: '여자', y: 31, text: '31%'),
              // ],
              dataSource: getChartData(widget.time),
              xValueMapper: (ChartSampleData data, _) => data.x as String,
              yValueMapper: (ChartSampleData data, _) => data.y,
              pointColorMapper: (ChartSampleData data, _) => data.pointColor,
              //dataLabelMapper: (ChartSampleData data, _) => data.text,
              dataLabelSettings: const DataLabelSettings(isVisible: true))
        ],
        tooltipBehavior: _tooltipBehavior,
      ),
    );
  }

  /// Returns the doughnut series which need to be render.
  // List<DoughnutSeries<ChartSampleData, String>> _getDefaultDoughnutSeries() {
  //   return
  // }

  List<ChartSampleData> getChartData(Time time) {
    List<ChartSampleData> chartData = <ChartSampleData>[];
    if (time == Time.day) {
      chartData = <ChartSampleData>[
        ChartSampleData(
            x: '남자', y: 55, text: '55%', pointColor: Colors.blueAccent),
        ChartSampleData(
            x: '여자',
            y: 31,
            text: '31%',
            pointColor: Color.fromARGB(255, 255, 114, 161)),
      ];
    } else if (time == Time.week) {
      chartData = <ChartSampleData>[
        ChartSampleData(
            x: '남자', y: 85, text: '55%', pointColor: Colors.blueAccent),
        ChartSampleData(
            x: '여자',
            y: 91,
            text: '31%',
            pointColor: Color.fromARGB(255, 255, 114, 161)),
      ];
    } else if (time == Time.month) {
      chartData = <ChartSampleData>[
        ChartSampleData(
            x: '남자', y: 155, text: '55%', pointColor: Colors.blueAccent),
        ChartSampleData(
            x: '여자',
            y: 301,
            text: '31%',
            pointColor: Color.fromARGB(255, 255, 114, 161)),
      ];
    } else if (time == Time.year) {
      chartData = <ChartSampleData>[
        ChartSampleData(
            x: '남자', y: 355, text: '55%', pointColor: Colors.blueAccent),
        ChartSampleData(
            x: '여자',
            y: 401,
            text: '31%',
            pointColor: Color.fromARGB(255, 255, 114, 161)),
      ];
    } else if (time == Time.all) {
      chartData = <ChartSampleData>[
        ChartSampleData(
            x: '남자', y: 555, text: '55%', pointColor: Colors.blueAccent),
        ChartSampleData(
            x: '여자',
            y: 601,
            text: '31%',
            pointColor: Color.fromARGB(255, 255, 114, 161)),
      ];
    } else {
      chartData = <ChartSampleData>[
        ChartSampleData(
            x: '남자', y: 55, text: '55%', pointColor: Colors.blueAccent),
        ChartSampleData(x: '여자', y: 31, text: '31%'),
      ];
    }
    return chartData;
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
