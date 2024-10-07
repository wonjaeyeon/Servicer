import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:servicer/design_standards/colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../../../../design_standards/text_styles.dart';
import '../../../../../../../design_standards/widget_styles.dart';
import '../../../../../../../servicer_modules/shopping_mall_master.dart';
import '../../../../../../../../data_handler/data_standards/time.dart';
import '../../../../bottomsheet.dart';
import '../../../abstract_class/abstractChart.dart';

///Chart import
import 'package:syncfusion_flutter_charts/charts.dart' hide LabelPlacement;

///Core import
import 'package:syncfusion_flutter_core/core.dart';

///Core theme import
import 'package:syncfusion_flutter_core/theme.dart';

///Slider import
import 'package:syncfusion_flutter_sliders/sliders.dart';

import 'sub/analysis/age_chart_analysis.dart';
import 'sub/multi_view/_multi_view_chart_maker/multi_view_chart.dart';

class AgeAnalysisChart extends StatefulWidget {
  //late Time time;
  final double width;
  AgeAnalysisChart({Key? key, required this.width}) : super(key: key);

  @override
  State<AgeAnalysisChart> createState() => _AgeAnalysisChartState();
}

class _AgeAnalysisChartState extends State<AgeAnalysisChart>
    with SingleTickerProviderStateMixin, FunctionForClass {
  //late List<ExpenseData> _chartData;
  late Time time;
  late TooltipBehavior _tooltipBehavior;
  List<bool> _isSelectedTime = [true, false, false, false, false, false];
  // AnimatedOpacity를 위한 변수
  bool _visible = true;

  final num min = 10, max = 70;
  late RangeController rangeController;
  late TextEditingController textController;
  //late List<_ChartData> data;
  late List<int> selectedItems;
  late SfRangeValues _values;
  late ZoomPanBehavior _zoomPanBehavior;

  @override
  void initState() {
    time = Time.day;
    _values = SfRangeValues(20.0, 50.0);
    //_chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true, color: $$Grey, opacity: 1);

    selectedItems = <int>[];
    textController = TextEditingController(text: '가격범위에 따른 매출');
    rangeController = RangeController(
      start: 20.0,
      end: 50.0,
    );
    _setTotalDataUsage(SfRangeValues(20.0, 50.0));
    _zoomPanBehavior = ZoomPanBehavior(
      // Enables pinch zooming
      enablePinching: true,
      enablePanning: true,
      enableDoubleTapZooming: true,
      enableSelectionZooming: true,
      selectionRectBorderColor: $$Grey,
      selectionRectBorderWidth: 1,
      selectionRectColor: $$Grey.withOpacity(0.2),
    );
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    rangeController.dispose();
    getChartData(time).clear();
    selectedItems.clear();
    super.dispose();
  }

  void _setTotalDataUsage(SfRangeValues values) {
    double dataUsage = 0;
    for (int i = 0; i < getChartData(time).length; i++) {
      if (getChartData(time)[i].pricePercent >= values.start &&
          getChartData(time)[i].pricePercent <= values.end)
        dataUsage += getChartData(time)[i].runs;
    }
    textController.text = '해당 가격 범위 매출 : ${getValueUnit(dataUsage)}';
  }

  @override
  Widget build(BuildContext context) {
    selectedItems.clear();
    final ThemeData themeData = Theme.of(context);
    //final MediaQueryData mediaQueryData = MediaQuery.of(context);
    for (int i = 0; i < getChartData(time).length; i++) {
      if (getChartData(time)[i].pricePercent >= rangeController.start &&
          getChartData(time)[i].pricePercent <= rangeController.end) {
        //selectedItems.add(getChartData(time).indexOf(getChartData(time)[i]));
        selectedItems.add(i);
      }
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(
          height: 10,
        ),
        //현재 그래프 기간
        Padding(
          padding: $AnalyticsPageHorizontalPadding,
          child: Text(getTimeRange(time),
              style: TextStyle(fontSize: $mediumFontSize - 2)),
        ),
        const SizedBox(
          height: 10,
        ),
        Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.only(right: 50),
              child: Text("매출액"),
            )),

        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
          child: Center(
            child: SfRangeSelectorTheme(
              data: SfRangeSelectorThemeData(
                  brightness: themeData.colorScheme.brightness,
                  //labelOffset: const Offset(0, 2),
                  thumbColor: Colors.white,
                  overlayColor: Colors.green.withOpacity(0.12),
                  activeTrackColor: Colors.green,
                  thumbStrokeColor: Colors.green,
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
                enableTooltip: true,
                min: min,
                max: max,
                labelFormatterCallback: (actualValue, formattedText) {
                  return formattedText + '세';
                },
                interval: 10,
                controller: rangeController,
                stepSize: 1,
                showTicks: true,
                showLabels: true,
                onChanged: (SfRangeValues values) {
                  _values = values;
                  _setTotalDataUsage(values);
                },
                trackShape: const SfTrackShape(),
                child: SfCartesianChart(
                  zoomPanBehavior: _zoomPanBehavior,
                  //title: ChartTitle(text: 'Data Usage For April 2019'),
                  margin: const EdgeInsets.symmetric(
                      //horizontal: mediaQueryData.size.width * 0.05,
                      vertical: 10),
                  primaryXAxis: NumericAxis(
                    plotOffset: 0,
                    title: AxisTitle(
                        text: '연령대 범위', alignment: ChartAlignment.near),
                    minimum: 10,
                    maximum: 70,
                    labelFormat: '{value}세',
                    isVisible: true,
                    enableAutoIntervalOnZooming: true,
                    labelStyle: const TextStyle(fontFamily: 'IBMPlexSansKR'),
                  ),
                  primaryYAxis: NumericAxis(
                    isVisible: true,
                    // labelPosition: ChartDataLabelPosition.inside,
                    // tickPosition: TickPosition.inside,
                    opposedPosition: true,
                    numberFormat: NumberFormat.currency(
                      locale: 'ko_KR', symbol: '', decimalDigits: 0,
                      //make a custom numberformat
                    ),
                    labelFormat: '{value}원',
                    axisLabelFormatter: (axisLabelRenderArgs) => ChartAxisLabel(
                        getValueUnit(axisLabelRenderArgs.value.toDouble()),
                        TextStyle(
                          fontFamily: 'IBMPlexSansKR',
                          fontSize: $smallFontSize,
                        )),
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
                            unselectedOpacity: 0,
                            // selectedBorderColor:
                            //     const Color.fromRGBO(0, 178, 206, 1),
                            // selectedColor: const Color.fromRGBO(0, 178, 206, 1),
                            unselectedColor: Colors.transparent,
                            selectionController: rangeController),
                        // dashArray:
                        //     model.isWebFullView ? null : <double>[3, 2],
                        color: const Color.fromRGBO(255, 255, 255, 0),
                        borderColor: const Color.fromRGBO(194, 194, 194, 1),
                        animationDuration: 0,
                        borderWidth: 1,
                        dataSource: getChartData(time),
                        xValueMapper: (_ChartData score, _) =>
                            score.pricePercent,
                        yValueMapper: (_ChartData score, _) => score.runs,
                        pointColorMapper: (_ChartData score, _) =>
                            score.pointColor)
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
        TimeClicker(
          isSelectedTime: _isSelectedTime,
          callbackFunction: callbackFunction,
        ),
        const SizedBox(
          height: 4,
        ),
        AgeChartAnalysis(
          timeRange: getTimeRange(time),
          unit: "원",
        ),
        const SizedBox(
          height: 4,
        ),
        AgeMultiViewChart(),
      ],
    );
  }

  List<_ChartData> getChartData(Time time) {
    List<_ChartData> chartData = [];
    if (time == Time.day) {
      chartData = <_ChartData>[
        _ChartData(15, 4000, Colors.green[100]),
        _ChartData(16, 6000, Colors.green[100]),
        _ChartData(17, 10000, Colors.green[100]),
        _ChartData(18, 9000, Colors.green[100]),
        _ChartData(19, 8000, Colors.green[100]),
        _ChartData(10, 6000, Colors.green[200]),
        _ChartData(15, 8000, Colors.green[200]),
        _ChartData(20, 10000, Colors.green[300]),
        _ChartData(25, 8000, Colors.green[300]),
        _ChartData(30, 6000, Colors.green[400]),
        _ChartData(35, 4500, Colors.green[400]),
        _ChartData(40, 20000, Colors.green[500]),
        _ChartData(45, 40000, Colors.green[500]),
        _ChartData(50, 6000, Colors.green[600]),
        _ChartData(55, 80000, Colors.green[600]),
        _ChartData(60, 10000, Colors.green[700]),
        _ChartData(65, 80000, Colors.green[700]),
        _ChartData(70, 60000, Colors.green[800]),
      ];
    } else if (time == Time.week) {
      chartData = <_ChartData>[
        _ChartData(5, 4000 * 7, Colors.green[100]),
        _ChartData(10, 6000 * 7, Colors.green[200]),
        _ChartData(15, 8000 * 7, Colors.green[200]),
        _ChartData(20, 10000 * 7, Colors.green[300]),
        _ChartData(25, 8000 * 7, Colors.green[300]),
        _ChartData(30, 6000 * 7, Colors.green[400]),
        _ChartData(35, 4500 * 7, Colors.green[400]),
        _ChartData(40, 20000 * 6, Colors.green[500]),
        _ChartData(45, 40000 * 6, Colors.green[500]),
        _ChartData(50, 60000 * 6, Colors.green[600]),
        _ChartData(55, 80000 * 6, Colors.green[600]),
        _ChartData(60, 10000 * 6, Colors.green[700]),
        _ChartData(65, 80000 * 6, Colors.green[700]),
        _ChartData(70, 60000 * 6, Colors.green[800]),
        _ChartData(75, 40000 * 6, Colors.green[800]),
        _ChartData(80, 200 * 5, Colors.green[900]),
        _ChartData(85, 4000 * 5, Colors.green[900]),
        _ChartData(90, 6000 * 5, Colors.greenAccent[700]),
        _ChartData(95, 8000 * 5, Colors.greenAccent[700]),
        _ChartData(100, 10000 * 5, Colors.greenAccent[800]),
      ];
    } else if (time == Time.month) {
      chartData = <_ChartData>[
        _ChartData(5, 4000 * 6 * 4, Colors.green[100]),
        _ChartData(10, 6000 * 7 * 4, Colors.green[200]),
        _ChartData(15, 8000 * 7 * 4, Colors.green[200]),
        _ChartData(20, 10000 * 7 * 4, Colors.green[300]),
        _ChartData(25, 80000 * 6 * 4, Colors.green[300]),
        _ChartData(30, 6000 * 7 * 4, Colors.green[400]),
        _ChartData(35, 4500 * 7 * 4, Colors.green[400]),
        _ChartData(40, 20000 * 6 * 4, Colors.green[500]),
        _ChartData(45, 40000 * 7 * 4, Colors.green[500]),
        _ChartData(50, 60000 * 6 * 4, Colors.green[600]),
        _ChartData(55, 80000 * 6 * 4, Colors.green[600]),
        _ChartData(60, 10000 * 8 * 4, Colors.green[700]),
        _ChartData(65, 80000 * 8 * 4, Colors.green[700]),
        _ChartData(70, 60000 * 6 * 4, Colors.green[800]),
        _ChartData(75, 40000 * 6 * 4, Colors.green[800]),
        _ChartData(80, 2000 * 5 * 4, Colors.green[900]),
        _ChartData(85, 4000 * 5 * 4, Colors.green[900]),
        _ChartData(90, 6000 * 5 * 4, Colors.greenAccent[700]),
        _ChartData(95, 8000 * 5 * 4, Colors.greenAccent[700]),
        _ChartData(100, 10000 * 5 * 4, Colors.greenAccent[800]),
      ];
    } else if (time == Time.year) {
      chartData = <_ChartData>[
        _ChartData(5, 4000 * 6 * 4 * 10, Colors.green[100]),
        _ChartData(10, 6000 * 7 * 4 * 10, Colors.green[200]),
        _ChartData(15, 8000 * 7 * 4 * 12, Colors.green[200]),
        _ChartData(20, 10000 * 7 * 4 * 11, Colors.green[300]),
        _ChartData(25, 80000 * 6 * 4 * 11, Colors.green[300]),
        _ChartData(30, 6000 * 7 * 4 * 11, Colors.green[400]),
        _ChartData(35, 4500 * 7 * 4 * 12, Colors.green[400]),
        _ChartData(40, 20000 * 6 * 4 * 12, Colors.green[500]),
        _ChartData(45, 40000 * 7 * 4 * 12, Colors.green[500]),
        _ChartData(50, 60000 * 6 * 4 * 12, Colors.green[600]),
        _ChartData(55, 80000 * 6 * 4 * 12, Colors.green[600]),
        _ChartData(60, 10000 * 8 * 4 * 12, Colors.green[700]),
        _ChartData(65, 80000 * 8 * 4 * 11, Colors.green[700]),
        _ChartData(70, 60000 * 6 * 4 * 11, Colors.green[800]),
        _ChartData(75, 40000 * 6 * 4 * 11, Colors.green[800]),
        _ChartData(80, 2000 * 5 * 4 * 10, Colors.green[900]),
        _ChartData(85, 4000 * 5 * 4 * 10, Colors.green[900]),
        _ChartData(90, 6000 * 5 * 4 * 10, Colors.greenAccent[700]),
        _ChartData(95, 8000 * 5 * 4 * 10, Colors.greenAccent[700]),
        _ChartData(100, 10000 * 5 * 4 * 10, Colors.greenAccent[800]),
      ];
    } else if (time == Time.all) {
      chartData = <_ChartData>[
        _ChartData(5, 4000 * 6 * 4 * 10 * 2, Colors.green[100]),
        _ChartData(10, 6000 * 7 * 4 * 11 * 2, Colors.green[200]),
        _ChartData(15, 8000 * 7 * 4 * 12 * 2, Colors.green[200]),
        _ChartData(20, 10000 * 7 * 4 * 10 * 2, Colors.green[300]),
        _ChartData(25, 80000 * 6 * 4 * 10 * 2, Colors.green[300]),
        _ChartData(30, 6000 * 7 * 4 * 11 * 2, Colors.green[400]),
        _ChartData(35, 4500 * 7 * 4 * 12 * 2, Colors.green[400]),
        _ChartData(40, 20000 * 6 * 4 * 10 * 2, Colors.green[500]),
        _ChartData(45, 40000 * 7 * 4 * 12 * 2, Colors.green[500]),
        _ChartData(50, 60000 * 6 * 4 * 10 * 2, Colors.green[600]),
        _ChartData(55, 80000 * 6 * 4 * 12 * 2, Colors.green[600]),
        _ChartData(60, 10000 * 8 * 4 * 10 * 2, Colors.green[700]),
        _ChartData(65, 80000 * 8 * 4 * 10 * 2, Colors.green[700]),
        _ChartData(70, 60000 * 6 * 4 * 10 * 2, Colors.green[800]),
        _ChartData(75, 40000 * 6 * 4 * 9 * 2, Colors.green[800]),
        _ChartData(80, 2000 * 5 * 4 * 10 * 2, Colors.green[900]),
        _ChartData(85, 4000 * 5 * 4 * 12 * 2, Colors.green[900]),
        _ChartData(90, 6000 * 5 * 4 * 10 * 2, Colors.greenAccent[700]),
        _ChartData(95, 8000 * 5 * 4 * 10 * 2, Colors.greenAccent[700]),
        _ChartData(100, 10000 * 5 * 4 * 10 * 2, Colors.greenAccent[800]),
      ];
    } else {
      chartData = <_ChartData>[];
    }

    return chartData;
  }

  Future<void> callbackFunction(int newIndex) async {
    setState(() {
      //_visible = false;
      for (int i = 0; i < _isSelectedTime.length; i++) {
        if (i == newIndex) {
          _isSelectedTime[i] = true;
        } else {
          _isSelectedTime[i] = false;
          switch (newIndex) {
            case 0:
              //sleep(Duration(milliseconds: 50));
              time = Time.day;
              break;
            case 1:
              time = Time.week;
              break;
            case 2:
              time = Time.month;
              break;
            case 3:
              time = Time.year;
              break;
            case 4:
              time = Time.all;
              break;
            case 5:
              break;
          }
        }
        //print(_isSelectedTime);
      }
      if (newIndex == 5) {
        final data = BottomSheetTime().makeShowModalBottomSheet(context);
        //print startDate whien Navigor.pop
        data.then((value) {
          if (value != null) {
            print(value["startDate"]);
          }
        });
      } else {
        _visible = false;
      }
    });
    _setTotalDataUsage(_values);
    await Future.delayed(Duration(milliseconds: 800));
  }
}

class _ChartData {
  _ChartData(this.pricePercent, this.runs, this.pointColor);
  final num pricePercent;
  final num runs;
  final Color? pointColor;
}

//make a function inputs time and outputs time range by subtract time from today
String getTimeRange(Time time) {
  DateTime now = DateTime.now();
  String today = '${now.year}.${now.month}.${now.day}';

  // get StartDate by subtracting time from today
  DateTime startDate = now.subtract(Duration(days: getTimeLength(time)));
  String start = '${startDate.year}.${startDate.month}.${startDate.day}';
  return '$start ~ $today';
}

String getTimeComment(Time time) {
  if (time == Time.day) {
    return '오늘 가격대 25%~50% 상품들이\n매출의 26%입니다.';
  } else if (time == Time.week) {
    return '이번주 가격대 25%~50% 상품들이\n매출의 32%입니다.';
  } else if (time == Time.month) {
    return '이번달 가격대 25%~50% 상품들이\n매출의 29%입니다.';
  } else if (time == Time.year) {
    return '올해 가격대 25%~50% 상품들이\n매출의 39%입니다.';
  } else if (time == Time.all) {
    return '가격대 25%~50% 상품들이\n총매출의 39%입니다.';
  } else {
    return '확인 불가';
  }
}
