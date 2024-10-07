import 'package:flutter/material.dart';
import 'package:servicer/design_standards/colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../../../../data_handler/mapData_handler/mapData_time.dart';
import '../../../../../../../../data_handler/text/chart_text.dart';
import '../../../../../../../../design_standards/text_styles.dart';
import '../../../../../../../../design_standards/widget_styles.dart';
import '../../../../../../../../servicer_modules/shopping_mall_master.dart';
import '../../../../../../../../../data_handler/data_standards/time.dart';
import '../../../../../bottomsheet.dart';
import '../../../../abstract_class/abstractChart.dart';
import 'sub/analysis/shopping_mall_chart_analysis.dart';
import 'sub/multi_view/_multi_view_chart_maker/multi_view_chart.dart';

class MallAnalysisChart extends StatefulWidget {
  final double width;
  MallAnalysisChart({Key? key, required this.width}) : super(key: key);

  @override
  State<MallAnalysisChart> createState() => _MallAnalysisChartState();
}

class _MallAnalysisChartState extends State<MallAnalysisChart> {
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
        // getTimeCommentWidget(time),
        // const SizedBox(
        //   height: 10,
        // ),
        Padding(
          padding: $AnalyticsPageHorizontalPadding,
          child: Text("스마트 스토어를 제외한 타 입점몰들의 매출이 너무 저조합니다.",
              style: TextStyle(fontSize: $mediumFontSize - 5)),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 5,
            child: AnimatedOpacity(
              opacity: _visible ? 1.0 : 0.0,
              duration: _visible
                  ? const Duration(milliseconds: 400)
                  : const Duration(milliseconds: 0),
              onEnd: () async => {
                await Future.delayed(const Duration(milliseconds: 400)),
                //FIXME 빠르게 누르면 오류 생김
                setState(() {
                  _visible = true;
                })
              },
              child: SfCartesianChart(
                legend:
                    Legend(isVisible: true, position: LegendPosition.bottom),
                tooltipBehavior: _tooltipBehavior,
                series: <ChartSeries>[
                  LineSeries<ExpenseData, String>(
                      dataSource: getChartData(time),
                      xValueMapper: (ExpenseData exp, _) => exp.expenseCategory,
                      yValueMapper: (ExpenseData exp, _) => exp.smartStore,
                      name: '스마트스토어',
                      // give opacity color
                      color: mallMaster
                          .themeColorOf(Mall.NaverSmartStore)
                          .withOpacity(0.8)),
                  LineSeries<ExpenseData, String>(
                      dataSource: getChartData(time),
                      xValueMapper: (ExpenseData exp, _) => exp.expenseCategory,
                      yValueMapper: (ExpenseData exp, _) => exp.zigzag,
                      name: 'zigzag',
                      color: mallMaster
                          .themeColorOf(Mall.Zigzag)
                          .withOpacity(0.8)),
                  LineSeries<ExpenseData, String>(
                      dataSource: getChartData(time),
                      xValueMapper: (ExpenseData exp, _) => exp.expenseCategory,
                      yValueMapper: (ExpenseData exp, _) => exp.ably,
                      name: 'ably',
                      color:
                          mallMaster.themeColorOf(Mall.Ably).withOpacity(0.8)),
                  LineSeries<ExpenseData, String>(
                      dataSource: getChartData(time),
                      xValueMapper: (ExpenseData exp, _) => exp.expenseCategory,
                      yValueMapper: (ExpenseData exp, _) => exp.coupang,
                      name: 'coupang',
                      color: mallMaster
                          .themeColorOf(Mall.Coupang)
                          .withOpacity(0.8)),
                ],
                primaryXAxis: CategoryAxis(
                  labelStyle: const TextStyle(fontFamily: 'IBMPlexSansKR'),
                ),
                primaryYAxis: NumericAxis(
                  labelFormat: '{value}만원',
                  opposedPosition: true,
                  labelStyle: const TextStyle(fontFamily: 'IBMPlexSansKR'),
                ),
              ),
            ),
          ),
        ),
        TimeClicker(
          isSelectedTime: _isSelectedTime,
          callbackFunction: callbackFunction,
        ),
        // const SizedBox(
        //   height: 4,
        // ),
        // SMChartAnalysis(
        //   timeRange: getTimeRange(time),
        //   unit: "원",
        // ),
        // const SizedBox(
        //   height: 4,
        // ),
        // MultiViewChart(),
        // const SizedBox(
        //   height: 10,
        // ),
      ],
    );
  }

  List<ExpenseData> getChartData(Time time) {
    List<ExpenseData> chartData = [];
    if (time == Time.day) {
      chartData = [
        ExpenseData('12:00', 350, 28, 34, 24),
        ExpenseData('13:00', 280, 24, 24, 35),
        ExpenseData('14:00', 340, 14, 35, 28),
        ExpenseData('15:00', 240, 65, 28, 34),
        ExpenseData('16:00', 350, 48, 34, 24),
        ExpenseData('17:00', 280, 24, 24, 35),
        ExpenseData('18:00', 340, 24, 25, 28),
        ExpenseData('19:00', 240, 35, 18, 34),
        ExpenseData('20:00', 350, 28, 34, 24),
        ExpenseData('21:00', 280, 34, 34, 35),
        ExpenseData('22:00', 340, 24, 55, 28),
        ExpenseData('23:00', 240, 35, 38, 34),
      ];
    } else if (time == Time.week) {
      chartData = [
        ExpenseData('1일', 3200, 180, 340, 240),
        ExpenseData('2일', 2200, 240, 240, 350),
        ExpenseData('3일', 4400, 140, 350, 280),
        ExpenseData('4일', 3400, 250, 280, 340),
        ExpenseData('5일', 5500, 180, 340, 240),
        ExpenseData('6일', 4800, 240, 240, 350),
        ExpenseData('7일', 6400, 140, 350, 280),
      ];
    } else if (time == Time.month) {
      chartData = [
        ExpenseData('1주', 2500 * 4, 280 * 4, 340 * 4, 240 * 4),
        ExpenseData('2주', 3800 * 4, 340 * 4, 240 * 4, 350 * 4),
        ExpenseData('3주', 1400 * 4, 240 * 4, 350 * 4, 280 * 4),
        ExpenseData('4주', 1400 * 4, 350 * 4, 280 * 4, 340 * 4),
        // ExpenseData('2주', 280, 340, 240, 350),
        // ExpenseData('3주', 340, 240, 350, 280),
        // ExpenseData('4주', 240, 350, 280, 340),
      ];
    } else if (time == Time.year) {
      chartData = [
        ExpenseData('Jan', 2500 * 4 * 4, 280 * 4 * 4, 340 * 4 * 4, 240 * 4 * 4),
        ExpenseData('Feb', 3800 * 4 * 4, 340 * 4 * 4, 240 * 4 * 4, 350 * 4 * 4),
        ExpenseData('Mar', 1400 * 4 * 4, 240 * 4 * 4, 350 * 4 * 4, 280 * 4 * 4),
        ExpenseData('Apr', 1400 * 4 * 4, 350 * 4 * 4, 280 * 4 * 4, 340 * 4 * 4),
        ExpenseData('May', 2500 * 4 * 4, 280 * 4 * 4, 340 * 4 * 4, 240 * 4 * 4),
        ExpenseData('Jun', 1800 * 4 * 4, 340 * 4 * 4, 240 * 4 * 4, 350 * 4 * 4),
        ExpenseData('Jul', 3400 * 4 * 4, 240 * 4 * 4, 350 * 4 * 4, 280 * 4 * 4),
        ExpenseData('Aug', 5400 * 4 * 4, 350 * 4 * 4, 280 * 4 * 4, 340 * 4 * 4),
        ExpenseData('Sep', 3500 * 4 * 4, 280 * 4 * 4, 340 * 4 * 4, 240 * 4 * 4),
        ExpenseData('Oct', 2800 * 4 * 4, 340 * 4 * 4, 240 * 4 * 4, 350 * 4 * 4),
        ExpenseData('Nov', 340 * 4 * 4, 240 * 4 * 4, 350 * 4 * 4, 280 * 4 * 4),
        ExpenseData('Dec', 140 * 4 * 4, 350 * 4 * 4, 280 * 4 * 4, 340 * 4 * 4),
      ];
    } else if (time == Time.all) {
      chartData = [
        ExpenseData(
            '2021.1월', 2500 * 4 * 4, 280 * 4 * 4, 340 * 4 * 4, 240 * 4 * 4),
        ExpenseData(
            '2021.2월', 3800 * 4 * 4, 340 * 4 * 4, 240 * 4 * 4, 350 * 4 * 4),
        ExpenseData(
            '2021.3월', 1400 * 4 * 4, 240 * 4 * 4, 350 * 4 * 4, 280 * 4 * 4),
        ExpenseData(
            '2021.4월', 1400 * 4 * 4, 350 * 4 * 4, 280 * 4 * 4, 340 * 4 * 4),
        ExpenseData(
            '2021.5월', 2500 * 4 * 4, 280 * 4 * 4, 340 * 4 * 4, 240 * 4 * 4),
        ExpenseData(
            '2021.6월', 1800 * 4 * 4, 340 * 4 * 4, 240 * 4 * 4, 350 * 4 * 4),
        ExpenseData(
            '2021.7월', 3400 * 4 * 4, 240 * 4 * 4, 350 * 4 * 4, 280 * 4 * 4),
        ExpenseData(
            '2021.8월', 5400 * 4 * 4, 350 * 4 * 4, 280 * 4 * 4, 340 * 4 * 4),
        ExpenseData(
            '2021.9월', 3500 * 4 * 4, 280 * 4 * 4, 340 * 4 * 4, 240 * 4 * 4),
        ExpenseData(
            '2021.10월', 2800 * 4 * 4, 340 * 4 * 4, 240 * 4 * 4, 350 * 4 * 4),
        ExpenseData(
            '2021.11월', 340 * 4 * 4, 240 * 4 * 4, 350 * 4 * 4, 280 * 4 * 4),
        ExpenseData(
            '2021.12월', 140 * 4 * 4, 350 * 4 * 4, 280 * 4 * 4, 340 * 4 * 4),
        ExpenseData(
            '2022.1월', 250 * 4 * 4, 280 * 4 * 4, 340 * 4 * 4, 240 * 4 * 4),
        ExpenseData(
            '2022.2월', 380 * 4 * 4, 340 * 4 * 4, 240 * 4 * 4, 350 * 4 * 4),
        ExpenseData(
            '2022.3월', 1400 * 4 * 4, 240 * 4 * 4, 350 * 4 * 4, 280 * 4 * 4),
        ExpenseData(
            '2022.4월', 1400 * 4 * 4, 350 * 4 * 4, 280 * 4 * 4, 340 * 4 * 4),
        ExpenseData(
            '2022.5월', 2500 * 4 * 4, 280 * 4 * 4, 340 * 4 * 4, 240 * 4 * 4),
        ExpenseData(
            '2022.6월', 1800 * 4 * 4, 340 * 4 * 4, 240 * 4 * 4, 350 * 4 * 4),
        ExpenseData(
            '2022.7월', 3400 * 4 * 4, 240 * 4 * 4, 350 * 4 * 4, 280 * 4 * 4),
        ExpenseData(
            '2022.8월', 5400 * 4 * 4, 350 * 4 * 4, 280 * 4 * 4, 340 * 4 * 4),
        ExpenseData(
            '2022.9월', 3500 * 4 * 4, 280 * 4 * 4, 340 * 4 * 4, 240 * 4 * 4),
        ExpenseData(
            '2022.10월', 2800 * 4 * 4, 340 * 4 * 4, 240 * 4 * 4, 350 * 4 * 4),
        ExpenseData(
            '2022.11월', 3400 * 4 * 4, 240 * 4 * 4, 350 * 4 * 4, 280 * 4 * 4),
        ExpenseData(
            '2022.12월', 1400 * 4 * 4, 350 * 4 * 4, 280 * 4 * 4, 340 * 4 * 4),
      ];
    } else {
      chartData = [
        ExpenseData('1일', 3500, 280, 340, 240),
        ExpenseData('2일', 2800, 340, 240, 350),
        ExpenseData('3일', 3400, 240, 350, 280),
        ExpenseData('4일', 2400, 350, 280, 340),
        ExpenseData('5일', 3500, 280, 340, 240),
        ExpenseData('6일', 2800, 340, 240, 350),
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

String getValueUnit(double value) {
  if (value > 1000000) {
    return '${(value / 1000000).toStringAsFixed(1)}M';
  } else {
    return '${value.toStringAsFixed(1)}K';
  }
}
