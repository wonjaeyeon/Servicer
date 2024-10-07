import 'package:flutter/material.dart';
import 'package:servicer/design_standards/colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../../../../data_handler/mapData_handler/mapData_time.dart';
import '../../../../../../../data_handler/text/chart_text.dart';
import '../../../../../../../design_standards/text_styles.dart';
import '../../../../../../../design_standards/widget_styles.dart';

import '../../../../../../../../data_handler/data_standards/time.dart';
import '../../../../bottomsheet.dart';
import '../../../abstract_class/abstractChart.dart';
import 'sub/analysis/total_summary_analysis.dart';
import 'sub/multi_view/_multi_view_chart_maker/multi_view_chart.dart';

class CurrencyFlowChart extends StatefulWidget {
  CurrencyFlowChart({Key? key, required double width}) : super(key: key);

  @override
  State<CurrencyFlowChart> createState() => _CurrencyFlowChartState();
}

class _CurrencyFlowChartState extends State<CurrencyFlowChart> {
  //late List<ExpenseData> _chartData;
  late Time time;
  late TooltipBehavior _tooltipBehavior;
  List<bool> _isSelectedTime = [true, false, false, false, false, false];
// AnimatedOpacity를 위한 변수
  bool _visible = true;
  @override
  void initState() {
    time = Time.day;
    //_chartData = getChartData(widget.time);
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
          child: Text(getTimeRange(time),
              style: TextStyle(fontSize: $mediumFontSize - 2)),
        ),
        const SizedBox(
          height: 10,
        ),

        Container(
          margin: EdgeInsets.symmetric(horizontal: 0),
          padding: EdgeInsets.symmetric(vertical: 16),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            // borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.transparent),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    '매출액 요약 정리',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
              SizedBox(height: 4),
            ],
          ),
        ),
        TimeClicker(
          isSelectedTime: _isSelectedTime,
          callbackFunction: callbackFunction,
        ),
        const SizedBox(
          height: 4,
        ),
        TSChartAnalysis(
          timeRange: getTimeRange(time),
          unit: "원",
        ),
        const SizedBox(
          height: 4,
        ),
        MultiViewChart(),
        const SizedBox(
          height: 10,
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
  ExpenseData(this.expenseCategory, this.profit, this.expense);
  final String expenseCategory;
  final num profit;
  final num expense;
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

String getValueUnit(double value) {
  if (value > 1000000) {
    return '${(value / 1000000).toStringAsFixed(1)}M';
  } else {
    return '${value.toStringAsFixed(1)}K';
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
