import 'package:servicer/MOD_PACKAGES/fl_chart_svc/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../design_standards/colors.dart';
import '../../text/chart_text.dart';
import '../mapData_element.dart';

pieChartColorList() {
  return [
    $$mainColor1,
    //$$mainColor2,
    $$mainColor3,
    //$$mainColor4,
    $$mainColor5,
    $$mainColor6,
    $$mainColor7,
    $$mainColor8,
    $$mainColor9,
  ];
}

Map<String, double> sumElementData(Map<String, dynamic> data) {
  Map<String, double> sumData = {};
  Set elementData = getElementData(data);
  data.forEach((key, value) {
    for (var element in elementData) {
      if (sumData[element] == null) {
        sumData[element] = 0;
        sumData[element] = sumData[element]! + value[element]!;
      }
      if (value[element] != null) {
        sumData[element] = sumData[element]! + value[element]!;
      }
    }
  });
  return sumData;
}

String getTotalSumData(Map<String, dynamic> data, String unit) {
  double sum = 0;
  Map<String, double> sumData = sumElementData(data);
  sumData.forEach((key, value) {
    sum = sum + value;
  });
  if (sum > 1000000) {
    return "${ChartText().addCommaWithoutDecimal((sum.toInt() / 10000).toString())}$unit";
  } else {
    return ChartText().addComma(sum.toInt().toString()) + unit;
  }
  //return ChartText().addComma(sum.toInt().toString()) + unit;
}

List<PieChartSectionData> convertDataToPieChartSectionData(
    Map<String, dynamic> data) {
  List<PieChartSectionData> pieChartSectionData = [];
  Map<String, double> sumData = sumElementData(data);
  int index = 0;
  sumData.forEach((key, value) {
    pieChartSectionData.add(PieChartSectionData(
      color: pieChartColorList()[index],
      value: value,
      title: key,
      radius: 50,
      titleStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.transparent,
      ),
    ));
    index = index + 1;
  });

  return pieChartSectionData;
}

//function inputs Map<String, Map<String, int>> data
//function outputs List<PieChartSectionData> data
List<PieChartSectionData> pieChartData(Map<String, Map<String, int>> data) {
  List<PieChartSectionData> pieChartData = [];
  int index = 0;
  data.forEach((key, value) {
    value.forEach((key, value) {
      String colordata = '\$\$mainColor$index';
      //convert string to Color
      Color color = Color(int.parse(colordata));
      pieChartData.add(PieChartSectionData(
        color: color,
        value: value.toDouble(),
        title: key,
        radius: 50,
        titleStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ));
      index++;
    });
  });
  return pieChartData;
}
