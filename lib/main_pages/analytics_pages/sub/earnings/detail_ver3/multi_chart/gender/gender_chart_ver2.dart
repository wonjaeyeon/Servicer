import 'package:flutter/material.dart';
import 'package:servicer/design_standards/colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../../../data_handler/data_standards/time.dart';
import '../../../../../../../data_handler/mapData_handler/mapData_time.dart';
import '../../../../../../../data_handler/text/chart_text.dart';
import '../../../../../../../design_standards/text_styles.dart';
import '../../../../../../../design_standards/widget_styles.dart';
import '../../../../../../../servicer_modules/shopping_mall_master.dart';
import '../../../../bottomsheet.dart';
import '../../../abstract_class/abstractChart.dart';
import 'sub/sub_chart_unuse/age_chart_old.dart';

class GenderAnalysisChartV2 extends StatefulWidget {
  final double width;
  const GenderAnalysisChartV2({Key? key, required this.width})
      : super(key: key);

  @override
  State<GenderAnalysisChartV2> createState() => _GenderAnalysisChartV2State();
}

class _GenderAnalysisChartV2State extends State<GenderAnalysisChartV2> {
  //late List<ExpenseData> _chartData;
  late Time time;
  late TooltipBehavior _tooltipBehavior;
  List<bool> _isSelectedTime = [true, false, false, false, false, false];
  // AnimatedOpacity를 위한 변수
  bool _visible = true;

