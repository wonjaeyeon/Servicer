import 'package:flutter/material.dart';

import '../../../../../../../../data_handler/data_standards/time.dart';

mixin AChartYAxisUnit {
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

  String getValueUnit2(String value) {
    //make value to double
    double value2 = double.parse(value);
    if (value2 > 10000) {
      return '${(value2 / 10000).toStringAsFixed(1)}만원';
    } else {
      return '${value2.toStringAsFixed(1)}원';
    }
  }

  String getValueUnit(double value) {
    String result = '';
    if (value > 100000000) {
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
    return result;
  }
}
