import 'dart:ui';
import 'package:servicer/MOD_PACKAGES/fl_chart_svc/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:servicer/design_standards/colors.dart';
import 'package:servicer/design_standards/text_styles.dart';
import 'package:servicer/design_standards/widget_styles.dart';

List<PieChartSectionData> pieChartSectionData_Revenue = [
  PieChartSectionData(
    value: 10,
    title: '네이버 스마트 스토어',
    showTitle: false,
    //titleStyle: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
    titlePositionPercentageOffset: 0.4,
    color: $$mainColor1,
  ),
  PieChartSectionData(
    value: 30,
    title: '지그재그',
    showTitle: false,
    //titleStyle: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
    titlePositionPercentageOffset: 0.1,
    color: $$mainColor3,
  ),
  PieChartSectionData(
    value: 40,
    title: '에이블리',
    showTitle: false,
    //titleStyle: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
    titlePositionPercentageOffset: 0.1,
    color: $$mainColor5,
  ),
  PieChartSectionData(
    value: 70,
    title: '룩핀',
    showTitle: false,
    //titleStyle: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
    titlePositionPercentageOffset: 0.4,
    color: $$mainColor7,
  ),
];
