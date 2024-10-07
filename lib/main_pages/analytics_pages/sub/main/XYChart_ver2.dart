import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:servicer/design_standards/colors.dart';
import 'package:servicer/main_pages/analytics_pages/sub/earnings/composition/multi_chart/shopping_mall/sub/multi_view/calendar_view/calendar_chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../MOD_PACKAGES/BH_touchFX/bh_touchfx.dart';
import '../../../../design_standards/text_styles.dart';
import '../../../../servicer_modules/get_shoppingmall_theme.dart';
import '../../../../servicer_modules/shopping_mall_master.dart';
import '../earnings/detail/d_data_handler/name_switch_for_icon.dart';
import '../earnings/detail/detail_chart/depth_one/depth_one_chart.dart';

/// 신규 버전 메인 페이지의 위젯형 차트 중 첫 번째임.
/// 주문수와 반품률을 X와 Y축으로 하는 차트로 나타낸다.

class XYChartV2 extends StatefulWidget {
  XYChartV2({Key? key}) : super(key: key);

  @override
  State<XYChartV2> createState() => _XYChartV2State();
}

class _XYChartV2State extends State<XYChartV2> with IconSwitcher {
  late TooltipBehavior? _tooltipBehavior;
  late ZoomMode _zoomModeType;
  late ZoomPanBehavior _zoomPanBehavior;
  //List _checkingList = [];

