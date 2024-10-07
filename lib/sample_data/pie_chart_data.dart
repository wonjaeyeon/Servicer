import 'dart:ui';
import 'package:servicer/MOD_PACKAGES/fl_chart_svc/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:servicer/design_standards/colors.dart';
import 'package:servicer/design_standards/text_styles.dart';
import 'package:servicer/design_standards/widget_styles.dart';

List<PieChartSectionData> pieChartSectionData = [
  PieChartSectionData(
    value: 20,
    title: '20대',
    titleStyle: TextStyle(
        color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
    titlePositionPercentageOffset: 0.65,
    color: $$mainColor1,
  ),
  PieChartSectionData(
    value: 35,
    title: '30대',
    titleStyle: TextStyle(
        color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
    titlePositionPercentageOffset: 0.65,
    color: $$mainColor3,
  ),
  PieChartSectionData(
    value: 15,
    title: '40대',
    titleStyle: TextStyle(
        color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
    titlePositionPercentageOffset: 0.65,
    color: $$mainColor5,
  ),
  PieChartSectionData(
    value: 30,
    title: '50대',
    titleStyle: TextStyle(
        color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
    titlePositionPercentageOffset: 0.65,
    color: $$mainColor7,
  ),
];
