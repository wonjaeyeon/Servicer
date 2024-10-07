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
import 'sub/analysis/shopping_mall_chart_analysis.dart';
import 'sub/multi_view/_multi_view_chart_maker/multi_view_chart.dart';

class MallAnalysisChart extends StatefulWidget {
  final double width;
  MallAnalysisChart({Key? key, required this.width}) : super(key: key);

  @override
  State<MallAnalysisChart> createState() => _MallAnalysisChartState();
}

class _MallAnalysisChartState extends State<MallAnalysisChart>
    with FunctionForClass {
  //late List<ExpenseData> _chartData;
  late Time time;
  late TooltipBehavior _tooltipBehavior;
  List<bool> _isSelectedTime = [true, false, false, false, false, false];
  // AnimatedOpacity를 위한 변수
  bool _visible = true;

  @override
  void initState() {
    time = Time.day;
    //_chartData = getChartData();
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
        getTimeCommentWidget(time),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: SfCartesianChart(
            legend: Legend(isVisible: true, position: LegendPosition.bottom),
            tooltipBehavior: _tooltipBehavior,
            series: <ChartSeries>[
              StackedAreaSeries<ExpenseData, String>(
                  dataSource: getChartData(time),
                  xValueMapper: (ExpenseData exp, _) => exp.expenseCategory,
                  yValueMapper: (ExpenseData exp, _) => exp.smartStore,
                  name: '스마트스토어',
                  // give opacity color
                  color: mallMaster
                      .themeColorOf(Mall.NaverSmartStore)
                      .withOpacity(0.8)),
              StackedAreaSeries<ExpenseData, String>(
                  dataSource: getChartData(time),
                  xValueMapper: (ExpenseData exp, _) => exp.expenseCategory,
                  yValueMapper: (ExpenseData exp, _) => exp.zigzag,
                  name: 'zigzag',
                  color: mallMaster.themeColorOf(Mall.Zigzag).withOpacity(0.8)),
              StackedAreaSeries<ExpenseData, String>(
                  dataSource: getChartData(time),
                  xValueMapper: (ExpenseData exp, _) => exp.expenseCategory,
                  yValueMapper: (ExpenseData exp, _) => exp.ably,
                  name: 'ably',
                  color: mallMaster.themeColorOf(Mall.Ably).withOpacity(0.8)),
              StackedAreaSeries<ExpenseData, String>(
                  dataSource: getChartData(time),
                  xValueMapper: (ExpenseData exp, _) => exp.expenseCategory,
                  yValueMapper: (ExpenseData exp, _) => exp.coupang,
                  name: 'coupang',
                  color:
                      mallMaster.themeColorOf(Mall.Coupang).withOpacity(0.8)),
            ],
            primaryXAxis: CategoryAxis(
              labelStyle: const TextStyle(fontFamily: 'IBMPlexSansKR'),
            ),
            primaryYAxis: NumericAxis(
              isVisible: true,
              opposedPosition: true,

              axisLabelFormatter: (axisLabelRenderArgs) => ChartAxisLabel(
                  getValueUnit(axisLabelRenderArgs.value.toDouble()),
                  TextStyle(
                    fontFamily: 'IBMPlexSansKR',
                    fontSize: $smallFontSize,
                  )),

              //maximum: 26,
              labelStyle: const TextStyle(fontFamily: 'IBMPlexSansKR'),
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
        SMChartAnalysis(
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
        ExpenseData('12:00', 35000, 28000, 34000, 24000),
        ExpenseData('13:00', 28000, 24000, 24000, 35000),
        ExpenseData('14:00', 34000, 14000, 35000, 28000),
        ExpenseData('15:00', 24000, 65000, 28000, 34000),
        ExpenseData('16:00', 35000, 48000, 34000, 24000),
        ExpenseData('17:00', 28000, 24000, 24000, 35000),
        ExpenseData('18:00', 34000, 24000, 25000, 28000),
        ExpenseData('19:00', 24000, 35000, 18000, 34000),
        ExpenseData('20:00', 35000, 28000, 34000, 24000),
        ExpenseData('21:00', 28000, 34000, 34000, 35000),
        ExpenseData('22:00', 34000, 24000, 55000, 28000),
        ExpenseData('23:00', 24000, 35000, 38000, 34000),
      ];
    } else if (time == Time.week) {
      chartData = [
        ExpenseData('1일', 320000, 180000, 340000, 240000),
        ExpenseData('2일', 220000, 240000, 240000, 350000),
        ExpenseData('3일', 440000, 140000, 350000, 280000),
        ExpenseData('4일', 340000, 250000, 280000, 340000),
        ExpenseData('5일', 550000, 180000, 340000, 240000),
        ExpenseData('6일', 480000, 240000, 240000, 350000),
        ExpenseData('7일', 640000, 140000, 350000, 280000),
      ];
    } else if (time == Time.month) {
      chartData = [
        ExpenseData('1주', 250 * 4 * 1000, 280 * 4 * 1000, 340 * 4 * 1000,
            240 * 4 * 1000),
        ExpenseData('2주', 380 * 4 * 1000, 340 * 4 * 1000, 240 * 4 * 1000,
            350 * 4 * 1000),
        ExpenseData('3주', 140 * 4 * 1000, 240 * 4 * 1000, 350 * 4 * 1000,
            280 * 4 * 1000),
        ExpenseData('4주', 140 * 4 * 1000, 350 * 4 * 1000, 280 * 4 * 1000,
            340 * 4 * 1000),
        // ExpenseData('2주', 280, 340, 240, 350),
        // ExpenseData('3주', 340, 240, 350, 280),
        // ExpenseData('4주', 240, 350, 280, 340),
      ];
    } else if (time == Time.year) {
      chartData = [
        ExpenseData('Jan', 250 * 4 * 4 * 1000, 280 * 4 * 4 * 1000,
            340 * 4 * 4 * 1000, 240 * 4 * 4 * 1000),
        ExpenseData('Feb', 380 * 4 * 4 * 1000, 340 * 4 * 4 * 1000,
            240 * 4 * 4 * 1000, 350 * 4 * 4 * 1000),
        ExpenseData('Mar', 140 * 4 * 4 * 1000, 240 * 4 * 4 * 1000,
            350 * 4 * 4 * 1000, 280 * 4 * 4 * 1000),
        ExpenseData('Apr', 140 * 4 * 4 * 1000, 350 * 4 * 4 * 1000,
            280 * 4 * 4 * 1000, 340 * 4 * 4 * 1000),
        ExpenseData('May', 250 * 4 * 4 * 1000, 280 * 4 * 4 * 1000,
            340 * 4 * 4 * 1000, 240 * 4 * 4 * 1000),
        ExpenseData('Jun', 180 * 4 * 4 * 1000, 340 * 4 * 4 * 1000,
            240 * 4 * 4 * 1000, 350 * 4 * 4 * 1000),
        ExpenseData('Jul', 340 * 4 * 4 * 1000, 240 * 4 * 4 * 1000,
            350 * 4 * 4 * 1000, 280 * 4 * 4 * 1000),
        ExpenseData('Aug', 540 * 4 * 4 * 1000, 350 * 4 * 4 * 1000,
            280 * 4 * 4 * 1000, 340 * 4 * 4 * 1000),
        ExpenseData('Sep', 350 * 4 * 4 * 1000, 280 * 4 * 4 * 1000,
            340 * 4 * 4 * 1000, 240 * 4 * 4 * 1000),
        ExpenseData('Oct', 280 * 4 * 4 * 1000, 340 * 4 * 4 * 1000,
            240 * 4 * 4 * 1000, 350 * 4 * 4 * 1000),
        ExpenseData('Nov', 340 * 4 * 4 * 1000, 240 * 4 * 4 * 1000,
            350 * 4 * 4 * 1000, 280 * 4 * 4 * 1000),
        ExpenseData('Dec', 140 * 4 * 4 * 1000, 350 * 4 * 4 * 1000,
            280 * 4 * 4 * 1000, 340 * 4 * 4 * 1000),
      ];
    } else if (time == Time.all) {
      chartData = [
        ExpenseData('2021.1월', 250 * 4 * 4 * 1000, 280 * 4 * 4 * 1000,
            340 * 4 * 4 * 1000, 240 * 4 * 4 * 1000),
        ExpenseData('2021.2월', 380 * 4 * 4 * 1000, 340 * 4 * 4 * 1000,
            240 * 4 * 4 * 1000, 350 * 4 * 4 * 1000),
        ExpenseData('2021.3월', 140 * 4 * 4 * 1000, 240 * 4 * 4 * 1000,
            350 * 4 * 4 * 1000, 280 * 4 * 4 * 1000),
        ExpenseData('2021.4월', 140 * 4 * 4 * 1000, 350 * 4 * 4 * 1000,
            280 * 4 * 4 * 1000, 340 * 4 * 4 * 1000),
        ExpenseData('2021.5월', 250 * 4 * 4 * 1000, 280 * 4 * 4 * 1000,
            340 * 4 * 4 * 1000, 240 * 4 * 4 * 1000),
        ExpenseData('2021.6월', 180 * 4 * 4 * 1000, 340 * 4 * 4 * 1000,
            240 * 4 * 4 * 1000, 350 * 4 * 4 * 1000),
        ExpenseData('2021.7월', 340 * 4 * 4 * 1000, 240 * 4 * 4 * 1000,
            350 * 4 * 4 * 1000, 280 * 4 * 4 * 1000),
        ExpenseData('2021.8월', 540 * 4 * 4 * 1000, 350 * 4 * 4 * 1000,
            280 * 4 * 4 * 1000, 340 * 4 * 4 * 1000),
        ExpenseData('2021.9월', 350 * 4 * 4 * 1000, 280 * 4 * 4 * 1000,
            340 * 4 * 4 * 1000, 240 * 4 * 4 * 1000),
        ExpenseData('2021.10월', 280 * 4 * 4 * 1000, 340 * 4 * 4 * 1000,
            240 * 4 * 4 * 1000, 350 * 4 * 4 * 1000),
        ExpenseData('2021.11월', 340 * 4 * 4 * 1000, 240 * 4 * 4 * 1000,
            350 * 4 * 4 * 1000, 280 * 4 * 4 * 1000),
        ExpenseData('2021.12월', 140 * 4 * 4 * 1000, 350 * 4 * 4 * 1000,
            280 * 4 * 4 * 1000, 340 * 4 * 4 * 1000),
        ExpenseData('2022.1월', 250 * 4 * 4 * 1000, 280 * 4 * 4 * 1000,
            340 * 4 * 4 * 1000, 240 * 4 * 4 * 1000),
        ExpenseData('2022.2월', 380 * 4 * 4 * 1000, 340 * 4 * 4 * 1000,
            240 * 4 * 4 * 1000, 350 * 4 * 4 * 1000),
        ExpenseData('2022.3월', 140 * 4 * 4 * 1000, 240 * 4 * 4 * 1000,
            350 * 4 * 4 * 1000, 280 * 4 * 4 * 1000),
        ExpenseData('2022.4월', 140 * 4 * 4 * 1000, 350 * 4 * 4 * 1000,
            280 * 4 * 4 * 1000, 340 * 4 * 4 * 1000),
        ExpenseData('2022.5월', 250 * 4 * 4 * 1000, 280 * 4 * 4 * 1000,
            340 * 4 * 4 * 1000, 240 * 4 * 4 * 1000),
        ExpenseData('2022.6월', 180 * 4 * 4 * 1000, 340 * 4 * 4 * 1000,
            240 * 4 * 4 * 1000, 350 * 4 * 4 * 1000),
        ExpenseData('2022.7월', 340 * 4 * 4 * 1000, 240 * 4 * 4 * 1000,
            350 * 4 * 4 * 1000, 280 * 4 * 4 * 1000),
        ExpenseData('2022.8월', 540 * 4 * 4 * 1000, 350 * 4 * 4 * 1000,
            280 * 4 * 4 * 1000, 340 * 4 * 4 * 1000),
        ExpenseData('2022.9월', 350 * 4 * 4 * 1000, 280 * 4 * 4 * 1000,
            340 * 4 * 4 * 1000, 240 * 4 * 4 * 1000),
        ExpenseData('2022.10월', 280 * 4 * 4 * 1000, 340 * 4 * 4 * 1000,
            240 * 4 * 4 * 1000, 350 * 4 * 4 * 1000),
        ExpenseData('2022.11월', 340 * 4 * 4 * 1000, 240 * 4 * 4 * 1000,
            350 * 4 * 4 * 1000, 280 * 4 * 4 * 1000),
        ExpenseData('2022.12월', 140 * 4 * 4 * 1000, 350 * 4 * 4 * 1000,
            280 * 4 * 4 * 1000, 340 * 4 * 4 * 1000),
      ];
    } else {
      chartData = [
        ExpenseData('1일', 350, 280, 340, 240),
        ExpenseData('2일', 280, 340, 240, 350),
        ExpenseData('3일', 340, 240, 350, 280),
        ExpenseData('4일', 240, 350, 280, 340),
        ExpenseData('5일', 350, 280, 340, 240),
        ExpenseData('6일', 280, 340, 240, 350),
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
  ExpenseData(this.expenseCategory, this.smartStore, this.zigzag, this.ably,
      this.coupang);
  final String expenseCategory;
  final num smartStore;
  final num zigzag;
  final num ably;
  final num coupang;
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

Widget getCommentMallIcon(Mall mall) {
  if (mall == Mall.NaverSmartStore) {
    return mallMaster.smallImgOf(Mall.NaverSmartStore);
  } else if (mall == Mall.Zigzag) {
    return mallMaster.smallImgOf(Mall.Zigzag);
  } else if (mall == Mall.Ably) {
    return mallMaster.smallImgOf(Mall.Ably);
  } else if (mall == Mall.Coupang) {
    return mallMaster.smallImgOf(Mall.Coupang);
  } else {
    return Container(
      color: $$Grey,
    );
  }
}

Widget getTimeCommentWidget(Time time) {
  return FittedBox(
    fit: BoxFit.scaleDown,
    child: Padding(
        padding: $AnalyticsPageHorizontalPadding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //어떻게 바뀌는지 보기 위한 임시 코드(나중에 수정)
            SizedBox(
              child: time == Time.day
                  ? getCommentMallIcon(Mall.NaverSmartStore)
                  : getCommentMallIcon(Mall.Zigzag),
              width: 45,
              height: 45,
            ),
            const SizedBox(
              width: 6,
            ),
            Text(
              getTimeComment(time),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        )),
  );
}

// String getValueUnit(double value) {
//   if (value > 1000000) {
//     return '${(value / 1000000).toStringAsFixed(1)}M';
//   } else {
//     return '${value.toStringAsFixed(1)}K';
//   }
// }
