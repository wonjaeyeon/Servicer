import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:servicer/design_standards/colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../data_handler/mapData_handler/mapData_time.dart';
import '../../data_handler/text/chart_text.dart';
import '../../design_standards/text_styles.dart';
import '../../design_standards/widget_styles.dart';
import '../../servicer_modules/shopping_mall_master.dart';
import '../../../data_handler/data_standards/time.dart';

class StackedLineChart extends StatefulWidget {
  late Time time;
  final double width;
  StackedLineChart({Key? key, required this.time, required this.width})
      : super(key: key);

  @override
  State<StackedLineChart> createState() => _StackedLineChartState();
}

class _StackedLineChartState extends State<StackedLineChart> {
  //late List<ExpenseData> _chartData;
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    widget.time = Time.day;
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
          child: Text(getTimeRange(widget.time),
              style: TextStyle(fontSize: $mediumFontSize - 2)),
        ),
        const SizedBox(
          height: 10,
        ),
        getTimeCommentWidget(widget.time),
        const SizedBox(
          height: 10,
        ),
        SfCartesianChart(
          legend: Legend(isVisible: true, position: LegendPosition.bottom),
          tooltipBehavior: _tooltipBehavior,
          series: <ChartSeries>[
            StackedAreaSeries<ExpenseData, String>(
                dataSource: getChartData(widget.time),
                xValueMapper: (ExpenseData exp, _) => exp.expenseCategory,
                yValueMapper: (ExpenseData exp, _) => exp.smartStore,
                name: '스마트스토어',
                // give opacity color
                color: mallMaster
                    .themeColorOf(Mall.NaverSmartStore)
                    .withOpacity(0.8)),
            StackedAreaSeries<ExpenseData, String>(
                dataSource: getChartData(widget.time),
                xValueMapper: (ExpenseData exp, _) => exp.expenseCategory,
                yValueMapper: (ExpenseData exp, _) => exp.zigzag,
                name: 'zigzag',
                color: mallMaster.themeColorOf(Mall.Zigzag).withOpacity(0.8)),
            StackedAreaSeries<ExpenseData, String>(
                dataSource: getChartData(widget.time),
                xValueMapper: (ExpenseData exp, _) => exp.expenseCategory,
                yValueMapper: (ExpenseData exp, _) => exp.ably,
                name: 'ably',
                color: mallMaster.themeColorOf(Mall.Ably).withOpacity(0.8)),
            StackedAreaSeries<ExpenseData, String>(
                dataSource: getChartData(widget.time),
                xValueMapper: (ExpenseData exp, _) => exp.expenseCategory,
                yValueMapper: (ExpenseData exp, _) => exp.coupang,
                name: 'coupang',
                color: mallMaster.themeColorOf(Mall.Coupang).withOpacity(0.8)),
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
      ],
    );
  }

  List<ExpenseData> getChartData(Time time) {
    List<ExpenseData> chartData = [];
    if (time == Time.day) {
      chartData = [
        ExpenseData('12:00', 35, 28, 34, 24),
        ExpenseData('13:00', 28, 24, 24, 35),
        ExpenseData('14:00', 34, 14, 35, 28),
        ExpenseData('15:00', 24, 65, 28, 34),
        ExpenseData('16:00', 35, 48, 34, 24),
        ExpenseData('17:00', 28, 24, 24, 35),
        ExpenseData('18:00', 34, 24, 25, 28),
        ExpenseData('19:00', 24, 35, 18, 34),
        ExpenseData('20:00', 35, 28, 34, 24),
        ExpenseData('21:00', 28, 34, 34, 35),
        ExpenseData('22:00', 34, 24, 55, 28),
        ExpenseData('23:00', 24, 35, 38, 34),
      ];
    } else if (time == Time.week) {
      chartData = [
        ExpenseData('1일', 320, 180, 340, 240),
        ExpenseData('2일', 220, 240, 240, 350),
        ExpenseData('3일', 440, 140, 350, 280),
        ExpenseData('4일', 340, 250, 280, 340),
        ExpenseData('5일', 550, 180, 340, 240),
        ExpenseData('6일', 480, 240, 240, 350),
        ExpenseData('7일', 640, 140, 350, 280),
      ];
    } else if (time == Time.month) {
      chartData = [
        ExpenseData('1주', 250 * 4, 280 * 4, 340 * 4, 240 * 4),
        ExpenseData('2주', 380 * 4, 340 * 4, 240 * 4, 350 * 4),
        ExpenseData('3주', 140 * 4, 240 * 4, 350 * 4, 280 * 4),
        ExpenseData('4주', 140 * 4, 350 * 4, 280 * 4, 340 * 4),
        // ExpenseData('2주', 280, 340, 240, 350),
        // ExpenseData('3주', 340, 240, 350, 280),
        // ExpenseData('4주', 240, 350, 280, 340),
      ];
    } else if (time == Time.year) {
      chartData = [
        ExpenseData('Jan', 250 * 4 * 4, 280 * 4 * 4, 340 * 4 * 4, 240 * 4 * 4),
        ExpenseData('Feb', 380 * 4 * 4, 340 * 4 * 4, 240 * 4 * 4, 350 * 4 * 4),
        ExpenseData('Mar', 140 * 4 * 4, 240 * 4 * 4, 350 * 4 * 4, 280 * 4 * 4),
        ExpenseData('Apr', 140 * 4 * 4, 350 * 4 * 4, 280 * 4 * 4, 340 * 4 * 4),
        ExpenseData('May', 250 * 4 * 4, 280 * 4 * 4, 340 * 4 * 4, 240 * 4 * 4),
        ExpenseData('Jun', 180 * 4 * 4, 340 * 4 * 4, 240 * 4 * 4, 350 * 4 * 4),
        ExpenseData('Jul', 340 * 4 * 4, 240 * 4 * 4, 350 * 4 * 4, 280 * 4 * 4),
        ExpenseData('Aug', 540 * 4 * 4, 350 * 4 * 4, 280 * 4 * 4, 340 * 4 * 4),
        ExpenseData('Sep', 350 * 4 * 4, 280 * 4 * 4, 340 * 4 * 4, 240 * 4 * 4),
        ExpenseData('Oct', 280 * 4 * 4, 340 * 4 * 4, 240 * 4 * 4, 350 * 4 * 4),
        ExpenseData('Nov', 340 * 4 * 4, 240 * 4 * 4, 350 * 4 * 4, 280 * 4 * 4),
        ExpenseData('Dec', 140 * 4 * 4, 350 * 4 * 4, 280 * 4 * 4, 340 * 4 * 4),
      ];
    } else if (time == Time.all) {
      chartData = [
        ExpenseData(
            '2021.1월', 250 * 4 * 4, 280 * 4 * 4, 340 * 4 * 4, 240 * 4 * 4),
        ExpenseData(
            '2021.2월', 380 * 4 * 4, 340 * 4 * 4, 240 * 4 * 4, 350 * 4 * 4),
        ExpenseData(
            '2021.3월', 140 * 4 * 4, 240 * 4 * 4, 350 * 4 * 4, 280 * 4 * 4),
        ExpenseData(
            '2021.4월', 140 * 4 * 4, 350 * 4 * 4, 280 * 4 * 4, 340 * 4 * 4),
        ExpenseData(
            '2021.5월', 250 * 4 * 4, 280 * 4 * 4, 340 * 4 * 4, 240 * 4 * 4),
        ExpenseData(
            '2021.6월', 180 * 4 * 4, 340 * 4 * 4, 240 * 4 * 4, 350 * 4 * 4),
        ExpenseData(
            '2021.7월', 340 * 4 * 4, 240 * 4 * 4, 350 * 4 * 4, 280 * 4 * 4),
        ExpenseData(
            '2021.8월', 540 * 4 * 4, 350 * 4 * 4, 280 * 4 * 4, 340 * 4 * 4),
        ExpenseData(
            '2021.9월', 350 * 4 * 4, 280 * 4 * 4, 340 * 4 * 4, 240 * 4 * 4),
        ExpenseData(
            '2021.10월', 280 * 4 * 4, 340 * 4 * 4, 240 * 4 * 4, 350 * 4 * 4),
        ExpenseData(
            '2021.11월', 340 * 4 * 4, 240 * 4 * 4, 350 * 4 * 4, 280 * 4 * 4),
        ExpenseData(
            '2021.12월', 140 * 4 * 4, 350 * 4 * 4, 280 * 4 * 4, 340 * 4 * 4),
        ExpenseData(
            '2022.1월', 250 * 4 * 4, 280 * 4 * 4, 340 * 4 * 4, 240 * 4 * 4),
        ExpenseData(
            '2022.2월', 380 * 4 * 4, 340 * 4 * 4, 240 * 4 * 4, 350 * 4 * 4),
        ExpenseData(
            '2022.3월', 140 * 4 * 4, 240 * 4 * 4, 350 * 4 * 4, 280 * 4 * 4),
        ExpenseData(
            '2022.4월', 140 * 4 * 4, 350 * 4 * 4, 280 * 4 * 4, 340 * 4 * 4),
        ExpenseData(
            '2022.5월', 250 * 4 * 4, 280 * 4 * 4, 340 * 4 * 4, 240 * 4 * 4),
        ExpenseData(
            '2022.6월', 180 * 4 * 4, 340 * 4 * 4, 240 * 4 * 4, 350 * 4 * 4),
        ExpenseData(
            '2022.7월', 340 * 4 * 4, 240 * 4 * 4, 350 * 4 * 4, 280 * 4 * 4),
        ExpenseData(
            '2022.8월', 540 * 4 * 4, 350 * 4 * 4, 280 * 4 * 4, 340 * 4 * 4),
        ExpenseData(
            '2022.9월', 350 * 4 * 4, 280 * 4 * 4, 340 * 4 * 4, 240 * 4 * 4),
        ExpenseData(
            '2022.10월', 280 * 4 * 4, 340 * 4 * 4, 240 * 4 * 4, 350 * 4 * 4),
        ExpenseData(
            '2022.11월', 340 * 4 * 4, 240 * 4 * 4, 350 * 4 * 4, 280 * 4 * 4),
        ExpenseData(
            '2022.12월', 140 * 4 * 4, 350 * 4 * 4, 280 * 4 * 4, 340 * 4 * 4),
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
