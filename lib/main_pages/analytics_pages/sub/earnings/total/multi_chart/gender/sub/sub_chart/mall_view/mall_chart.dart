import 'package:flutter/material.dart';
import 'package:servicer/design_standards/colors.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../../../../../../../data_handler/data_standards/time.dart';
import '../../../../../../../../../../design_standards/text_styles.dart';
import '../../../../../../../../../../servicer_modules/shopping_mall_master.dart';
import '../../../g_data_handler/y_axis_unit.dart';

class MallSubChartContainer extends StatefulWidget {
  final double width;
  final Time time;
  const MallSubChartContainer(
      {Key? key, required this.time, required this.width})
      : super(key: key);

  @override
  MallSubChartContainerState createState() => MallSubChartContainerState();
}

class MallSubChartContainerState extends State<MallSubChartContainer>
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
            dataSource: getChartDataByMall(widget.time),
            xValueMapper: (ChartSampleData sales, _) => sales.x as String,
            yValueMapper: (ChartSampleData sales, _) => sales.femaleValue,
            name: '여자',
            color: Color.fromARGB(255, 255, 114, 161),
            borderRadius: BorderRadius.horizontal(
                left: Radius.circular(4), right: Radius.circular(0)),
          ),
          StackedBarSeries<ChartSampleData, String>(
            dataSource: getChartDataByMall(widget.time),
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

  List<ChartSampleData> getChartDataByMall(Time time) {
    List<ChartSampleData> chartData = [];
    if (time == Time.day) {
      chartData = [
        ChartSampleData(
            x: 'SmartStore', maleValue: 160000, femaleValue: -10000),
        ChartSampleData(x: 'Zigzag', maleValue: 0, femaleValue: -105000),
        ChartSampleData(x: 'Ably', maleValue: 12000, femaleValue: -30000),
        ChartSampleData(x: 'Coupang', maleValue: 15000, femaleValue: -25000),
      ].reversed.toList();
    } else if (time == Time.week) {
      chartData = [
        ChartSampleData(
            x: 'SmartStore', maleValue: 160000, femaleValue: -10000),
        ChartSampleData(x: 'Zigzag', maleValue: 0, femaleValue: -105000),
        ChartSampleData(x: 'Ably', maleValue: 12000, femaleValue: -30000),
        ChartSampleData(x: 'Coupang', maleValue: 15000, femaleValue: -25000),
      ].reversed.toList();
    } else if (time == Time.month) {
      chartData = [
        ChartSampleData(
            x: 'SmartStore', maleValue: 160000 * 2, femaleValue: -10000),
        ChartSampleData(x: 'Zigzag', maleValue: 1000, femaleValue: -105000),
        ChartSampleData(x: 'Ably', maleValue: 12000, femaleValue: -30000 * 2),
        ChartSampleData(x: 'Coupang', maleValue: 15000, femaleValue: -25000),
      ].reversed.toList();
    } else if (time == Time.year) {
      chartData = [
        ChartSampleData(
            x: 'SmartStore',
            maleValue: 160000 * 2 * 12,
            femaleValue: -10000 * 12),
        ChartSampleData(
            x: 'Zigzag', maleValue: 1000 * 12, femaleValue: -105000 * 12),
        ChartSampleData(
            x: 'Ably', maleValue: 12000 * 12, femaleValue: -30000 * 2 * 12),
        ChartSampleData(
            x: 'Coupang', maleValue: 15000 * 12, femaleValue: -25000 * 12),
      ].reversed.toList();
    } else if (time == Time.all) {
      chartData = [
        ChartSampleData(
            x: 'SmartStore',
            maleValue: 160000 * 2 * 12 * 1.2,
            femaleValue: -10000 * 12 * 1.2),
        ChartSampleData(
            x: 'Zigzag',
            maleValue: 1000 * 12 * 2,
            femaleValue: -105000 * 12 * 2),
        ChartSampleData(
            x: 'Ably',
            maleValue: 12000 * 12 * 2,
            femaleValue: -30000 * 2 * 12 * 2),
        ChartSampleData(
            x: 'Coupang',
            maleValue: 15000 * 12 * 2,
            femaleValue: -25000 * 12 * 2),
      ].reversed.toList();
    } else {
      chartData = [
        ChartSampleData(
            x: 'SmartStore',
            maleValue: 160000 * 2 * 12 * 1.2,
            femaleValue: -10000 * 12 * 1.2),
        ChartSampleData(
            x: 'Zigzag',
            maleValue: 1000 * 12 * 2,
            femaleValue: -105000 * 12 * 2),
        ChartSampleData(
            x: 'Ably',
            maleValue: 12000 * 12 * 2,
            femaleValue: -30000 * 2 * 12 * 2),
        ChartSampleData(
            x: 'Coupang',
            maleValue: 15000 * 12 * 2,
            femaleValue: -25000 * 12 * 2),
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