  @override
  void initState() {
    _zoomModeType = ZoomMode.xy;
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

    _tooltipBehavior = TooltipBehavior(
        textAlignment: ChartAlignment.near,
        enable: true,
        header: '',
        canShowMarker: true,
        color: Colors.white,
        borderColor: Colors.transparent,
        shadowColor: Colors.white,
        borderWidth: 0,
        // format:
        //     '매출량 : point.size원\n발생 기간 : series.name\n기간 내 총매출 내 비율 : point.y%',
        builder: (dynamic data, dynamic point, dynamic series, int pointIndex,
            int seriesIndex) {
          //if (data.pointColor != Colors.white) {
          return Container(
            color: Colors.white,
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: BHTouchFXInkWell(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: SizedBox(
                            width: 30,
                            height: 30,
                            child: iconSwitcher('${series.name}')),
                      ),
                      // Text('PointIndex : ${pointIndex.toString()}'),
                      // Text('SeriesIndex : ${seriesIndex.toString()}'),
                      Text('쇼핑몰 : ${series.name}'),
                      data.returnRate != null
                          ? Text('반품률 : ${data.returnRate.toStringAsFixed(1)}%')
                          : Text('반품률 : 계산 불가'),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('유입: ${point.x}건'),
                          SizedBox(
                            width: 10,
                          ),
                          Text('클릭: ${point.y}건'),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('주문: ${data.orders}건'),
                          SizedBox(
                            width: 10,
                          ),
                          Text('반품: ${data.returns}건'),
                        ],
                      ),

                      //Text('주문/반품 발생 기간 : ${data.timeRange.toString()}'),
                    ],
                  ),
                  onLongPress: (() {
                    //Navigate to new chart
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailChartContainerD1(
                                title: '${series.name}\n${data.timeRange}')));
                  })),
            ),
          );
          // }
          // //return nothing, not even an empty container
          // return Visibility(
          //   visible: false,
          //   child: SizedBox(
          //     width: 0,
          //     height: 0,
          //   ),
          // );
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Row(
              children: [
                const Text(
                  '주문 / 반품',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                const Spacer(),
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(
                      color: const Color.fromARGB(255, 187, 187, 187),
                      width: 4,
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        '주문건 대비 \n반품건 비율',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Column(
            children: [
              const Align(
                alignment: Alignment.topRight,
                child: Text(
                  '클릭',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
              AspectRatio(
                aspectRatio: 1.0,
                child: SfCartesianChart(
                  zoomPanBehavior: _zoomPanBehavior,
                  plotAreaBorderWidth: 0,

                  annotations: [
                    // CartesianChartAnnotation(
                    //     //make a circle for widget
                    //     widget: Container(
                    //       width: 70,
                    //       height: 70,
                    //       decoration: BoxDecoration(
                    //         shape: BoxShape.circle,
                    //         color: Colors.white,
                    //         border: Border.all(
                    //           color: Colors.black,
                    //           width: 1,
                    //         ),
                    //       ),
                    //       child: Center(
                    //         child: Column(
                    //           mainAxisAlignment: MainAxisAlignment.center,
                    //           children: [
                    //             Text(
                    //               '주문건 대비 반품비율',
                    //               style: TextStyle(
                    //                 fontSize: 12,
                    //               ),
                    //               textAlign: TextAlign.center,
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //     coordinateUnit: CoordinateUnit.logicalPixel,
                    //     horizontalAlignment: ChartAlignment.near,
                    //     verticalAlignment: ChartAlignment.near,
                    //     x: 0,
                    //     y: 0),
                  ],

                  //title: ChartTitle(text: 'World countries details'),
                  primaryXAxis: NumericAxis(
                    enableAutoIntervalOnZooming: false,
                    decimalPlaces: 0,
                    majorGridLines: const MajorGridLines(width: 0),
                    title:
                        AxisTitle(text: '유입', alignment: ChartAlignment.near),
                    minimum: 50,
                    maximum: 110,
                    //axis direction is reversed
                    isInversed: true,
                  ),
                  primaryYAxis: NumericAxis(
                      enableAutoIntervalOnZooming: false,
                      decimalPlaces: 0,
                      maximum: 600,
                      //make every tick into integer
                      // axisLabelFormatter: (axisLabelRenderArgs) =>
                      //     ChartAxisLabel(
                      //         axisLabelRenderArgs.value.toInt().toString(),
                      //         TextStyle(
                      //           fontFamily: 'IBMPlexSansKR',
                      //           fontSize: $smallFontSize,
                      //         )),

                      //axisLine: const AxisLine(width: 0),
                      //majorTickLines: const MajorTickLines(width: 0),

                      opposedPosition: true,
                      labelPosition: ChartDataLabelPosition.outside,
                      tickPosition: TickPosition.outside
                      //title: AxisTitle(text: '가격', alignment: ChartAlignment.far),
                      ),
                  series: _getMultipleBubbleSeries(),
                  legend: Legend(
                      isVisible: true,
                      position: LegendPosition.bottom,
                      overflowMode: LegendItemOverflowMode.wrap),
                  tooltipBehavior: _tooltipBehavior,
                  onTooltipRender: (tooltipArgs) {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Returns the list of chart sereis
  /// which need to render on the multiple bubble series
  List<BubbleSeries<DetailChartData, num>> _getMultipleBubbleSeries() {
    return <BubbleSeries<DetailChartData, num>>[
      BubbleSeries<DetailChartData, num>(
        minimumRadius: sqrt(100),
        maximumRadius: sqrt(200),
        // gradient: const LinearGradient(
        //   colors: <Color>[Color(0xFF00A8B5), Color(0xFFFC4A1A)],
        //   stops: <double>[0.25, 0.75],
        //   begin: Alignment.bottomCenter,
        //   end: Alignment.topCenter,
        // ),
        borderColor: mallMaster.themeColorOf(Mall.NaverSmartStore),
        //make borderwidth correspond to bubble size
        //check if bubble size is greater than 1000 then make borderwidth 2
        borderWidth: 0,
        //opacity: 0.7,
        name: '스마트 스토어',
        dataSource: <DetailChartData>[
          DetailChartData(
              x: 'US',
              pointColor: mallMaster
                  .themeColorOf(Mall.NaverSmartStore)
                  .withOpacity(0.5),
              xValue: 99,
              y: 112,
              size: 200,
              orders: 200,
              returns: 100,
              returnRate: 112000 / 312000 * 100,
              timeRange: "2023.01.10~2023.01.15"),
          DetailChartData(
              x: 'US',
              pointColor: Colors.white,
              xValue: 99,
              y: 112,
              size: 100,
              orders: 200,
              returns: 100,
              returnRate: 112000 / 312000 * 100,
              timeRange: "2023.01.10~2023.01.15"),
          // DetailChartData(
          //     x: 'Mexico',
          //     pointColor: mallMaster
          //         .themeColorOf(Mall.NaverSmartStore)
          //         .withOpacity(0.5),
          //     xValue: 86,
          //     y: 114,
          //     size: 115000,
          //     returnRate: 75000 / 115000 * 100,
          //     timeRange: "2023.01.10~2023.01.15"),
          // DetailChartData(
          //     x: 'Mexico',
          //     // pointColor: mallMaster
          //     //     .themeColorOf(Mall.NaverSmartStore)
          //     //     .withOpacity(0.9),
          //     pointColor: Colors.white,
          //     xValue: 86,
          //     y: 114,
          //     size: 75000,
          //     returnRate: 75000 / 115000 * 100,
          //     timeRange: "2023.01.10~2023.01.15"),
        ],
        xValueMapper: (DetailChartData sales, _) => sales.xValue as num,
        yValueMapper: (DetailChartData sales, _) => sales.y,
        sizeValueMapper: (DetailChartData sales, _) => sales.size,
        pointColorMapper: (DetailChartData sales, _) => sales.pointColor,
        color: mallMaster.themeColorOf(Mall.NaverSmartStore).withOpacity(0.5),
      ),
      BubbleSeries<DetailChartData, num>(
        minimumRadius: sqrt(70),
        maximumRadius: sqrt(80),
        borderColor: mallMaster.themeColorOf(Mall.Zigzag).withOpacity(0.5),
        borderWidth: 0.5,
        name: '지그재그',
        dataSource: <DetailChartData>[
          DetailChartData(
            x: 'Germany',
            pointColor: mallMaster.themeColorOf(Mall.Zigzag).withOpacity(0.5),
            xValue: 99,
            y: 201,
            size: 80,
            orders: 80,
            returns: 70,
            returnRate: 70 / 80 * 100,
            timeRange: "2023.01.01~2023.12.31",
          ),
          DetailChartData(
            x: 'Germany',
            pointColor: Colors.white,
            xValue: 99,
            y: 201,
            size: 70,
            orders: 80,
            returns: 70,
            returnRate: 70 / 80 * 100,
            timeRange: "2023.01.01~2023.12.31",
          ),
          // DetailChartData(
          //     x: 'Russia',
          //     pointColor: mallMaster.themeColorOf(Mall.Zigzag).withOpacity(0.5),
          //     xValue: 99.6,
          //     y: 300,
          //     size: 143000,
          //     timeRange: "2023.01.01~2023.12.31"),
          // DetailChartData(
          //     x: 'Russia',
          //     pointColor: Colors.white,
          //     xValue: 99.6,
          //     y: 300,
          //     size: 43000,
          //     timeRange: "2023.01.01~2023.12.31"),
          // DetailChartData(
          //     x: 'Netherland',
          //     xValue: 79.2,
          //     y: 390,
          //     size: 162000000,
          //     timeRange: "2023.01.01~2023.12.31")
        ],
        xValueMapper: (DetailChartData sales, _) => sales.xValue as num,
        yValueMapper: (DetailChartData sales, _) => sales.y,
        sizeValueMapper: (DetailChartData sales, _) => sales.size,
        pointColorMapper: (DetailChartData sales, _) => sales.pointColor,
        color: mallMaster.themeColorOf(Mall.Zigzag).withOpacity(0.5),
      ),
      BubbleSeries<DetailChartData, num>(
          //make minmimun radius square root of 400
          minimumRadius: sqrt(50),
          maximumRadius: sqrt(700),
          borderColor: mallMaster.themeColorOf(Mall.Ably).withOpacity(0.5),
          borderWidth: 0.5,
          dataSource: <DetailChartData>[
            DetailChartData(
                x: 'Jordan',
                pointColor: mallMaster.themeColorOf(Mall.Ably).withOpacity(0.5),
                xValue: 72.5,
                y: 450,
                size: 700,
                orders: 700,
                returns: 50,
                returnRate: 50 / 700 * 100,
                timeRange: "2023.01.07~2023.01.15"),
            DetailChartData(
                x: 'Jordan',
                pointColor: Colors.white,
                xValue: 72.5,
                y: 450,
                size: 50,
                orders: 700,
                returns: 50,
                returnRate: 50 / 700 * 100,
                timeRange: "2023.01.07~2023.01.15"),
          ],
          name: '에이블리',
          xValueMapper: (DetailChartData sales, _) => sales.xValue as num,
          yValueMapper: (DetailChartData sales, _) => sales.y,
          sizeValueMapper: (DetailChartData sales, _) => sales.size,
          pointColorMapper: (DetailChartData sales, _) => sales.pointColor,
          color: mallMaster.themeColorOf(Mall.Ably).withOpacity(0.5)),
      BubbleSeries<DetailChartData, num>(
          minimumRadius: sqrt(70),
          maximumRadius: sqrt(200),
          borderColor: mallMaster.themeColorOf(Mall.Coupang).withOpacity(0.5),
          borderWidth: 0.5,
          name: '쿠팡',
          dataSource: <DetailChartData>[
            DetailChartData(
                x: 'Egypt',
                pointColor:
                    mallMaster.themeColorOf(Mall.Coupang).withOpacity(0.5),
                xValue: 72,
                y: 200,
                size: 200,
                orders: 200,
                returns: 70,
                returnRate: 70 / 200 * 100,
                timeRange: "2023.01.09~2023.01.15"),
            DetailChartData(
                x: 'Egypt',
                pointColor: Colors.white,
                xValue: 72,
                y: 200,
                size: 70,
                orders: 200,
                returns: 70,
                returnRate: 70 / 200 * 100,
                timeRange: "2023.01.09~2023.01.15"),
          ],
          xValueMapper: (DetailChartData sales, _) => sales.xValue as num,
          yValueMapper: (DetailChartData sales, _) => sales.y,
          sizeValueMapper: (DetailChartData sales, _) => sales.size,
          pointColorMapper: (DetailChartData sales, _) => sales.pointColor,
          color: mallMaster.themeColorOf(Mall.Coupang).withOpacity(0.5)),
    ];
  }
}

///Chart sample data
class DetailChartData {
  /// Holds the datapoint values like x, y, etc.,
  DetailChartData(
      {this.x,
      this.y,
      this.xValue,
      this.yValue,
      this.secondSeriesYValue,
      this.thirdSeriesYValue,
      this.pointColor,
      this.size,
      this.orders,
      this.returns,
      this.returnRate,
      this.text,
      this.timeRange,
      this.open,
      this.close,
      this.low,
      this.high,
      this.volume,
      this.nextChart});

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

  // Holds number of the orders of the datapoint
  final num? orders;

  // Hold number of the return of the datapoint
  final num? returns;

  /// Holds inner radius of the datapoint
  /// (used in doughnut and pie series)
  final num? returnRate;

  /// Holds datalabel/text value mapper of the datapoint
  final String? text;

  /// Holds time range of the datapoint
  final String? timeRange;

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

  /// Holds next chart Object of the datapoint
  final Object? nextChart;
}
