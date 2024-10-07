import 'package:flutter/material.dart';

mixin LegendDataHandler {
  String legendValueSelector(String name, Function getChartData) {
    if (name == '스마트스토어') {
      return getChartData()[0].naverSmartStore.toStringAsFixed(2);
    } else if (name == '지그재그') {
      return getChartData()[0].zigzag.toStringAsFixed(2);
    } else if (name == '에이블리') {
      return getChartData()[0].ably.toStringAsFixed(2);
    } else if (name == '쿠팡') {
      return getChartData()[0].coupang.toStringAsFixed(2);
    } else {
      return '';
    }
  }
}
