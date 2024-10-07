import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../../../../../../../data_handler/data_standards/time.dart';
import '../../../../../../../../../../design_standards/colors.dart';
import '../../../../../../../../../../design_standards/text_styles.dart';
import '../../ft_data_handler/y_axis_unit.dart';


class AgeSubChartContainer extends StatefulWidget {
  final double width;
  final Time time;
  const AgeSubChartContainer(
      {Key? key, required this.time, required this.width})
      : super(key: key);

  @override
  State<AgeSubChartContainer> createState() => _AgeSubChartContainerState();
}

class _AgeSubChartContainerState extends State<AgeSubChartContainer>
    with GChartYAxisUnit {
  late TooltipBehavior _tooltipBehavior;
  late ZoomMode _zoomModeType;
  late ZoomPanBehavior _zoomPanBehavior;
  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true, color: $$Grey, opacity: 1);
    _zoomModeType = ZoomMode.x;
    _zoomPanBehavior = ZoomPanBehavior(
        zoomMode: _zoomModeType,
        // Enables pinch zooming
        enablePinching: true,
        // Enables double tap zooming
        enableDoubleTapZooming: true,
        enableMouseWheelZooming: true,
        enablePanning: true,
        enableSelectionZooming: true,
        selectionRectBorderColor: Colors.red,
        selectionRectBorderWidth: 1,
        selectionRectColor: Colors.grey);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double _verticalPadding = 15;
    final double _horizontalPadding = 15;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: SfCartesianChart(
        plotAreaBorderWidth: 1,
        zoomPanBehavior: _zoomPanBehavior,
        title: ChartTitle(text: '나이별 여성/남성 소비자 매출'),
        legend: Legend(isVisible: true, position: LegendPosition.bottom),
        primaryXAxis: CategoryAxis(
          majorGridLines: const MajorGridLines(width: 0),
          opposedPosition: false,
        ),
        primaryYAxis: NumericAxis(
          axisLine: const AxisLine(width: 0),
          labelFormat: '{value}원',
          axisLabelFormatter: (axisLabelRenderArgs) {
            return ChartAxisLabel(
              //axisLabelRenderArgs.value.toDouble().abs().toStringAsFixed(0),
              getAbsValueUnit(axisLabelRenderArgs.value.toDouble().abs()),

              TextStyle(
                fontFamily: 'IBMPlexSansKR',
                fontSize: $smallFontSize,
              ),
            );
          },
          majorTickLines: const MajorTickLines(size: 1),
          //minorTicksPerInterval: 1000,
          enableAutoIntervalOnZooming: false,
          title: AxisTitle(text: '매출', alignment: ChartAlignment.far),
        ),
        series: <StackedBarSeries<ChartSampleData, String>>[
          StackedBarSeries<ChartSampleData, String>(
            dataSource: getChartDataByAge(widget.time),
            xValueMapper: (ChartSampleData sales, _) => sales.x as String,
            yValueMapper: (ChartSampleData sales, _) => sales.femaleValue,
            name: '여자',
            color: Color.fromARGB(255, 255, 114, 161),
            borderRadius: BorderRadius.horizontal(
                left: Radius.circular(4), right: Radius.circular(0)),
          ),
          StackedBarSeries<ChartSampleData, String>(
            dataSource: getChartDataByAge(widget.time),
            xValueMapper: (ChartSampleData sales, _) => sales.x as String,
            yValueMapper: (ChartSampleData sales, _) => sales.maleValue,
            name: '남자',
            color: Colors.blueAccent,
            borderRadius: BorderRadius.horizontal(
                left: Radius.circular(0), right: Radius.circular(4)),
          ),
        ],
        tooltipBehavior: _tooltipBehavior,
      ),
    );
  }

  List<ChartSampleData> getChartDataByAge(Time time) {
    List<ChartSampleData> chartData = [];
    if (time == Time.day) {
      chartData = [
        ChartSampleData(x: '~20', maleValue: 60000, femaleValue: -10000),
        ChartSampleData(x: '20대', maleValue: 80000, femaleValue: -75000),
        ChartSampleData(x: '30대', maleValue: 12000, femaleValue: -30000),
        ChartSampleData(x: '40대', maleValue: 15000, femaleValue: -25000),
        ChartSampleData(x: '50대', maleValue: 1000, femaleValue: -20000),
        ChartSampleData(x: '60~', maleValue: 1000, femaleValue: -1000),
      ].reversed.toList();
    } else if (time == Time.week) {
      chartData = [
        ChartSampleData(x: '~20', maleValue: 26000000, femaleValue: -10000000),
        ChartSampleData(x: '20대', maleValue: 28000000, femaleValue: -15000000),
        ChartSampleData(x: '30대', maleValue: 22000000, femaleValue: -20000000),
        ChartSampleData(x: '40대', maleValue: 45000000, femaleValue: -25000000),
        ChartSampleData(x: '50대', maleValue: 20000000, femaleValue: -30000000),
        ChartSampleData(x: '60~', maleValue: 24000000, femaleValue: -35000000),
      ].reversed.toList();
    } else if (time == Time.month) {
      chartData = [
        ChartSampleData(
            x: '~20', maleValue: 16000000 * 4, femaleValue: -10000000 * 4),
        ChartSampleData(
            x: '20대', maleValue: 28000000 * 4, femaleValue: -15000000 * 4),
        ChartSampleData(
            x: '30대', maleValue: 21000000 * 4, femaleValue: -20000000 * 4),
        ChartSampleData(
            x: '40대', maleValue: 43000000 * 4, femaleValue: -25000000 * 4),
        ChartSampleData(
            x: '50대', maleValue: 22000000 * 4, femaleValue: -30000000 * 4),
        ChartSampleData(
            x: '60~', maleValue: 24000000 * 4, femaleValue: -35000000 * 4),
      ].reversed.toList();
    } else if (time == Time.year) {
      chartData = [
        ChartSampleData(x: '~20', maleValue: 26000000, femaleValue: -10000000),
        ChartSampleData(x: '20대', maleValue: 28000000, femaleValue: -15000000),
        ChartSampleData(x: '30대', maleValue: 22000000, femaleValue: -20000000),
        ChartSampleData(x: '40대', maleValue: 45000000, femaleValue: -25000000),
        ChartSampleData(x: '50대', maleValue: 20000000, femaleValue: -30000000),
        ChartSampleData(x: '60~', maleValue: 24000000, femaleValue: -35000000),
      ].reversed.toList();
    } else if (time == Time.all) {
      chartData = [
        ChartSampleData(x: '~20', maleValue: 26000000, femaleValue: -10000000),
        ChartSampleData(x: '20대', maleValue: 28000000, femaleValue: -15000000),
        ChartSampleData(x: '30대', maleValue: 22000000, femaleValue: -20000000),
        ChartSampleData(x: '40대', maleValue: 45000000, femaleValue: -25000000),
        ChartSampleData(x: '50대', maleValue: 20000000, femaleValue: -30000000),
        ChartSampleData(x: '60~', maleValue: 24000000, femaleValue: -35000000),
      ].reversed.toList();
    } else {
      chartData = [
        ChartSampleData(x: '~20', maleValue: 26000000, femaleValue: -10000000),
        ChartSampleData(x: '20대', maleValue: 28000000, femaleValue: -15000000),
        ChartSampleData(x: '30대', maleValue: 22000000, femaleValue: -20000000),
        ChartSampleData(x: '40대', maleValue: 45000000, femaleValue: -25000000),
        ChartSampleData(x: '50대', maleValue: 20000000, femaleValue: -30000000),
        ChartSampleData(x: '60~', maleValue: 24000000, femaleValue: -35000000),
      ].reversed.toList();
    }

    return chartData;
  }
}

class ChartSampleData {
  /// Holds the datapoint values like x, y, etc.,
  ChartSampleData(
      {this.x,
      this.maleValue,
      this.xValue,
      this.yValue,
      this.femaleValue,
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
  final num? maleValue;

  /// Holds x value of the datapoint
  final dynamic xValue;

  /// Holds y value of the datapoint
  final num? yValue;

  /// Holds y value of the datapoint(for 2nd series)
  final num? femaleValue;

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
