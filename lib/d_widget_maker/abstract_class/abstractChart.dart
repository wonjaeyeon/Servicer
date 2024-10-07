import 'package:flutter/material.dart';

import '../../data_handler/data_standards/time.dart';
import '../../design_standards/colors.dart';
import '../../design_standards/text_styles.dart';
import '../../design_standards/widget_styles.dart';
import '../../main_pages/analytics_pages/sub/bottomsheet.dart';

//make a super class for all charts

abstract class AbstractChart extends StatefulWidget {
  late Time time;
  final double width;
  AbstractChart({Key? key, required this.time, required this.width})
      : super(key: key);

  @override
  State<AbstractChart> createState() => _AbstractChartState();
}

class _AbstractChartState extends State<AbstractChart> {
  @override
  void initState() {
    widget.time = Time.day;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  List<ExpenseData> getChartData(Time time) {
    return <ExpenseData>[
      ExpenseData('A', 35, Colors.red),
      ExpenseData('B', 28, Colors.blue),
      ExpenseData('C', 34, Colors.green),
      ExpenseData('D', 8, Colors.yellow),
      ExpenseData('E', 15, Colors.orange)
    ];
  }
}

class ExpenseData {
  ExpenseData(this.x, this.y, [this.color]);
  final String x;
  final double y;
  final Color? color;
}

mixin FunctionForClass {
  //make a function inputs time and outputs time range by subtract time from today
  String getTimeRange(Time time) {
    DateTime now = DateTime.now();
    String today = '${now.year}.${now.month}.${now.day}';

    // get StartDate by subtracting time from today
    DateTime startDate = now.subtract(Duration(days: getTimeLength(time)));
    String start = '${startDate.year}.${startDate.month}.${startDate.day}';
    return '$start ~ $today';
  }

  String getValueUnit(double value) {
    if (value > 1000000) {
      return '${(value / 1000000).toStringAsFixed(1)}M';
    } else {
      return '${value.toStringAsFixed(1)}K';
    }
  }
}

class TimeClicker extends StatelessWidget {
  final List<bool> isSelectedTime;
  final Function callbackFunction;
  //make a constructor for timeclicker
  TimeClicker(
      {Key? key, required this.isSelectedTime, required this.callbackFunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: FittedBox(
        fit: BoxFit.fitWidth,
        child: ToggleButtons(
          splashColor: Colors.transparent,
          renderBorder: false,
          //borderRadius: BorderRadius.circular(15),
          constraints: BoxConstraints.expand(
            height: 25,
            width: MediaQuery.of(context).size.width * 0.13,
          ),
          color: $$Grey,
          fillColor: Colors.transparent,
          selectedColor: Colors.black,
          isSelected: isSelectedTime,
          onPressed: (int newIndex) {
            callbackFunction(newIndex);
          },
          children: [
            Ink(
                width: 26,
                height: 26,
                decoration: BoxDecoration(
                  color: isSelectedTime[0] ? $$lightGrey : Colors.transparent,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: const Center(child: Text('일'))),
            Ink(
                width: 26,
                height: 26,
                decoration: BoxDecoration(
                  color: isSelectedTime[1] ? $$lightGrey : Colors.transparent,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: const Center(child: Text('주'))),
            Ink(
                width: 26,
                height: 26,
                decoration: BoxDecoration(
                  color: isSelectedTime[2] ? $$lightGrey : Colors.transparent,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: const Center(child: Text('월'))),
            Ink(
                width: 26,
                height: 26,
                decoration: BoxDecoration(
                  color: isSelectedTime[3] ? $$lightGrey : Colors.transparent,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: const Center(child: Text('년'))),
            Ink(
                width: 38,
                height: 26,
                decoration: BoxDecoration(
                  color: isSelectedTime[4] ? $$lightGrey : Colors.transparent,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: const Center(child: Text('전체'))),
            Ink(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: isSelectedTime[5] ? $$lightGrey : Colors.transparent,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: const Center(child: Icon(Icons.calendar_month))),
          ],
        ),
      ),
    );
  }
}

mixin WidgetForClass {
  // use setstate to change the time

  Widget getTimeClicker(Time time, List<bool> _isSelectedTime, bool _visible,
      BuildContext context, Function setTime(int newIndex)) {
    return Center(
      child: FittedBox(
        fit: BoxFit.fitWidth,
        child: ToggleButtons(
          splashColor: Colors.transparent,
          renderBorder: false,
          //borderRadius: BorderRadius.circular(15),
          constraints: BoxConstraints.expand(
            height: 25,
            width: MediaQuery.of(context).size.width * 0.13,
          ),
          color: $$Grey,
          fillColor: Colors.transparent,
          selectedColor: Colors.black,
          isSelected: _isSelectedTime,
          //onPressed: setTime(_isSelectedTime.indexOf(true)),
          children: [
            Ink(
                width: 26,
                height: 26,
                decoration: BoxDecoration(
                  color: _isSelectedTime[0] ? $$lightGrey : Colors.transparent,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: const Center(child: Text('일'))),
            Ink(
                width: 26,
                height: 26,
                decoration: BoxDecoration(
                  color: _isSelectedTime[1] ? $$lightGrey : Colors.transparent,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: const Center(child: Text('주'))),
            Ink(
                width: 26,
                height: 26,
                decoration: BoxDecoration(
                  color: _isSelectedTime[2] ? $$lightGrey : Colors.transparent,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: const Center(child: Text('월'))),
            Ink(
                width: 26,
                height: 26,
                decoration: BoxDecoration(
                  color: _isSelectedTime[3] ? $$lightGrey : Colors.transparent,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: const Center(child: Text('년'))),
            Ink(
                width: 38,
                height: 26,
                decoration: BoxDecoration(
                  color: _isSelectedTime[4] ? $$lightGrey : Colors.transparent,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: const Center(child: Text('전체'))),
            Ink(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: _isSelectedTime[5] ? $$lightGrey : Colors.transparent,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: const Center(child: Icon(Icons.calendar_month))),
          ],
        ),
      ),
    );
  }
}
