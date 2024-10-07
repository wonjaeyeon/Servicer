import 'package:flutter/material.dart';
import 'package:servicer/design_standards/colors.dart';
import 'package:servicer/main_pages/analytics_pages/sub/earnings/composition/multi_chart/product_price/sub/multi_view/_multi_view_chart_maker/multi_view_chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../../../../data_handler/data_standards/category.dart';
import '../../../../../../../data_handler/data_standards/time.dart';
import '../../../../../../../data_handler/mapData_handler/mapData_time.dart';
import '../../../../../../../data_handler/text/chart_text.dart';
import '../../../../../../../design_standards/text_styles.dart';
import '../../../../../../../design_standards/widget_styles.dart';
import '../../../../../../../servicer_modules/shopping_mall_master.dart';
import '../../../../bottomsheet.dart';
import '../../../abstract_class/abstractChart.dart';
import 'g_data_handler/y_axis_unit.dart';
import 'sub/analysis/gender_chart_analysis.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import 'sub/multi_view/_multi_view_chart_maker/multi_view_chart.dart';
import 'sub/sub_chart/_sub_chart_maker/multi_view_chart.dart';

class GenderAnalysisChartV3 extends StatefulWidget {
  final double width;
  const GenderAnalysisChartV3({Key? key, required this.width})
      : super(key: key);

  @override
  State<GenderAnalysisChartV3> createState() => _GenderAnalysisChartV3State();
}

class _GenderAnalysisChartV3State extends State<GenderAnalysisChartV3>
    with GChartYAxisUnit {
  //late List<ExpenseData> _chartData;
  late Time time;
  late TooltipBehavior _tooltipBehavior;
  List<bool> _isSelectedTime = [true, false, false, false, false, false];
  // AnimatedOpacity를 위한 변수
  bool _visible = true;
  final items = ['총비율', '나이', '입점몰', '날짜'];
  String selectedValue = '총비율';
  late SubChartType subChartType;
  late ZoomMode _zoomModeType;
  late ZoomPanBehavior _zoomPanBehavior;

  @override
  void initState() {
    time = Time.day;
    subChartType = SubChartType.age;
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
    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        const SizedBox(
          height: 10,
        ),
        //현재 그래프 기간
        Row(
          children: [
            Padding(
              padding: $AnalyticsPageHorizontalPadding,
              child: Text(getTimeRange(time),
                  style: TextStyle(fontSize: $mediumFontSize - 2)),
            ),
            const Spacer(),
            //dropBox
            Align(
              alignment: Alignment.topRight,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),

                // dropdown below..
                child: DropdownButton2<String>(
                  buttonDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    //give border color
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    ),
                    color: Colors.white,
                  ),
                  value: selectedValue,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedValue = newValue!;
                    });
                  },
                  items: items
                      .map<DropdownMenuItem<String>>(
                          (String value) => DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              ))
                      .toList(),

                  // add extra sugar..
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 42,
                  underline: SizedBox(),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),

        const SizedBox(
          height: 10,
        ),

        TrendSubChartViewChart(
          time: time,
          subViewType: selectedValue,
        ),
        TimeClicker(
          isSelectedTime: _isSelectedTime,
          callbackFunction: callbackFunction,
        ),
        const SizedBox(
          height: 4,
        ),
        GenderChartAnalysis(
          timeRange: getTimeRange(time),
          unit: "원",
        ),
        const SizedBox(
          height: 4,
        ),
        GenderMultiViewChart(),
        const SizedBox(
          height: 10,
        ),
      ],
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
        ChartSampleData(x: 'Jan', maleValue: 26, femaleValue: -10),
        ChartSampleData(x: 'Feb', maleValue: 28, femaleValue: -15),
        ChartSampleData(x: 'Mar', maleValue: 22, femaleValue: -20),
        ChartSampleData(x: 'Apr', maleValue: 45, femaleValue: -25),
        ChartSampleData(x: 'May', maleValue: 20, femaleValue: -30),
        ChartSampleData(x: 'June', maleValue: 24, femaleValue: -35),
      ];
    } else if (time == Time.year) {
      chartData = [
        ChartSampleData(x: 'Jan', maleValue: 26, femaleValue: -10),
        ChartSampleData(x: 'Feb', maleValue: 28, femaleValue: -15),
        ChartSampleData(x: 'Mar', maleValue: 22, femaleValue: -20),
        ChartSampleData(x: 'Apr', maleValue: 45, femaleValue: -25),
        ChartSampleData(x: 'May', maleValue: 20, femaleValue: -30),
        ChartSampleData(x: 'June', maleValue: 24, femaleValue: -35),
      ];
    } else if (time == Time.all) {
      chartData = [
        ChartSampleData(x: 'Jan', maleValue: 26, femaleValue: -10),
        ChartSampleData(x: 'Feb', maleValue: 28, femaleValue: -15),
        ChartSampleData(x: 'Mar', maleValue: 22, femaleValue: -20),
        ChartSampleData(x: 'Apr', maleValue: 45, femaleValue: -25),
        ChartSampleData(x: 'May', maleValue: 20, femaleValue: -30),
        ChartSampleData(x: 'June', maleValue: 24, femaleValue: -35),
      ];
    } else {
      chartData = [
        ChartSampleData(x: 'Jan', maleValue: 26, femaleValue: -10),
        ChartSampleData(x: 'Feb', maleValue: 28, femaleValue: -15),
        ChartSampleData(x: 'Mar', maleValue: 22, femaleValue: -20),
        ChartSampleData(x: 'Apr', maleValue: 45, femaleValue: -25),
        ChartSampleData(x: 'May', maleValue: 20, femaleValue: -30),
        ChartSampleData(x: 'June', maleValue: 24, femaleValue: -35),
      ];
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
    await Future.delayed(Duration(milliseconds: 800));
  }
}

class ExpenseData {
  ExpenseData(this.expenseCategory, this.man, this.woman);
  final String expenseCategory;
  final num man;
  final num woman;
}

String getTimeComment(Time time) {
  if (time == Time.day) {
    return '오늘 수익이 매출의 46%입니다.';
  } else if (time == Time.week) {
    return '이번주 수익이 매출의 51%입니다.';
  } else if (time == Time.month) {
    return '이번달 수익이 매출의 53%입니다.';
  } else if (time == Time.year) {
    return '올해 수익이 매출의 47%입니다.';
  } else if (time == Time.all) {
    return '총수익이 총매출의 47%입니다.';
  } else {
    return '확인 불가';
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

/// Chart Sales Data
class SalesData {
  /// Holds the datapoint values like x, y, etc.,
  SalesData(this.x, this.y, [this.date, this.color]);

  /// X value of the data point
  final dynamic x;

  /// y value of the data point
  final dynamic y;

  /// color value of the data point
  final Color? color;

  /// Date time value of the data point
  final DateTime? date;
}
