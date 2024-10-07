import 'package:flutter/material.dart';

import '../../../../../data_handler/data_standards/time.dart';
import '../../../../../design_standards/colors.dart';
import '../../../../../design_standards/text_styles.dart';
import '../../../../../design_standards/widget_styles.dart';
import '../../bottomsheet.dart';

//make a super class for all charts
//checking if it is jy-december-16

abstract class AbstractAnalysisChart extends StatefulWidget {
  //late Time time;
  final double width;
  const AbstractAnalysisChart({Key? key, required this.width})
      : super(key: key);

  // @override
  // State<AbstractAnalysisChart> createState() => _AbstractAnalysisChartState();
}

abstract class AbstractAnalysisChartState<T extends AbstractAnalysisChart>
    extends State<T> {
  late Time time;
  List<bool> _isSelectedTime = [true, false, false, false, false, false];
  bool toggle = false;
  // AnimatedOpacity를 위한 변수
  bool _visible = true;

  @override
  void initState() {
    time = Time.day;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
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

mixin FunctionForClass {
  String addComma(String number) {
    String result = '';
    int count = 0;
    for (int i = number.length - 1; i >= 0; i--) {
      result = number[i] + result;
      count++;
      if (count == 3 && i != 0) {
        result = ',$result';
        count = 0;
      }
    }

    return result;
  }

  //function inputs String and outputs String with comma in each 3 numbers without decimal point
  String addCommaWithoutDecimal(String number) {
    String result = '';
    String frontresult = '';
    String backresult = '';
    int decimalIndex = 0;
    for (int i = number.length - 1; i >= 0; i--) {
      if (number[i] == '.') {
        decimalIndex = i;
        //print(number[i]);
        break;
      }
    }
    backresult = number.substring(decimalIndex, decimalIndex + 2);
    if (backresult == '.0') {
      backresult = '';
    }
    frontresult = number.substring(0, decimalIndex);
    frontresult = addComma(frontresult);
    result = frontresult + backresult;

    return "$result";
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

  String getValueUnit(double value) {
    String result = '';
    if (value >= 100000000) {
      String subResult = getValueUnit(value % 100000000);
      result =
          '${(value / 100000000).toStringAsFixed(0)}억${subResult.substring(0, subResult.length - 1)}';
    } else if (value >= 10000) {
      //check string ${(value / 10000).toStringAsFixed(1)} end with 0
      //if it ends with 0, remove 0
      String valueString = '${(value / 10000).toStringAsFixed(1)}';
      if (valueString.endsWith('0')) {
        result = addComma('${(value / 10000).toStringAsFixed(0)}') + '만';
      } else {
        result =
            addCommaWithoutDecimal('${(value / 10000).toStringAsFixed(1)}') +
                '만';
      }
    } else {
      result = addComma('${value.toStringAsFixed(0)}');
    }
    return result + "원";
  }

  String getValueUnit2(String value) {
    //make value to double
    double value2 = double.parse(value);
    if (value2 > 10000) {
      return '${(value2 / 10000).toStringAsFixed(1)}만원';
    } else {
      return '${value2.toStringAsFixed(1)}원';
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

class TimeClickerV2 extends StatelessWidget {
  final List<bool> isSelectedTime;
  final Function callbackFunction;
  //make a constructor for timeclicker
  TimeClickerV2(
      {Key? key, required this.isSelectedTime, required this.callbackFunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Align(
      alignment: Alignment.centerRight,
      child: FittedBox(
        fit: BoxFit.fitWidth,
        child: ToggleButtons(
          splashColor: Colors.transparent,
          renderBorder: false,
          //borderRadius: BorderRadius.circular(15),
          constraints: BoxConstraints.expand(
            height: 25,
            width: MediaQuery.of(context).size.width * 0.1,
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