  @override
  void initState() {
    time = Time.day;
    _tooltipBehavior = TooltipBehavior(enable: true, color: $$Grey, opacity: 1);
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
        Padding(
          padding: $AnalyticsPageHorizontalPadding,
          child: Text("2022.01.01 ~ 2022.12.31",
              style: TextStyle(fontSize: $mediumFontSize - 2)),
        ),
        const SizedBox(
          height: 10,
        ),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Padding(
              padding: $AnalyticsPageHorizontalPadding,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    child: Transform.scale(
                        scale: 1.6,
                        child: Icon(
                          Icons.man,
                          color: Colors.blue,
                        )),
                    width: 45,
                    height: 45,
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  Text(
                    "남성 소비자가 전체의 46% 차지합니다.",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              )),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          // width: widget.width * 0.6,
          // height: widget.width * 0.6,
          child: SfCircularChart(
            //title: ChartTitle(text: 'Composition of ocean water'),
            legend: Legend(
                isVisible: true,
                position: LegendPosition.bottom,
                overflowMode: LegendItemOverflowMode.wrap),
            series: _getDefaultDoughnutSeries(),
            tooltipBehavior: _tooltipBehavior,
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

  List<ExpenseData> getChartData(Time time) {
    List<ExpenseData> chartData = [];
    if (time == Time.day) {
      chartData = [
        ExpenseData('12:00', 35, 28),
        ExpenseData('13:00', 28, 34),
        ExpenseData('14:00', 34, 30),
        ExpenseData('15:00', 30, 32),
        ExpenseData('16:00', 32, 35),
        ExpenseData('17:00', 35, 40),
        ExpenseData('18:00', 40, 32),
        ExpenseData('19:00', 32, 35),
        ExpenseData('20:00', 35, 30),
        ExpenseData('21:00', 30, 32),
        ExpenseData('22:00', 32, 28),
        ExpenseData('23:00', 28, 34),
      ];
    } else if (time == Time.week) {
      chartData = [
        ExpenseData('1일', 350, 280),
        ExpenseData('2일', 280, 340),
        ExpenseData('3일', 340, 300),
        ExpenseData('4일', 300, 320),
        ExpenseData('5일', 320, 350),
        ExpenseData('6일', 350, 400),
        ExpenseData('7일', 400, 320),
      ];
    } else if (time == Time.month) {
      chartData = [
        ExpenseData('1주', 350 * 4, 280 * 4),
        ExpenseData('2주', 280 * 4, 340 * 4),
        ExpenseData('3주', 340 * 4, 300 * 4),
        ExpenseData('4주', 300 * 4, 320 * 4),
        // ExpenseData('5주', 320 * 4, 350 * 4),
        // ExpenseData('6주', 350 * 4, 400 * 4),
        // ExpenseData('7주', 400 * 4, 320 * 4),
        // ExpenseData('8주', 320 * 4, 350 * 4),
        // ExpenseData('9주', 350 * 4, 300 * 4),
      ];
    } else if (time == Time.year) {
      chartData = [
        ExpenseData('Jan', 350 * 4 * 4, 280 * 4 * 4),
        ExpenseData('Feb', 280 * 4 * 4, 340 * 4 * 4),
        ExpenseData('Mar', 340 * 4 * 4, 300 * 4 * 4),
        ExpenseData('Apr', 300 * 4 * 4, 320 * 4 * 4),
        ExpenseData('May', 320 * 4 * 4, 350 * 4 * 4),
        ExpenseData('Jun', 350 * 4 * 4, 400 * 4 * 4),
        ExpenseData('Jul', 400 * 4 * 4, 320 * 4 * 4),
        ExpenseData('Aug', 320 * 4 * 4, 350 * 4 * 4),
        ExpenseData('Sep', 350 * 4 * 4, 300 * 4 * 4),
        ExpenseData('Oct', 300 * 4 * 4, 320 * 4 * 4),
        ExpenseData('Nov', 320 * 4 * 4, 280 * 4 * 4),
        ExpenseData('Dec', 280 * 4 * 4, 340 * 4 * 4),
      ];
    } else if (time == Time.all) {
      chartData = [
        ExpenseData('2021.1월', 350 * 4 * 4, 280 * 4 * 4),
        ExpenseData('2021.2월', 280 * 4 * 4, 340 * 4 * 4),
        ExpenseData('2021.3월', 340 * 4 * 4, 300 * 4 * 4),
        ExpenseData('2021.4월', 300 * 4 * 4, 320 * 4 * 4),
        ExpenseData('2021.5월', 320 * 4 * 4, 350 * 4 * 4),
        ExpenseData('2021.6월', 350 * 4 * 4, 400 * 4 * 4),
        ExpenseData('2021.7월', 400 * 4 * 4, 320 * 4 * 4),
        ExpenseData('2021.8월', 320 * 4 * 4, 350 * 4 * 4),
        ExpenseData('2021.9월', 350 * 4 * 4, 300 * 4 * 4),
        ExpenseData('2021.10월', 300 * 4 * 4, 320 * 4 * 4),
        ExpenseData('2021.11월', 320 * 4 * 4, 280 * 4 * 4),
        ExpenseData('2021.12월', 280 * 4 * 4, 340 * 4 * 4),
        ExpenseData('2022.1월', 340 * 4 * 4, 300 * 4 * 4),
        ExpenseData('2022.2월', 300 * 4 * 4, 320 * 4 * 4),
        ExpenseData('2022.3월', 320 * 4 * 4, 350 * 4 * 4),
        ExpenseData('2022.4월', 350 * 4 * 4, 400 * 4 * 4),
        ExpenseData('2022.5월', 400 * 4 * 4, 320 * 4 * 4),
        ExpenseData('2022.6월', 320 * 4 * 4, 350 * 4 * 4),
        ExpenseData('2022.7월', 350 * 4 * 4, 300 * 4 * 4),
        ExpenseData('2022.8월', 300 * 4 * 4, 320 * 4 * 4),
        ExpenseData('2022.9월', 320 * 4 * 4, 280 * 4 * 4),
        ExpenseData('2022.10월', 280 * 4 * 4, 340 * 4 * 4),
        ExpenseData('2022.11월', 340 * 4 * 4, 300 * 4 * 4),
        ExpenseData('2022.12월', 300 * 4 * 4, 320 * 4 * 4),
      ];
    } else {
      chartData = [
        ExpenseData('Jan', 35, 28),
        ExpenseData('Feb', 28, 34),
        ExpenseData('Mar', 34, 30),
        ExpenseData('Apr', 30, 32),
        ExpenseData('May', 32, 35),
        ExpenseData('Jun', 35, 40),
      ];
    }

    return chartData;
  }

  /// Returns the doughnut series which need to be render.
  List<DoughnutSeries<ChartSampleData, String>> _getDefaultDoughnutSeries() {
    return <DoughnutSeries<ChartSampleData, String>>[
      DoughnutSeries<ChartSampleData, String>(
          animationDuration: 0,
          radius: '80%',
          //explode: true,
          //explodeOffset: '10%',
          dataSource: <ChartSampleData>[
            ChartSampleData(x: '남자', y: 55, text: '55%'),
            ChartSampleData(x: '여자', y: 31, text: '31%'),
          ],
          xValueMapper: (ChartSampleData data, _) => data.x as String,
          yValueMapper: (ChartSampleData data, _) => data.y,
          dataLabelMapper: (ChartSampleData data, _) => data.text,
          dataLabelSettings: const DataLabelSettings(isVisible: true))
    ];
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

//make a function inputs time and outputs time range by subtract time from today
String getTimeRange(Time time) {
  DateTime now = DateTime.now();
  String today = '${now.year}.${now.month}.${now.day}';

  // get StartDate by subtracting time from today
  DateTime startDate = now.subtract(Duration(days: getTimeLength(time)));
  String start = '${startDate.year}.${startDate.month}.${startDate.day}';
  return '$start ~ $today';
}
