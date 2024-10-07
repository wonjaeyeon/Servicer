import 'package:flutter/material.dart';
import 'package:servicer/design_standards/colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../data_handler/mapData_handler/mapData_time.dart';
import '../../data_handler/text/chart_text.dart';
import '../../design_standards/text_styles.dart';
import '../../design_standards/widget_styles.dart';
import '../../servicer_modules/shopping_mall_master.dart';
import '../../../data_handler/data_standards/time.dart';

class ProductPriceChart extends StatefulWidget {
  late Time time;
  final double width;
  ProductPriceChart({Key? key, required this.time, required this.width})
      : super(key: key);

  @override
  State<ProductPriceChart> createState() => _ProductPriceChartState();
}

class _ProductPriceChartState extends State<ProductPriceChart> {
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
        Padding(
          padding: $AnalyticsPageHorizontalPadding,
          child: Text(
            getTimeComment(widget.time),
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SfCartesianChart(
          legend: Legend(isVisible: true, position: LegendPosition.bottom),
          tooltipBehavior: _tooltipBehavior,
          series: <ChartSeries>[
            StackedColumnSeries<ExpenseData, String>(
              dataSource: getChartData(widget.time),
              xValueMapper: (ExpenseData exp, _) => exp.expenseCategory,
              yValueMapper: (ExpenseData exp, _) => exp.twentyfivePerUnder,
              name: '하위 25%',
              //color: mallMaster.themeColorOf(Mall.NavertwentyfivePerUnder)
            ),
            StackedColumnSeries<ExpenseData, String>(
              dataSource: getChartData(widget.time),
              xValueMapper: (ExpenseData exp, _) => exp.expenseCategory,
              yValueMapper: (ExpenseData exp, _) => exp.fiftyPerUnder,
              name: '25% ~ 50%',
              //color: mallMaster.themeColorOf(Mall.fiftyPerUnder)
            ),
            StackedColumnSeries<ExpenseData, String>(
              dataSource: getChartData(widget.time),
              xValueMapper: (ExpenseData exp, _) => exp.expenseCategory,
              yValueMapper: (ExpenseData exp, _) => exp.seventyfivePerUnder,
              name: '50% ~ 75%',
              //color: mallMaster.themeColorOf(Mall.seventyfivePerUnder)
            ),
            StackedColumnSeries<ExpenseData, String>(
              dataSource: getChartData(widget.time),
              xValueMapper: (ExpenseData exp, _) => exp.expenseCategory,
              yValueMapper: (ExpenseData exp, _) => exp.hundredPerUnder,
              name: '상위 25%',
              //color: mallMaster.themeColorOf(Mall.hundredPerUnder)
            ),
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
    return chartData;
  }
}

class ExpenseData {
  ExpenseData(this.expenseCategory, this.twentyfivePerUnder, this.fiftyPerUnder,
      this.seventyfivePerUnder, this.hundredPerUnder);
  final String expenseCategory;
  final num twentyfivePerUnder;
  final num fiftyPerUnder;
  final num seventyfivePerUnder;
  final num hundredPerUnder;
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
