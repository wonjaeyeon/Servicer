import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../../../../../../MOD_PACKAGES/BH_touchFX/bh_touchfx.dart';
import '../../../../../../../../../../data_handler/data_standards/time.dart';
import '../../../../../../../../../../design_standards/colors.dart';
import '../../../../../../../../../../servicer_modules/shopping_mall_master.dart';

class DateSubChartContainer extends StatefulWidget {
  final double width;
  final Time time;
  const DateSubChartContainer(
      {Key? key, required this.time, required this.width})
      : super(key: key);

  @override
  DateSubChartContainerState createState() => DateSubChartContainerState();
}

class DateSubChartContainerState extends State<DateSubChartContainer> {
  late TooltipBehavior _tooltipBehavior;

  @override
  initState() {
    _tooltipBehavior = TooltipBehavior(enable: true, color: $$Grey, opacity: 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: SfCartesianChart(
        legend: Legend(isVisible: true, position: LegendPosition.bottom),
        tooltipBehavior: _tooltipBehavior,
        series: <ChartSeries>[
          StackedColumnSeries<ExpenseData, String>(
            groupName: "남자",
            spacing: 0.2,
            dataSource: getChartData(widget.time),
            xValueMapper: (ExpenseData exp, _) => exp.expenseCategory,
            yValueMapper: (ExpenseData exp, _) => exp.man,
            name: '남자',
            color: Colors.blueAccent,
            borderRadius: BorderRadius.circular(10),
            //sortingOrder: SortingOrder.descending,
          ),
          StackedColumnSeries<ExpenseData, String>(
            groupName: "여자",
            spacing: 0.2,
            dataSource: getChartData(widget.time),
            xValueMapper: (ExpenseData exp, _) => exp.expenseCategory,
            yValueMapper: (ExpenseData exp, _) => exp.woman,
            name: '여자',
            color: Color.fromARGB(255, 255, 114, 161),
            borderRadius: BorderRadius.circular(10),
            //sortingOrder: SortingOrder.descending,
          ),
        ],
        primaryXAxis: CategoryAxis(
          labelStyle: const TextStyle(fontFamily: 'IBMPlexSansKR'),
        ),
        primaryYAxis: NumericAxis(
          labelFormat: '{value}',
          opposedPosition: true,
          labelStyle: const TextStyle(fontFamily: 'IBMPlexSansKR'),
        ),
      ),
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
}

class ExpenseData {
  ExpenseData(this.expenseCategory, this.man, this.woman);
  final String expenseCategory;
  final num man;
  final num woman;
}
