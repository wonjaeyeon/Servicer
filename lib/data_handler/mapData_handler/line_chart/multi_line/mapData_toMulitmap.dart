//function to convert Map<String, dynamic> data to List<Map<String, dynamic>> data
import '../../../../MOD_PACKAGES/fl_chart_svc/fl_chart.dart';
import '../list_data_handler/list_data_converter.dart';
import '../map_flspot_converter.dart';
import '../../mapData_element.dart';
import 'package:flutter/material.dart';
import '../../../../design_standards/colors.dart';
import '../../../../servicer_modules/get_shoppingmall_theme.dart';

multiLineChartColorList() {
  return [
    $$mainColor1.withOpacity(0.7),
    //$$mainColor2,
    $$mainColor3.withOpacity(0.7),
    //$$mainColor4,
    $$mainColor5.withOpacity(0.7),
//$$mainColor6,
    $$mainColor7.withOpacity(0.7),
    $$mainColor8.withOpacity(0.7),
    $$mainColor9.withOpacity(0.7),
  ];
}

Map<String, Map<String, dynamic>> mapDivider(Map<String, dynamic> data) {
  //FIXME : null값에 대한 예외처리를 아예 하지를 못함
  Set elementData = getElementData(data);
  //print(elementData);
  // make Map<String,Map<String, dynamic>> data as same number of elementData
  Map<String, Map<String, dynamic>> dividedMap = {};
  for (var element in elementData) {
    dividedMap[element] = {};
  }
  // add data to dividedMap[key]
  data.forEach((key, value) {
    for (var element in elementData) {
      if (value.containsKey(element)) {
        dividedMap[element]![key] = value[element];
      }
    }
  });
  //print(dividedMap);
  return dividedMap;
}

List<Map<String, dynamic>> mapToMultiLineChart(Map<String, dynamic> data) {
  Map<String, Map<String, dynamic>> dividedMap = mapDivider(data);
  List<Map<String, dynamic>> multiLineChart = [];
  dividedMap.forEach((key, value) {
    multiLineChart.add(value);
  });
  //print(multiLineChart);
  return multiLineChart;
}

Map<String, dynamic> mapToMapOfFlSpot(Map<String, dynamic> data) {
  Map<String, Map<String, dynamic>> dividedMap = mapDivider(data);
  Map<String, dynamic> mapOfFlSpot = {};
  dividedMap.forEach((key, value) {
    mapOfFlSpot[key] = mapToFlSpotConverter(value);
  });

  //print(mapOfFlSpot);
  return mapOfFlSpot;
}

Map<String, dynamic> mapOfFlSpotXpointConverter(Map<String, dynamic> data) {
  Map<String, dynamic> convertedMap = {};
  data.forEach((key, value) {
    convertedMap[key] = convertToNumber(value);
  });
  //print(convertedMap);
  return convertedMap;
}

List<LineChartBarData> mapOfFlSpotToLineChartBarData(
    Map<String, dynamic> data) {
  List<LineChartBarData> lineChartBarDataList = [];
  int index = 0;
  data.forEach((key, value) {
    lineChartBarDataList.add(
      LineChartBarData(
        isCurved: true,
        curveSmoothness: 0.0,
        preventCurveOverShooting: true,
        belowBarData: BarAreaData(
          color: Colors.black,
          show: false,
        ),
        dotData: FlDotData(show: false),
        color: multiLineChartColorList()[index],
        barWidth: 3,
        isStrokeCapRound: true,
        spots: value,
      ),
    );
    index++;
  });
  //print(lineChartBarDataList);
  return lineChartBarDataList;
}
