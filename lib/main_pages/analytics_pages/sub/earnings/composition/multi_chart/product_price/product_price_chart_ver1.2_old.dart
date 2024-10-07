import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:servicer/design_standards/colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../../../data_handler/mapData_handler/mapData_time.dart';
import '../../../../../../../data_handler/text/chart_text.dart';
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

class ProductPriceAnalysisChartV2 extends StatefulWidget {
  //late Time time;
  final double width;
  ProductPriceAnalysisChartV2({Key? key, required this.width})
      : super(key: key);

  @override
  State<ProductPriceAnalysisChartV2> createState() =>
      _ProductPriceAnalysisChartV2State();
}

class _ProductPriceAnalysisChartV2State
    extends State<ProductPriceAnalysisChartV2>
    with SingleTickerProviderStateMixin {
  //late List<ExpenseData> _chartData;
  late Time time;
  late TooltipBehavior _tooltipBehavior;
  List<bool> _isSelectedTime = [true, false, false, false, false, false];
  // AnimatedOpacity를 위한 변수
  bool _visible = true;

  final DateTime min = DateTime(2019, 04), max = DateTime(2019, 04, 30, 24);
  late RangeController rangeController;
  late TextEditingController textController;
  late List<_ChartData> data;
  late List<int> selectedItems;

  @override
  void initState() {
    time = Time.day;
    //_chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true, color: $$Grey, opacity: 1);
    super.initState();
    selectedItems = <int>[];
    textController = TextEditingController(text: 'Total data usage : 80GB');
    rangeController = RangeController(
      start: DateTime(2019, 04, 6),
      end: DateTime(2019, 04, 15),
    );
    data = <_ChartData>[
      _ChartData(DateTime(2019, 04), 0.2),
      _ChartData(DateTime(2019, 04, 02), 0.3),
      _ChartData(DateTime(2019, 04, 03), 0.4),
      _ChartData(DateTime(2019, 04, 04), 0.6),
      _ChartData(DateTime(2019, 04, 05), 0.8),
      _ChartData(DateTime(2019, 04, 06), 1.2),
      _ChartData(DateTime(2019, 04, 07), 1.6),
      _ChartData(DateTime(2019, 04, 08), 2.4),
      _ChartData(DateTime(2019, 04, 09), 3.2),
      _ChartData(DateTime(2019, 04, 10), 4.8),
      _ChartData(DateTime(2019, 04, 11), 6.4),
      _ChartData(DateTime(2019, 04, 12), 9.6),
      _ChartData(DateTime(2019, 04, 13), 12.8),
      _ChartData(DateTime(2019, 04, 14), 16.0),
      _ChartData(DateTime(2019, 04, 15), 22.0),
      _ChartData(DateTime(2019, 04, 16), 25.6),
      _ChartData(DateTime(2019, 04, 17), 20.0),
      _ChartData(DateTime(2019, 04, 18), 14.5),
      _ChartData(DateTime(2019, 04, 19), 12.8),
      _ChartData(DateTime(2019, 04, 20), 10.0),
      _ChartData(DateTime(2019, 04, 21), 6.6),
      _ChartData(DateTime(2019, 04, 22), 5.0),
      _ChartData(DateTime(2019, 04, 23), 3.2),
      _ChartData(DateTime(2019, 04, 24), 3.2),
      _ChartData(DateTime(2019, 04, 25), 1.6),
      _ChartData(DateTime(2019, 04, 26), 1.6),
      _ChartData(DateTime(2019, 04, 27), 0.8),
      _ChartData(DateTime(2019, 04, 28), 0.8),
      _ChartData(DateTime(2019, 04, 29), 0.4),
      _ChartData(DateTime(2019, 04, 30), 0.2)
    ];
  }

  @override
  void dispose() {
    textController.dispose();
    rangeController.dispose();
    data.clear();
    selectedItems.clear();
    super.dispose();
  }

  void _setTotalDataUsage(SfRangeValues values) {
    double dataUsage = 0;
    for (int i = 0; i < data.length; i++) {
      if (data[i].date.isAfter(
              //ignore: avoid_as
              (values.start as DateTime).subtract(const Duration(hours: 1))) &&
          data[i].date.isBefore(
              //ignore: avoid_as
              (values.end as DateTime).add(const Duration(hours: 1)))) {
        dataUsage += data[i].runs;
      }
    }
    textController.text =
        'Total data usage : ' + dataUsage.toStringAsFixed(1) + 'GB';
  }

  @override
  Widget build(BuildContext context) {
    selectedItems.clear();
    final ThemeData themeData = Theme.of(context);
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    for (int i = 0; i < data.length; i++) {
      if (data[i].date.millisecondsSinceEpoch >=
              rangeController.start.millisecondsSinceEpoch &&
          data[i].date.millisecondsSinceEpoch <=
              rangeController.end.millisecondsSinceEpoch) {
        selectedItems.add(data.indexOf(data[i]));
      }
    }

    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(bottom: 40),
          child: Center(
            child: SfRangeSelectorTheme(
              data: SfRangeSelectorThemeData(
                  brightness: themeData.colorScheme.brightness,
                  labelOffset: const Offset(0, 2),
                  thumbColor: Colors.white,
                  overlayColor: const Color.fromRGBO(0, 178, 206, 0.24),
                  activeTrackColor: const Color.fromRGBO(0, 178, 206, 1),
                  thumbStrokeColor: const Color.fromRGBO(0, 178, 206, 1),
                  thumbStrokeWidth: 2.0,
                  inactiveTrackColor: const Color.fromRGBO(194, 194, 194, 1),
                  activeLabelStyle: TextStyle(
                      fontSize: 12,
                      color: themeData.textTheme.bodyLarge!.color!
                          .withOpacity(0.87)),
                  inactiveLabelStyle: TextStyle(
                      fontSize: 12,
                      color: themeData.textTheme.bodyLarge!.color!
                          .withOpacity(0.87)),
                  inactiveRegionColor: Colors.transparent),
              child: SfRangeSelector(
                min: min,
                max: max,
                dateIntervalType: DateIntervalType.days,
                interval: 5.0,
                controller: rangeController,
                stepDuration: const SliderStepDuration(days: 1),
                dateFormat: DateFormat.MMMd(),
                showTicks: true,
                showLabels: true,
                onChanged: (SfRangeValues values) {
                  _setTotalDataUsage(values);
                },
                child: SizedBox(
                  // width: mediaQueryData.orientation == Orientation.landscape
                  //     ? model.isWebFullView
                  //         ? mediaQueryData.size.width * 0.5
                  //         : mediaQueryData.size.width
                  //     : mediaQueryData.size.width,
                  height: mediaQueryData.size.height * 0.55 - 25,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: SfCartesianChart(
                      title: ChartTitle(text: 'Data Usage For April 2019'),
                      margin: EdgeInsets.zero,
                      primaryXAxis: DateTimeAxis(
                        isVisible: false,
                        minimum: DateTime(2019, 04),
                        maximum: DateTime(2019, 05),
                        interval: 5,
                        intervalType: DateTimeIntervalType.days,
                        enableAutoIntervalOnZooming: false,
                      ),
                      primaryYAxis: NumericAxis(isVisible: false, maximum: 26),
                      plotAreaBorderWidth: 0,
                      plotAreaBackgroundColor: Colors.transparent,
                      series: <CartesianSeries<_ChartData, DateTime>>[
                        ColumnSeries<_ChartData, DateTime>(
                          width: 0.8,
                          initialSelectedDataIndexes: selectedItems,
                          selectionBehavior: SelectionBehavior(
                              enable: true,
                              unselectedOpacity: 0,
                              selectedBorderColor:
                                  const Color.fromRGBO(0, 178, 206, 1),
                              selectedColor:
                                  const Color.fromRGBO(0, 178, 206, 1),
                              unselectedColor: Colors.transparent,
                              selectionController: rangeController),
                          // dashArray:
                          //     model.isWebFullView ? null : <double>[3, 2],
                          color: const Color.fromRGBO(255, 255, 255, 0),
                          borderColor: const Color.fromRGBO(194, 194, 194, 1),
                          animationDuration: 0,
                          borderWidth: 1,
                          dataSource: data,
                          xValueMapper: (_ChartData score, _) => score.date,
                          yValueMapper: (_ChartData score, _) => score.runs,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          // padding: mediaQueryData.orientation == Orientation.landscape ||
          //         model.isWebFullView
          //     ? EdgeInsets.only(bottom: mediaQueryData.size.height * 0.025)
          //     : EdgeInsets.only(bottom: mediaQueryData.size.height * 0.1),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: 250,
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
      ],
    );
  }

  // List<ExpenseData> getChartData(Time time) {
  //   List<ExpenseData> chartData = [];
  //   if (time == Time.day) {
  //     chartData = [
  //       ExpenseData('12:00', 35, 28, 34, 24),
  //       ExpenseData('13:00', 28, 24, 24, 35),
  //       ExpenseData('14:00', 34, 14, 35, 28),
  //       ExpenseData('15:00', 24, 65, 28, 34),
  //       ExpenseData('16:00', 35, 48, 34, 24),
  //       ExpenseData('17:00', 28, 24, 24, 35),
  //       ExpenseData('18:00', 34, 24, 25, 28),
  //       ExpenseData('19:00', 24, 35, 18, 34),
  //       ExpenseData('20:00', 35, 28, 34, 24),
  //       ExpenseData('21:00', 28, 34, 34, 35),
  //       ExpenseData('22:00', 34, 24, 55, 28),
  //       ExpenseData('23:00', 24, 35, 38, 34),
  //     ];
  //   } else if (time == Time.week) {
  //     chartData = [
  //       ExpenseData('1일', 320, 180, 340, 240),
  //       ExpenseData('2일', 220, 240, 240, 350),
  //       ExpenseData('3일', 440, 140, 350, 280),
  //       ExpenseData('4일', 340, 250, 280, 340),
  //       ExpenseData('5일', 550, 180, 340, 240),
  //       ExpenseData('6일', 480, 240, 240, 350),
  //       ExpenseData('7일', 640, 140, 350, 280),
  //     ];
  //   } else if (time == Time.month) {
  //     chartData = [
  //       ExpenseData('1주', 250 * 4, 280 * 4, 340 * 4, 240 * 4),
  //       ExpenseData('2주', 380 * 4, 340 * 4, 240 * 4, 350 * 4),
  //       ExpenseData('3주', 140 * 4, 240 * 4, 350 * 4, 280 * 4),
  //       ExpenseData('4주', 140 * 4, 350 * 4, 280 * 4, 340 * 4),
  //       // ExpenseData('2주', 280, 340, 240, 350),
  //       // ExpenseData('3주', 340, 240, 350, 280),
  //       // ExpenseData('4주', 240, 350, 280, 340),
  //     ];
  //   } else if (time == Time.year) {
  //     chartData = [
  //       ExpenseData('Jan', 250 * 4 * 4, 280 * 4 * 4, 340 * 4 * 4, 240 * 4 * 4),
  //       ExpenseData('Feb', 380 * 4 * 4, 340 * 4 * 4, 240 * 4 * 4, 350 * 4 * 4),
  //       ExpenseData('Mar', 140 * 4 * 4, 240 * 4 * 4, 350 * 4 * 4, 280 * 4 * 4),
  //       ExpenseData('Apr', 140 * 4 * 4, 350 * 4 * 4, 280 * 4 * 4, 340 * 4 * 4),
  //       ExpenseData('May', 250 * 4 * 4, 280 * 4 * 4, 340 * 4 * 4, 240 * 4 * 4),
  //       ExpenseData('Jun', 180 * 4 * 4, 340 * 4 * 4, 240 * 4 * 4, 350 * 4 * 4),
  //       ExpenseData('Jul', 340 * 4 * 4, 240 * 4 * 4, 350 * 4 * 4, 280 * 4 * 4),
  //       ExpenseData('Aug', 540 * 4 * 4, 350 * 4 * 4, 280 * 4 * 4, 340 * 4 * 4),
  //       ExpenseData('Sep', 350 * 4 * 4, 280 * 4 * 4, 340 * 4 * 4, 240 * 4 * 4),
  //       ExpenseData('Oct', 280 * 4 * 4, 340 * 4 * 4, 240 * 4 * 4, 350 * 4 * 4),
  //       ExpenseData('Nov', 340 * 4 * 4, 240 * 4 * 4, 350 * 4 * 4, 280 * 4 * 4),
  //       ExpenseData('Dec', 140 * 4 * 4, 350 * 4 * 4, 280 * 4 * 4, 340 * 4 * 4),
  //     ];
  //   } else if (time == Time.all) {
  //     chartData = [
  //       ExpenseData(
  //           '2021.1월', 250 * 4 * 4, 280 * 4 * 4, 340 * 4 * 4, 240 * 4 * 4),
  //       ExpenseData(
  //           '2021.2월', 380 * 4 * 4, 340 * 4 * 4, 240 * 4 * 4, 350 * 4 * 4),
  //       ExpenseData(
  //           '2021.3월', 140 * 4 * 4, 240 * 4 * 4, 350 * 4 * 4, 280 * 4 * 4),
  //       ExpenseData(
  //           '2021.4월', 140 * 4 * 4, 350 * 4 * 4, 280 * 4 * 4, 340 * 4 * 4),
  //       ExpenseData(
  //           '2021.5월', 250 * 4 * 4, 280 * 4 * 4, 340 * 4 * 4, 240 * 4 * 4),
  //       ExpenseData(
  //           '2021.6월', 180 * 4 * 4, 340 * 4 * 4, 240 * 4 * 4, 350 * 4 * 4),
  //       ExpenseData(
  //           '2021.7월', 340 * 4 * 4, 240 * 4 * 4, 350 * 4 * 4, 280 * 4 * 4),
  //       ExpenseData(
  //           '2021.8월', 540 * 4 * 4, 350 * 4 * 4, 280 * 4 * 4, 340 * 4 * 4),
  //       ExpenseData(
  //           '2021.9월', 350 * 4 * 4, 280 * 4 * 4, 340 * 4 * 4, 240 * 4 * 4),
  //       ExpenseData(
  //           '2021.10월', 280 * 4 * 4, 340 * 4 * 4, 240 * 4 * 4, 350 * 4 * 4),
  //       ExpenseData(
  //           '2021.11월', 340 * 4 * 4, 240 * 4 * 4, 350 * 4 * 4, 280 * 4 * 4),
  //       ExpenseData(
  //           '2021.12월', 140 * 4 * 4, 350 * 4 * 4, 280 * 4 * 4, 340 * 4 * 4),
  //       ExpenseData(
  //           '2022.1월', 250 * 4 * 4, 280 * 4 * 4, 340 * 4 * 4, 240 * 4 * 4),
  //       ExpenseData(
  //           '2022.2월', 380 * 4 * 4, 340 * 4 * 4, 240 * 4 * 4, 350 * 4 * 4),
  //       ExpenseData(
  //           '2022.3월', 140 * 4 * 4, 240 * 4 * 4, 350 * 4 * 4, 280 * 4 * 4),
  //       ExpenseData(
  //           '2022.4월', 140 * 4 * 4, 350 * 4 * 4, 280 * 4 * 4, 340 * 4 * 4),
  //       ExpenseData(
  //           '2022.5월', 250 * 4 * 4, 280 * 4 * 4, 340 * 4 * 4, 240 * 4 * 4),
  //       ExpenseData(
  //           '2022.6월', 180 * 4 * 4, 340 * 4 * 4, 240 * 4 * 4, 350 * 4 * 4),
  //       ExpenseData(
  //           '2022.7월', 340 * 4 * 4, 240 * 4 * 4, 350 * 4 * 4, 280 * 4 * 4),
  //       ExpenseData(
  //           '2022.8월', 540 * 4 * 4, 350 * 4 * 4, 280 * 4 * 4, 340 * 4 * 4),
  //       ExpenseData(
  //           '2022.9월', 350 * 4 * 4, 280 * 4 * 4, 340 * 4 * 4, 240 * 4 * 4),
  //       ExpenseData(
  //           '2022.10월', 280 * 4 * 4, 340 * 4 * 4, 240 * 4 * 4, 350 * 4 * 4),
  //       ExpenseData(
  //           '2022.11월', 340 * 4 * 4, 240 * 4 * 4, 350 * 4 * 4, 280 * 4 * 4),
  //       ExpenseData(
  //           '2022.12월', 140 * 4 * 4, 350 * 4 * 4, 280 * 4 * 4, 340 * 4 * 4),
  //     ];
  //   } else {
  //     chartData = [
  //       ExpenseData('1일', 350, 280, 340, 240),
  //       ExpenseData('2일', 280, 340, 240, 350),
  //       ExpenseData('3일', 340, 240, 350, 280),
  //       ExpenseData('4일', 240, 350, 280, 340),
  //       ExpenseData('5일', 350, 280, 340, 240),
  //       ExpenseData('6일', 280, 340, 240, 350),
  //     ];
  //   }

  // final List<ExpenseData> chartData = [
  //   ExpenseData('Jan', 35, 28, 34, 32),
  //   ExpenseData('Feb', 28, 34, 32, 30),
  //   ExpenseData('Mar', 34, 30, 24, 20),
  //   ExpenseData('Apr', 30, 32, 35, 40),
  //   ExpenseData('May', 32, 35, 40, 32),
  //   ExpenseData('Jun', 35, 40, 32, 35),
  //   ExpenseData('Jul', 40, 32, 35, 28),
  //   ExpenseData('Aug', 32, 35, 28, 34),
  //   ExpenseData('Sep', 35, 30, 24, 20),
  //   ExpenseData('Oct', 30, 32, 35, 40),
  //   ExpenseData('Nov', 32, 28, 34, 32),
  //   ExpenseData('Dec', 28, 34, 32, 30),
  // ];
  //   return chartData;
  // }

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
    await Future.delayed(Duration(milliseconds: 800));
  }
}

class _ChartData {
  _ChartData(this.date, this.runs);
  final DateTime date;
  final num runs;
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

String getValueUnit(double value) {
  if (value > 1000000) {
    return '${(value / 1000000).toStringAsFixed(1)}M';
  } else {
    return '${value.toStringAsFixed(1)}K';
  }
}
