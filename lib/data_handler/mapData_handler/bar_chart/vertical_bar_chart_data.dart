import 'dart:ui';
import 'package:servicer/MOD_PACKAGES/fl_chart_svc/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:servicer/design_standards/colors.dart';

List<BarChartGroupData> barChartGroupData = [
  BarChartGroupData(x: 1, showingTooltipIndicators: [
    0
  ], barRods: [
    BarChartRodData(
        toY: 585,
        color: $$mediumGrey,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        width: 50,
        rodStackItems: [
          BarChartRodStackItem(
            0,
            300,
            $$mainColor3,
          ),
        ])
  ]),
  BarChartGroupData(x: 2, showingTooltipIndicators: [
    0
  ], barRods: [
    BarChartRodData(
        toY: 395,
        color: $$mediumGrey,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        width: 50,
        rodStackItems: [
          BarChartRodStackItem(
            0,
            200,
            $$mainColor3,
          ),
        ]),
  ]),
  BarChartGroupData(x: 3, showingTooltipIndicators: [
    0
  ], barRods: [
    BarChartRodData(
        toY: 409,
        color: $$mediumGrey,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        width: 50,
        rodStackItems: [
          BarChartRodStackItem(
            0,
            300,
            $$mainColor3,
          ),
        ]),
  ]),
  BarChartGroupData(x: 4, showingTooltipIndicators: [
    0
  ], barRods: [
    BarChartRodData(
        toY: 432,
        color: $$mediumGrey,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(6), topRight: Radius.circular(6)),
        width: 50,
        rodStackItems: [
          BarChartRodStackItem(
            0,
            300,
            $$mainColor3,
          ),
        ]),
  ]),
  BarChartGroupData(x: 5, showingTooltipIndicators: [
    0
  ], barRods: [
    BarChartRodData(
        toY: 385,
        color: $$lightGrey,
        borderSide:
            const BorderSide(color: Colors.black, style: BorderStyle.solid),
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        width: 50,
        rodStackItems: [
          BarChartRodStackItem(
            0,
            200,
            $$mainColor9,
            const BorderSide(color: Colors.black, style: BorderStyle.solid),
          ),
        ]),
  ]),
  // BarChartGroupData(x: 6, barRods: [
  //   BarChartRodData(
  //       toY: 12,
  //       color: $$Grey,
  //       borderRadius: BorderRadius.only(
  //           topLeft: Radius.circular(6), topRight: Radius.circular(6)),
  //       width: 40),
  // ]),
  // BarChartGroupData(x: 7, barRods: [
  //   BarChartRodData(
  //       toY: 7,
  //       color: $$Grey,
  //       borderRadius: BorderRadius.only(
  //           topLeft: Radius.circular(6), topRight: Radius.circular(6)),
  //       width: 40),
  // ]),
];
