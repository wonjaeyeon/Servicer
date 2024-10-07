import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_talk.dart';
import 'package:servicer/design_standards/colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import '../../../../../../../../../../data_handler/data_standards/time.dart';

///Chart import
import 'package:syncfusion_flutter_charts/charts.dart' hide LabelPlacement;

///Core import
import 'package:syncfusion_flutter_core/core.dart';

///Core theme import
import 'package:syncfusion_flutter_core/theme.dart';

///Slider import
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../../../../../../../../../design_standards/text_styles.dart';
import '../../../../../../../../../../design_standards/widget_styles.dart';
import '../../../p_data_handler/y_axis_unit.dart';

class UnitPersonPriceSubChartContainerV3 extends StatefulWidget {
  final double width;
  final Time time;
  const UnitPersonPriceSubChartContainerV3(
      {Key? key, required this.time, required this.width})
      : super(key: key);

  @override
  State<UnitPersonPriceSubChartContainerV3> createState() =>
      UnitPersonPriceSubChartContainerV3State();
}

class UnitPersonPriceSubChartContainerV3State
    extends State<UnitPersonPriceSubChartContainerV3> with PChartYAxisUnit {
  late TooltipBehavior _tooltipBehavior;
  final num min = 0, max = 100;
  late RangeController rangeController;
  late TextEditingController textController;
  //late List<_ChartData> data;
  late List<int> selectedItems;
  late SfRangeValues _values;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true, color: $$Grey, opacity: 1);
    selectedItems = <int>[];
    textController = TextEditingController(text: '가격범위에 따른 매출');
    rangeController = RangeController(
      start: 20.0,
      end: 50.0,
    );
    _setTotalDataUsage(SfRangeValues(20.0, 50.0));
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    rangeController.dispose();
    getChartData(widget.time).clear();
    selectedItems.clear();
    super.dispose();
  }

  void _setTotalDataUsage(SfRangeValues values) {
    double dataUsage = 0;
    for (int i = 0; i < getChartData(widget.time).length; i++) {
      // if (data[i].pricePercent.isAfter(
      //         //ignore: avoid_as
      //         (values.start as DateTime).subtract(const Duration(hours: 1))) &&
      //     data[i].pricePercent.isBefore(
      //         //ignore: avoid_as
      //         (values.end as DateTime).add(const Duration(hours: 1)))) {
      //   dataUsage += data[i].runs;
      // }
      if (getChartData(widget.time)[i].pricePercent >= values.start &&
          getChartData(widget.time)[i].pricePercent <= values.end)
        dataUsage += getChartData(widget.time)[i].runs;
    }
    textController.text = '해당 가격 범위 매출 : ${getValueUnit(dataUsage)}';
  }

  @override
  Widget build(BuildContext context) {
    selectedItems.clear();
    final ThemeData themeData = Theme.of(context);
    //final MediaQueryData mediaQueryData = MediaQuery.of(context);
    for (int i = 0; i < getChartData(widget.time).length; i++) {
      if (getChartData(widget.time)[i].pricePercent >= rangeController.start &&
          getChartData(widget.time)[i].pricePercent <= rangeController.end) {
        //selectedItems.add(getChartData(time).indexOf(getChartData(time)[i]));
        selectedItems.add(i);
      }
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Center(
          child: Text("1인 평균 소비가에 따른 주문 비율"),
        ),
        const Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.only(right: 50),
              child: Text("주문 비율"),
            )),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
          child: Center(
            child: SfRangeSelectorTheme(
              data: SfRangeSelectorThemeData(
                  brightness: themeData.colorScheme.brightness,
                  //labelOffset: const Offset(0, 2),
                  thumbColor: Colors.white,
                  overlayColor: Colors.orange.withOpacity(0.12),
                  activeTrackColor: Colors.orange,
                  thumbStrokeColor: Colors.orange,
                  thumbStrokeWidth: 2.0,
                  inactiveTrackColor: const Color.fromRGBO(194, 194, 194, 1),
                  activeTrackHeight: 10.0,
                  //tickOffset: Offset(0, -4),

                  //inactiveTrackHeight: 10.0,

                  //inactiveTickColor: const Color.fromRGBO(194, 194, 194, 1),
                  // activeLabelStyle: TextStyle(
                  //     fontSize: 12,
                  //     color: themeData.textTheme.bodyLarge!.color!
                  //         .withOpacity(0.87)),
                  // inactiveLabelStyle: TextStyle(
                  //     fontSize: 12,
                  //     color: themeData.textTheme.bodyLarge!.color!
                  //         .withOpacity(0.87)),
                  inactiveRegionColor: Colors.transparent),
              child: SfRangeSelector(
                min: min,
                max: max,
                labelFormatterCallback: (actualValue, formattedText) {
                  return formattedText + '%';
                },
                interval: 20,
                controller: rangeController,
                stepSize: 5,
                showTicks: true,
                showLabels: true,
                onChanged: (SfRangeValues values) {
                  _values = values;
                  _setTotalDataUsage(values);
                },
                trackShape: const SfTrackShape(),
                child: SfCartesianChart(
                  //title: ChartTitle(text: 'Data Usage For April 2019'),
                  margin: const EdgeInsets.symmetric(
                      //horizontal: mediaQueryData.size.width * 0.05,
                      vertical: 10),
                  // primaryXAxis: NumericAxis(
                  //   plotOffset: 0,
                  //   title: AxisTitle(
                  //       text: '가격 백분위', alignment: ChartAlignment.near),
                  //   minimum: 0,
                  //   maximum: 100,
                  //   labelFormat: '{value}%',
                  //   isVisible: true,
                  //   enableAutoIntervalOnZooming: true,
                  //   labelStyle: const TextStyle(fontFamily: 'IBMPlexSansKR'),
                  // ),
                  // primaryXAxis: LogarithmicAxis(
                  //     isVisible: true,
                  //     title: AxisTitle(
                  //         text: "1인당 평균 소비가", alignment: ChartAlignment.near),
                  //     labelFormat: '{value}원',
                  //     labelStyle: const TextStyle(fontFamily: 'IBMPlexSansKR'),
                  //     minimum: 0,
                  //     maximum: 1000000
                  //     //make chart's x length same

                  //     ),
                  primaryXAxis: CategoryAxis(
                    isVisible: true,
                    title: AxisTitle(
                        text: "가격 백분위", alignment: ChartAlignment.near),
                    labelStyle: const TextStyle(fontFamily: 'IBMPlexSansKR'),
                    //minimum: 0,
                    //maximum: 100,
                    //make chart's x length same
                    //labelFormat: '{value}%',
                  ),
                  primaryYAxis: NumericAxis(
                    minorTicksPerInterval: 5,
                    enableAutoIntervalOnZooming: true,
                    isVisible: true,
                    // labelPosition: ChartDataLabelPosition.inside,
                    // tickPosition: TickPosition.inside,
                    opposedPosition: true,
                    numberFormat: NumberFormat.currency(
                      locale: 'ko_KR', symbol: '', decimalDigits: 0,
                      //make a custom numberformat
                    ),
                    labelFormat: '{value}%',
                    // axisLabelFormatter: (axisLabelRenderArgs) => ChartAxisLabel(
                    //     getValueUnit(axisLabelRenderArgs.value.toDouble()),
                    //     TextStyle(
                    //       fontFamily: 'IBMPlexSansKR',
                    //       fontSize: $smallFontSize,
                    //     )),
                    //maximum: 26,
                    labelStyle: const TextStyle(fontFamily: 'IBMPlexSansKR'),
                  ),

                  plotAreaBorderWidth: 0,
                  plotAreaBackgroundColor: Colors.transparent,
                  series: <CartesianSeries<_ChartData, num>>[
                    ColumnSeries<_ChartData, num>(
                      width: 0.8,
                      initialSelectedDataIndexes: selectedItems,
                      selectionBehavior: SelectionBehavior(
                          enable: true,
                          unselectedOpacity: 1,
                          // selectedBorderColor:
                          //     const Color.fromRGBO(0, 178, 206, 1),
                          // selectedColor: const Color.fromRGBO(0, 178, 206, 1),
                          unselectedColor: $$lightGrey,
                          selectionController: rangeController),
                      // dashArray:
                      //     model.isWebFullView ? null : <double>[3, 2],
                      color: const Color.fromRGBO(255, 255, 255, 0),
                      borderColor: const Color.fromRGBO(194, 194, 194, 1),
                      animationDuration: 0,
                      borderWidth: 1,
                      dataSource: getChartData(widget.time),
                      xValueMapper: (_ChartData score, _) => score.pricePercent,
                      yValueMapper: (_ChartData score, _) => score.runs,
                      pointColorMapper: (_ChartData score, _) =>
                          score.pointColor,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 0),
          // padding: mediaQueryData.orientation == Orientation.landscape ||
          //         model.isWebFullView
          //     ? EdgeInsets.only(bottom: mediaQueryData.size.height * 0.025)
          //     : EdgeInsets.only(bottom: mediaQueryData.size.height * 0.1),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 20,
              child: TextField(
                controller: textController,
                enabled: false,
                readOnly: true,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(border: InputBorder.none),
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<_ChartData> getChartData(Time time) {
    List<_ChartData> chartData = [];
    if (time == Time.day) {
      chartData = <_ChartData>[
        _ChartData(5000, 4, Colors.orange[100]),
        _ChartData(10000, 6, Colors.orange[200]),
        _ChartData(15000, 8, Colors.orange[200]),
        _ChartData(20000, 1, Colors.orange[300]),
        _ChartData(30000, 8, Colors.orange[300]),
        _ChartData(40000, 6, Colors.orange[400]),
        _ChartData(50000, 4, Colors.orange[400]),
        _ChartData(100000, 20, Colors.orange[500]),
        _ChartData(150000, 40, Colors.orange[500]),
        _ChartData(200000, 60, Colors.orange[600]),
        _ChartData(300000, 8, Colors.orange[600]),
        _ChartData(400000, 1, Colors.orange[700]),
        _ChartData(500000, 8, Colors.orange[700]),
        _ChartData(1000000, 6, Colors.orange[800]),
        _ChartData(1500000, 4, Colors.orange[800]),
        _ChartData(2000000, 2, Colors.orange[900]),
        _ChartData(2500000, 4, Colors.orange[900]),
        _ChartData(3000000, 6, Colors.deepOrange[700]),
        _ChartData(4000000, 2, Colors.deepOrange[800]),
        _ChartData(5000000, 1, Colors.deepOrange[900]),
      ];
    } else if (time == Time.week) {
      chartData = <_ChartData>[
        _ChartData(5, 4000 * 30 * 7, Colors.orange[100]),
        _ChartData(10, 6000 * 30 * 7, Colors.orange[200]),
        _ChartData(15, 8000 * 30 * 7, Colors.orange[200]),
        _ChartData(20, 10000 * 30 * 7, Colors.orange[300]),
        _ChartData(25, 8000 * 30 * 7, Colors.orange[300]),
        _ChartData(30, 6000 * 30 * 7, Colors.orange[400]),
        _ChartData(35, 4500 * 30 * 7, Colors.orange[400]),
        _ChartData(40, 20000 * 30 * 6, Colors.orange[500]),
        _ChartData(45, 40000 * 30 * 6, Colors.orange[500]),
        _ChartData(50, 60000 * 30 * 6, Colors.orange[600]),
        _ChartData(55, 80000 * 30 * 6, Colors.orange[600]),
        _ChartData(60, 10000 * 30 * 6, Colors.orange[700]),
        _ChartData(65, 80000 * 30 * 6, Colors.orange[700]),
        _ChartData(70, 60000 * 30 * 6, Colors.orange[800]),
        _ChartData(75, 40000 * 30 * 6, Colors.orange[800]),
        _ChartData(80, 200 * 30 * 5, Colors.orange[900]),
        _ChartData(85, 4000 * 30 * 5, Colors.orange[900]),
        _ChartData(90, 6000 * 30 * 5, Colors.deepOrange[700]),
        _ChartData(95, 8000 * 30 * 5, Colors.deepOrange[700]),
        _ChartData(100, 10000 * 30 * 5, Colors.deepOrange[800]),
      ];
    } else if (time == Time.month) {
      chartData = <_ChartData>[
        _ChartData(5, 4000 * 30 * 6 * 4, Colors.orange[100]),
        _ChartData(10, 6000 * 30 * 7 * 4, Colors.orange[200]),
        _ChartData(15, 8000 * 30 * 7 * 4, Colors.orange[200]),
        _ChartData(20, 10000 * 30 * 7 * 4, Colors.orange[300]),
        _ChartData(25, 80000 * 30 * 6 * 4, Colors.orange[300]),
        _ChartData(30, 6000 * 30 * 7 * 4, Colors.orange[400]),
        _ChartData(35, 4500 * 30 * 7 * 4, Colors.orange[400]),
        _ChartData(40, 20000 * 30 * 6 * 4, Colors.orange[500]),
        _ChartData(45, 40000 * 30 * 7 * 4, Colors.orange[500]),
        _ChartData(50, 60000 * 30 * 6 * 4, Colors.orange[600]),
        _ChartData(55, 80000 * 30 * 6 * 4, Colors.orange[600]),
        _ChartData(60, 10000 * 30 * 8 * 4, Colors.orange[700]),
        _ChartData(65, 80000 * 30 * 8 * 4, Colors.orange[700]),
        _ChartData(70, 60000 * 30 * 6 * 4, Colors.orange[800]),
        _ChartData(75, 40000 * 30 * 6 * 4, Colors.orange[800]),
        _ChartData(80, 2000 * 30 * 5 * 4, Colors.orange[900]),
        _ChartData(85, 4000 * 30 * 5 * 4, Colors.orange[900]),
        _ChartData(90, 6000 * 30 * 5 * 4, Colors.deepOrange[700]),
        _ChartData(95, 8000 * 30 * 5 * 4, Colors.deepOrange[700]),
        _ChartData(100, 10000 * 30 * 5 * 4, Colors.deepOrange[800]),
      ];
    } else if (time == Time.year) {
      chartData = <_ChartData>[
        _ChartData(5, 4000 * 30 * 6 * 4 * 10, Colors.orange[100]),
        _ChartData(10, 6000 * 30 * 7 * 4 * 10, Colors.orange[200]),
        _ChartData(15, 8000 * 30 * 7 * 4 * 12, Colors.orange[200]),
        _ChartData(20, 10000 * 30 * 7 * 4 * 11, Colors.orange[300]),
        _ChartData(25, 80000 * 30 * 6 * 4 * 11, Colors.orange[300]),
        _ChartData(30, 6000 * 30 * 7 * 4 * 11, Colors.orange[400]),
        _ChartData(35, 4500 * 30 * 7 * 4 * 12, Colors.orange[400]),
        _ChartData(40, 20000 * 30 * 6 * 4 * 12, Colors.orange[500]),
        _ChartData(45, 40000 * 30 * 7 * 4 * 12, Colors.orange[500]),
        _ChartData(50, 60000 * 30 * 6 * 4 * 12, Colors.orange[600]),
        _ChartData(55, 80000 * 30 * 6 * 4 * 12, Colors.orange[600]),
        _ChartData(60, 10000 * 30 * 8 * 4 * 12, Colors.orange[700]),
        _ChartData(65, 80000 * 30 * 8 * 4 * 11, Colors.orange[700]),
        _ChartData(70, 60000 * 30 * 6 * 4 * 11, Colors.orange[800]),
        _ChartData(75, 40000 * 30 * 6 * 4 * 11, Colors.orange[800]),
        _ChartData(80, 2000 * 30 * 5 * 4 * 10, Colors.orange[900]),
        _ChartData(85, 4000 * 30 * 5 * 4 * 10, Colors.orange[900]),
        _ChartData(90, 6000 * 30 * 5 * 4 * 10, Colors.deepOrange[700]),
        _ChartData(95, 8000 * 30 * 5 * 4 * 10, Colors.deepOrange[700]),
        _ChartData(100, 10000 * 30 * 5 * 4 * 10, Colors.deepOrange[800]),
      ];
    } else if (time == Time.all) {
      chartData = <_ChartData>[
        _ChartData(5, 4000 * 6 * 4 * 10 * 2, Colors.orange[100]),
        _ChartData(10, 6000 * 7 * 4 * 11 * 2, Colors.orange[200]),
        _ChartData(15, 8000 * 7 * 4 * 12 * 2, Colors.orange[200]),
        _ChartData(20, 10000 * 7 * 4 * 10 * 2, Colors.orange[300]),
        _ChartData(25, 80000 * 6 * 4 * 10 * 2, Colors.orange[300]),
        _ChartData(30, 6000 * 7 * 4 * 11 * 2, Colors.orange[400]),
        _ChartData(35, 4500 * 7 * 4 * 12 * 2, Colors.orange[400]),
        _ChartData(40, 20000 * 6 * 4 * 10 * 2, Colors.orange[500]),
        _ChartData(45, 40000 * 7 * 4 * 12 * 2, Colors.orange[500]),
        _ChartData(50, 60000 * 6 * 4 * 10 * 2, Colors.orange[600]),
        _ChartData(55, 80000 * 6 * 4 * 12 * 2, Colors.orange[600]),
        _ChartData(60, 10000 * 8 * 4 * 10 * 2, Colors.orange[700]),
        _ChartData(65, 80000 * 8 * 4 * 10 * 2, Colors.orange[700]),
        _ChartData(70, 60000 * 6 * 4 * 10 * 2, Colors.orange[800]),
        _ChartData(75, 40000 * 6 * 4 * 9 * 2, Colors.orange[800]),
        _ChartData(80, 2000 * 5 * 4 * 10 * 2, Colors.orange[900]),
        _ChartData(85, 4000 * 5 * 4 * 12 * 2, Colors.orange[900]),
        _ChartData(90, 6000 * 5 * 4 * 10 * 2, Colors.deepOrange[700]),
        _ChartData(95, 8000 * 5 * 4 * 10 * 2, Colors.deepOrange[700]),
        _ChartData(100, 10000 * 5 * 4 * 10 * 2, Colors.deepOrange[800]),
      ];
    } else {
      chartData = <_ChartData>[];
    }

    return chartData;
  }
}

class _ChartData {
  _ChartData(this.pricePercent, this.runs, this.pointColor);
  final num pricePercent;
  final num runs;
  final Color? pointColor;
}
