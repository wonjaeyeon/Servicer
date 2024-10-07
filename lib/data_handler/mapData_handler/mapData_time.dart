import '../../data_handler/data_standards/time.dart';

class MapDataTimeRange {
  //function inputs Map<String, dynamic> data, start date(int), end date(int)
  //function outputs Map<String, dynamic> data
  Map<String, dynamic> pickDateRange(
      Map<String, dynamic> data, int startDate, int endDate) {
    Map<String, dynamic> dataInRange = {};
    data.forEach((key, value) {
      // erase dash
      String keyString = key.replaceAll('-', '');
      //convert keyString to int
      int keyInt = int.parse(keyString);
      //if keyInt is in range of startDate and endDate, add to dataInRange
      if (keyInt >= startDate && keyInt <= endDate) {
        dataInRange[key] = value;
      }
    });
    //import 'package:servicer/MOD_PACKAGES/fl_chart_svc/fl_chart.dart';dataInRange);
    return dataInRange;
  }

  //function inputs Map<String, dynamic> data, date length(int), end date(int)
  //function outputs Map<String, dynamic> data
  Map<String, dynamic> pickDateLength(
      Map<String, dynamic> data, int dateLength, int endDate) {
    Map<String, dynamic> dataInLength = {};
    data.forEach((key, value) {
      // erase dash
      String keyString = key.replaceAll('-', '');
      //convert keyString to int
      int keyInt = int.parse(keyString);
      //if keyInt is in range of startDate and endDate, add to dataInRange
      if (keyInt >= endDate - dateLength && keyInt <= endDate) {
        dataInLength[key] = value;
      }
    });
    //import 'package:servicer/MOD_PACKAGES/fl_chart_svc/fl_chart.dart';dataInLength);
    return dataInLength;
  }

  //function inputs Map<String, dynamic> data, enum Time, end date(int)
  //function outputs Map<String, dynamic> data
  Map<String, dynamic> pickTimeRange(
      Map<String, dynamic> data, Time time, int endDate) {
    Map<String, dynamic> dataInTime = {};
    data.forEach((key, value) {
      // erase dash
      String keyString = key.replaceAll('-', '');
      //convert keyString to DateTime
      DateTime timeKey = DateTime.parse(keyString);
      //convert endDate to DateTime
      String endDateString = endDate.toString();
      DateTime endDateTime = DateTime.parse(endDateString);
      //if key is in range of startDate and endDate, add to dataInRange
      if (time == Time.day) {
        if (timeKey.isAfter(endDateTime.subtract(const Duration(days: 2)))) {
          dataInTime[keyString] = value;
        }
      } else if (time == Time.week) {
        if (timeKey.isAfter(endDateTime.subtract(const Duration(days: 7)))) {
          dataInTime[keyString] = value;
        }
      } else if (time == Time.month) {
        if (timeKey.isAfter(endDateTime.subtract(const Duration(days: 30)))) {
          dataInTime[keyString] = value;
        }
      } else if (time == Time.year) {
        if (timeKey.isAfter(endDateTime.subtract(const Duration(days: 365)))) {
          dataInTime[keyString] = value;
        }
      }
    });
    //import 'package:servicer/MOD_PACKAGES/fl_chart_svc/fl_chart.dart';dataInTime);
    return dataInTime;
  }

  //function inputs Map<String, dynamic> data and outputs String Data for first date and last date
  String getFirstDate(Map<String, dynamic> data) {
    String firstDate = data.keys.first;
    return firstDate;
  }

  String getLastDate(Map<String, dynamic> data) {
    String lastDate = data.keys.last;
    return lastDate;
  }

  String getDateRangeOfMapData(Map<String, dynamic> data) {
    String firstDate = getFirstDate(data);
    String lastDate = getLastDate(data);
    String range = firstDate + ' ~ ' + lastDate;
    return range;
  }

  //function inputs Map<String, dynamic> data and outputs int Data for first date and last date
  int getFirstDateInt(Map<String, dynamic> data) {
    String firstDate = data.keys.first;
    String firstDateInt = firstDate.replaceAll('-', '');
    int firstDateIntInt = int.parse(firstDateInt);
    return firstDateIntInt;
  }
}
