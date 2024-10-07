import '../../MOD_PACKAGES/fl_chart_svc/src/chart/base/axis_chart/axis_chart_data.dart';
import 'package:flutter/material.dart';

import '../../servicer_modules/shopping_mall_master.dart';

class ChartText {
//function inputs String and outputs String with comma in each 3 numbers
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

    return "$result만";
  }

  //function inputs MapData<String, dynamic> and outputs String of TimeRange
  String getTimeRange(Map<String, dynamic> data) {
    String timeRange = '';
    List<String> keyList = data.keys.toList();
    //make keyList[0] to String of year, month, day
    String keyString = keyList[0].replaceAll('-', '');
    String year = keyString.substring(0, 4);
    String month = keyString.substring(4, 6);
    String day = keyString.substring(6, 8);
    timeRange = '$year.$month.$day';
    //make keyList[keyList.length-1] to String of year, month, day
    keyString = keyList[keyList.length - 1].replaceAll('-', '');
    year = keyString.substring(0, 4);
    month = keyString.substring(4, 6);
    day = keyString.substring(6, 8);
    timeRange = '$timeRange ~ $year.$month.$day';
    return timeRange;
  }

  String timeRange(List<FlSpot> data) {
    double sum = 0;
    for (int i = 0; i < data.length; i++) {
      sum += data[i].y;
    }
    // make String data that data[0]'s last 0 is erased
    String startDate = data[0].x.toString().replaceAll('.', '');
    if (startDate.endsWith('0')) {
      startDate = startDate.substring(0, startDate.length - 1);
    }
    //Divide startDate into year, month, day
    String startDateYear = startDate.substring(0, 4);
    String startDateMonth = startDate.substring(4, 6);
    String startDateDay = startDate.substring(6, 8);
    startDate = "$startDateYear.$startDateMonth.$startDateDay";

    String endDate = data[data.length - 1].x.toString().replaceAll('.', '');
    if (endDate.endsWith('0')) {
      endDate = endDate.substring(0, endDate.length - 1);
    }
    //Divide endDate into year, month, day
    String endDateYear = endDate.substring(0, 4);
    String endDateMonth = endDate.substring(4, 6);
    String endDateDay = endDate.substring(6, 8);
    endDate = "$endDateYear.$endDateMonth.$endDateDay";

    // make make Text flSpot[0](x)~flSpot[data.length](x)의 합계
    String sumString = startDate + "~" + endDate;

    // plus the sumString and sum.toString()
    return sumString;
  }

//function inputs List<Flspot> data and outputs a String of sum of flspot(y)
  String sum(List<FlSpot> data, String unit) {
    double sum = 0;
    for (int i = 0; i < data.length; i++) {
      sum += data[i].y;
    }
    if (sum > 100000) {
      return "합계 : ${addCommaWithoutDecimal((sum / 10000).toString())}$unit";
    } else {
      return "합계 : ${addComma(sum.toString())}$unit";
    }
  }

//function inputs List<Flspot> data and outputs a of linear line y= ax + b that predicts the next value of y
  double gradientOfPrediction(List<FlSpot> data) {
    double sumX = 0;
    double sumY = 0;
    double sumXY = 0;
    double sumXX = 0;
    double a = 0;
    double b = 0;
    double predictY = 0;
    for (int i = 0; i < data.length; i++) {
      sumX += data[i].x;
      sumY += data[i].y;
      sumXY += data[i].x * data[i].y;
      sumXX += data[i].x * data[i].x;
    }
    a = (data.length * sumXY - sumX * sumY) /
        (data.length * sumXX - sumX * sumX);
    b = (sumY - a * sumX) / data.length;
    predictY = a * (data[data.length - 1].x + 1) + b;
    return a;
  }

//function inputs List<Flspot> data and outputs double a that is the gradient of the first spot and the last spot
  double gradientOfFirstAndLast(List<FlSpot> data) {
    double a = 0;
    a = (data[data.length - 1].y - data[0].y) / (data[0].y) * 100;
    return a;
  }

