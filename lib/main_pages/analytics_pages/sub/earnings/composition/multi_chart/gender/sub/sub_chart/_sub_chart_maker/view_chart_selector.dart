import 'package:flutter/material.dart';
import '../mall_view/mall_chart.dart';
import '../age_view/age_chart.dart';
import '../date_view/date_chart.dart';
import '../total_rate_view/total_rate_chart.dart';

mixin ViewChartSelector {
  showMultiViewChart(subViewType, width, time) {
    if (subViewType == "총비율") {
      return TotalRateSubChartContainer(width: width, time: time);
    } else if (subViewType == "나이") {
      return AgeSubChartContainer(width: width, time: time);
    } else if (subViewType == "입점몰") {
      return MallSubChartContainer(width: width, time: time);
    } else if (subViewType == "날짜") {
      return DateSubChartContainer(width: width, time: time);
    } else {
      return Center(
        child: Text('Can\'t Show Yet'),
      );
    }
  }
}
