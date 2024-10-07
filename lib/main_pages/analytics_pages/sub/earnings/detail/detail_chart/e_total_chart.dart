import 'package:flutter/material.dart';
import 'package:servicer/MOD_PACKAGES/BH_touchFX/bh_touchfx.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../../data_handler/data_standards/time.dart';
import '../../../../../../design_standards/text_styles.dart';
import '../../../../../../design_standards/widget_styles.dart';
import '../../../../../../servicer_modules/shopping_mall_master.dart';
import '../../../bottomsheet.dart';
import '../../abstract_class/abstractChart.dart';
import '../d_data_handler/name_switch_for_icon.dart';
import 'depth_one/depth_one_chart.dart';

class ETotalChart extends StatefulWidget {
  const ETotalChart({super.key});

  @override
  State<ETotalChart> createState() => _ETotalChartState();
}

class _ETotalChartState extends State<ETotalChart> with IconSwitcher {
  late TooltipBehavior? _tooltipBehavior;
  late ZoomMode _zoomModeType;
  late ZoomPanBehavior _zoomPanBehavior;
  late Time time;

  @override
  void initState() {
    time = Time.day;
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
                            width: 40,
                            height: 40,
                            child: iconSwitcher('${series.name}')),
                      ),
                      // Text('PointIndex : ${pointIndex.toString()}'),
                      // Text('SeriesIndex : ${seriesIndex.toString()}'),
                      Text('쇼핑몰 : ${series.name}'),
                      Text('총매출량 : ${point.bubbleSize.toInt().toString()}원'),
                      Text('매출 발생 기간 : ${data.timeRange.toString()}'),
                      Text('기간 내 총매출 내 비율 : ${point.y}%'),
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
        });
    super.initState();
  }

  List<bool> _isSelectedTime = [true, false, false, false, false, false];
  bool toggle = false;
  // AnimatedOpacity를 위한 변수
  bool _visible = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const SizedBox(
          //   height: 12,
          // ),
          // Padding(
          //   padding: $AnalyticsPageHorizontalPadding,
          //   child: Text(
          //     "상세 분석",
          //     style: TextStyle(
          //       color: Colors.black,
          //       fontSize: $mediumFontSize,
          //       fontWeight: FontWeight.bold,
          //     ),
          //   ),
          // ),
          const SizedBox(
            height: 4,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 1.0,
            child: AnimatedOpacity(
              opacity: _visible ? 1.0 : 0.0,
              duration: _visible
                  ? const Duration(milliseconds: 400)
                  : const Duration(milliseconds: 0),
              onEnd: () async => {
                await Future.delayed(const Duration(milliseconds: 400)),
                setState(() {
                  _visible = true;
                })
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width * 0.02),
                    child: Text("상품 가격"),
                  ),
                  AspectRatio(
                    aspectRatio: 1.0,
                    child: SfCartesianChart(
                      zoomPanBehavior: _zoomPanBehavior,
                      plotAreaBorderWidth: 0,
                      //title: ChartTitle(text: 'World countries details'),
                      primaryXAxis: NumericAxis(
                        majorGridLines: const MajorGridLines(width: 0),
                        title: AxisTitle(
                            text: '판매량', alignment: ChartAlignment.near),
                        minimum: 50,
                        maximum: 110,
                        //axis direction is reversed
                        isInversed: true,
                      ),
                      primaryYAxis: NumericAxis(
                        //axisLine: const AxisLine(width: 0),
                        //majorTickLines: const MajorTickLines(width: 0),
                        opposedPosition: true,
                        labelPosition: ChartDataLabelPosition.outside,
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
            ),
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
        opacity: 0.7,
        name: '스마트 스토어',
        dataSource: <DetailChartData>[
          DetailChartData(
              x: 'US',
              xValue: 99.4,
              y: 2.2,
              size: 312000,
              timeRange: "2023.01.10~2023.01.15"),
          DetailChartData(
              x: 'Mexico',
              xValue: 86.1,
              y: 4.0,
              size: 115000,
              timeRange: "2023.01.10~2023.01.15")
        ],
        xValueMapper: (DetailChartData sales, _) => sales.xValue as num,
        yValueMapper: (DetailChartData sales, _) => sales.y,
        sizeValueMapper: (DetailChartData sales, _) => sales.size,
        color: mallMaster.themeColorOf(Mall.NaverSmartStore).withOpacity(0.5),
      ),
      BubbleSeries<DetailChartData, num>(
        opacity: 0.7,
        name: '지그재그',
        dataSource: <DetailChartData>[
          DetailChartData(
              x: 'Germany',
              xValue: 99,
              y: 0.7,
              size: 818000,
              timeRange: "2023.01.01~2023.12.31"),
          DetailChartData(
              x: 'Russia',
              xValue: 99.6,
              y: 3.4,
              size: 143000,
              timeRange: "2023.01.01~2023.12.31"),
          DetailChartData(
              x: 'Netherland',
              xValue: 79.2,
              y: 3.9,
              size: 162000,
              timeRange: "2023.01.01~2023.12.31")
        ],
        xValueMapper: (DetailChartData sales, _) => sales.xValue as num,
        yValueMapper: (DetailChartData sales, _) => sales.y,
        sizeValueMapper: (DetailChartData sales, _) => sales.size,
        color: mallMaster.themeColorOf(Mall.Zigzag).withOpacity(0.5),
      ),
      BubbleSeries<DetailChartData, num>(
          opacity: 0.7,
          dataSource: <DetailChartData>[
            DetailChartData(
                x: 'China',
                xValue: 92.2,
                y: 7.8,
                size: 134700,
                timeRange: "2023.01.07~2023.01.15"),
            DetailChartData(
                x: 'India',
                xValue: 74,
                y: 6.5,
                size: 124100,
                timeRange: "2023.01.07~2023.01.15"),
            DetailChartData(
                x: 'Indonesia',
                xValue: 90.4,
                y: 6.0,
                size: 23800,
                timeRange: "2023.01.07~2023.01.15"),
            DetailChartData(
                x: 'Japan',
                xValue: 99,
                y: 0.2,
                size: 12800,
                timeRange: "2023.01.07~2023.01.15"),
            DetailChartData(
                x: 'Philippines',
                xValue: 92.6,
                y: 6.6,
                size: 96000,
                timeRange: "2023.01.07~2023.01.15"),
            DetailChartData(
                x: 'Hong Kong',
                xValue: 82.2,
                y: 3.97,
                size: 70000,
                timeRange: "2023.01.07~2023.01.15"),
            DetailChartData(
                x: 'Jordan',
                xValue: 72.5,
                y: 4.5,
                size: 70000,
                timeRange: "2023.01.07~2023.01.15"),
            DetailChartData(
                x: 'Australia',
                xValue: 81,
                y: 3.5,
                size: 210000,
                timeRange: "2023.01.07~2023.01.15"),
            DetailChartData(
                x: 'Mongolia',
                xValue: 66.8,
                y: 3.9,
                size: 280000,
                timeRange: "2023.01.07~2023.01.15"),
            DetailChartData(
                x: 'Taiwan',
                xValue: 78.4,
                y: 2.9,
                size: 231000,
                timeRange: "2023.01.07~2023.01.15"),
          ],
          name: '에이블리',
          xValueMapper: (DetailChartData sales, _) => sales.xValue as num,
          yValueMapper: (DetailChartData sales, _) => sales.y,
          sizeValueMapper: (DetailChartData sales, _) => sales.size,
          color: mallMaster.themeColorOf(Mall.Ably).withOpacity(0.5)),
      BubbleSeries<DetailChartData, num>(
          opacity: 0.7,
          name: '쿠팡',
          dataSource: <DetailChartData>[
            DetailChartData(
                x: 'Egypt',
                xValue: 72,
                y: 2.0,
                size: 826000,
                timeRange: "2023.01.09~2023.01.15"),
            DetailChartData(
                x: 'Nigeria',
                xValue: 61.3,
                y: 1.45,
                size: 162000,
                timeRange: "2023.01.09~2023.01.15"),
          ],
          xValueMapper: (DetailChartData sales, _) => sales.xValue as num,
          yValueMapper: (DetailChartData sales, _) => sales.y,
          sizeValueMapper: (DetailChartData sales, _) => sales.size,
          color: mallMaster.themeColorOf(Mall.Coupang).withOpacity(0.5)),
    ];
  }
}

class ChartData {
  ChartData(this.x, this.y, this.size);
  final DateTime x;
  final double y;
  final double size;
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
