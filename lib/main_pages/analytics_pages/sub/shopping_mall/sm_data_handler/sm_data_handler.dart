import 'package:flutter/material.dart';

import '../../../../../data_handler/data_standards/time.dart';
import '../gender_chart.dart';

mixin SMDataHandler {
  String getRatio(
      Time time, EarningsData _earningsData, Function getChartData) {
    double maleNum = getChartData(time)[0].maleOrder.toDouble();
    double femaleNum = getChartData(time)[0].femaleOrder.toDouble();
    double maleRate = 0;
    double femaleRate = 0;
    if (maleNum == 0 && femaleNum == 0) {
      return '0 : 0';
    } else if (maleNum == 0) {
      return '0 : 1';
    } else if (femaleNum == 0) {
      return '1 : 0';
    } else if (maleNum >= femaleNum) {
      maleRate = maleNum / (femaleNum);

      String maleRateStr = maleRate.toStringAsFixed(2);
      // if maleRateStr is integer, remove '.0'
      if (maleRateStr.endsWith('.00')) {
        maleRateStr = maleRateStr.substring(0, maleRateStr.length - 3);
      } else if (maleRate != 0 && maleRateStr.endsWith('0')) {
        maleRateStr = maleRateStr.substring(0, maleRateStr.length - 1);
      }
      return '$maleRateStr : 1';
    } else {
      femaleRate = femaleNum / (maleNum);
      String femaleRateStr = femaleRate.toStringAsFixed(2);
      if (femaleRateStr.endsWith('.00')) {
        femaleRateStr = femaleRateStr.substring(0, femaleRateStr.length - 3);
      } else if (femaleRate != 0 && femaleRateStr.endsWith('0')) {
        femaleRateStr = femaleRateStr.substring(0, femaleRateStr.length - 1);
      }
      return '1 : $femaleRateStr';
    }
  }

  String getSoldRate(Time time, Function getChartData) {
    double soldNum = getChartData(time)[0].salesRate.toDouble();
    double unsoldNum = getChartData(time)[1].salesRate.toDouble();
    double soldRate = soldNum / (unsoldNum + soldNum) * 100;
    String soldRateStr = soldRate.toStringAsFixed(2);
    if (soldRateStr.endsWith('.00')) {
      soldRateStr = soldRateStr.substring(0, soldRateStr.length - 3);
    } else if (soldRate != 0 && soldRateStr.endsWith('0')) {
      soldRateStr = soldRateStr.substring(0, soldRateStr.length - 1);
    }
    return '$soldRateStr%';
  }

  String getSoldTotalRatio(Time time, Function getChartData) {
    int soldNum = getChartData(time)[0].salesRate;
    int unsoldNum = getChartData(time)[1].salesRate;
    return '$soldNum : ${soldNum + unsoldNum}';
  }

  double getPercent(int soldNum, int total) {
    double percent = soldNum / total * 100;
    if (percent.isNaN) return 0;
    String percentStr = percent.toStringAsFixed(2);
    if (percentStr.endsWith('.00')) {
      percentStr = percentStr.substring(0, percentStr.length - 3);
    } else if (percent != 0 && percentStr.endsWith('0')) {
      percentStr = percentStr.substring(0, percentStr.length - 1);
    }
    return double.parse(percentStr);
  }
}