//function inputs List<Flspot> and outputs Text a
  String gradient(List<FlSpot> data) {
    double a = gradientOfFirstAndLast(data);
    String aString = a.toStringAsFixed(2);
    // return "증가율: " + aString + "%"; if a>0
    if (a > 0) {
      return "증가하는 추세: $aString%";
    }
    // return "감소율: " + aString + "%"; if a<0
    else if (a == 0) {
      return "추세 변화 없음: $aString%";
    } else {
      return "감소하는 추세: $aString%";
    }
  }

  //function inputs List<Flspot> and outputs Text a
  String gradientText(List<FlSpot> data) {
    double a = gradientOfFirstAndLast(data);
    String aString = a.toStringAsFixed(2);
    // return "증가율: " + aString + "%"; if a>0
    if (a > 0) {
      return "증가하는 추세: $aString%";
    }
    // return "감소율: " + aString + "%"; if a<0
    else if (a == 0) {
      return "추세 변화 없음: $aString%";
    } else {
      return "감소하는 추세: $aString%";
    }
  }

  //for multi line chart - comment
  List<Text> mapDataGradient(Map<String, dynamic> data) {
    List<Text> result = [];
    data.forEach((key, value) {
      result.add(Text("$key : ${gradientText(value)}"));
    });
    return result;
  }

  //for multi line chart - comment2
  Widget mapDataGradient2(Map<String, dynamic> data) {
    Map<String, dynamic> result = {};
    Widget resultWidget = Container();
    data.forEach((key, value) {
      result[key] = gradientOfFirstAndLast(value);
    });
    //find the biggest gradient
    double max = 0;
    String maxKey = "";
    result.forEach((key, value) {
      if (max < double.parse(value)) {
        maxKey = key;
        max = double.parse(value);
      }
    });
    //make a Text of the biggest gradient
    result.forEach((key, value) {
      if (key == maxKey) {
        resultWidget = Row(
          children: [
            SizedBox(
              child: mallMaster.smallImgOf(Mall.Auction),
              width: 45,
              height: 45,
            ),
            const SizedBox(
              width: 6,
            ),
            Text("$key : $value"),
          ],
        );
      }
    });
    return resultWidget;
  }

  //function inputs FlSpot.x and outputs String of the date by endDate subtract x
  String dateBySubtractingX(List<FlSpot> data, double x, int endDate) {
    //convert endDate to DateTime
    String endDateString = endDate.toString();
    String endDateYear = endDateString.substring(0, 4);
    String endDateMonth = endDateString.substring(4, 6);
    String endDateDay = endDateString.substring(6, 8);
    DateTime endDateDateTime = DateTime(
        int.parse(endDateYear), int.parse(endDateMonth), int.parse(endDateDay));
    DateTime startDate =
        endDateDateTime.subtract(Duration(days: data.length - x.toInt()));
    String startDateYear = startDate.year.toString();
    String startDateMonth = startDate.month.toString();
    String startDateDay = startDate.day.toString();
    String startDateString = "$startDateYear년$startDateMonth월$startDateDay일";
    return startDateString;
  }

//function inputs List<Flspot> data and double x and outputs Flspot[x].x
  String getSpotDate(List<FlSpot> data, double x) {
    //make data.x to String
    String date = data[x.toInt() - 1].x.toString().replaceAll('.', '');
    if (date.endsWith('0')) {
      date = date.substring(0, date.length - 1);
    }
    //Divide date into year, month, day
    String dateYear = date.substring(0, 4);
    String dateMonth = date.substring(4, 6);
    String dateDay = date.substring(6, 8);
    date = "$dateYear년$dateMonth월$dateDay일";
    return date;
  }

  // function inputs int x and outputs String of the date by calculate how far x is from endDate
  String dateBySubtractingXFromEndDate(int x, int endDate) {
    //convert endDate to DateTime
    String endDateString = endDate.toString();
    String endDateYear = endDateString.substring(0, 4);
    String endDateMonth = endDateString.substring(4, 6);
    String endDateDay = endDateString.substring(6, 8);
    DateTime endDateDateTime = DateTime(
        int.parse(endDateYear), int.parse(endDateMonth), int.parse(endDateDay));
    DateTime startDate = endDateDateTime.subtract(Duration(days: x.toInt()));
    String startDateYear = startDate.year.toString();
    String startDateMonth = startDate.month.toString();
    String startDateDay = startDate.day.toString();
    String startDateString = "$startDateYear년$startDateMonth월$startDateDay일";
    return startDateString;
  }
}
