import '../../../../MOD_PACKAGES/fl_chart_svc/fl_chart.dart';

import '../../../data_standards/time.dart';

//function inputs List<FlSpot> data, enum Time, int endDate
//function outputs List<FlSpot> data
List<FlSpot> pickTimeRange(List<FlSpot> data, Time time, int endDate) {
  List<FlSpot> dataInTime = [];
  for (FlSpot element in data) {
    // erase dash
    String keyString = element.x.toString().replaceAll('.', '');
    // erase last 0
    if (keyString.endsWith('0')) {
      keyString = keyString.substring(0, keyString.length - 1);
    }

    // 이 부분 그냥 인수 숫자로 계산해야 할 듯 -> 사유 : convert가 이제 Date 타임을 그냥 다 정수화 시킬 수 있음 그럼 2022,08,01이 그냥 1이 될 수 있음

    //convert keyString to DateTime
    DateTime key = DateTime.parse(keyString);

    //convert endDate to DateTime
    String endDateString = endDate.toString();
    DateTime endDateTime = DateTime.parse(endDateString);

    //if key is in range of startDate and endDate, add to dataInRange
    if (time == Time.day) {
      if (key.isAfter(endDateTime.subtract(const Duration(days: 2)))) {
        dataInTime.add(element);
      }
    } else if (time == Time.week) {
      if (key.isAfter(endDateTime.subtract(const Duration(days: 7)))) {
        dataInTime.add(element);
      }
    } else if (time == Time.month) {
      if (key.isAfter(endDateTime.subtract(const Duration(days: 30)))) {
        dataInTime.add(element);
      }
    } else if (time == Time.threeMonth) {
      if (key.isAfter(endDateTime.subtract(const Duration(days: 60)))) {
        dataInTime.add(element);
      }
    } else if (time == Time.year) {
      if (key.isAfter(endDateTime.subtract(const Duration(days: 365)))) {
        dataInTime.add(element);
      }
    }
  }

  return dataInTime;
}
