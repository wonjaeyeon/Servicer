import 'package:flutter/material.dart';
import '../age_view/age_chart.dart';
import '../100percent_view/100_percent_chart.dart';
import '../total_rate_view/total_rate_chart.dart';

mixin ViewChartSelector {
  showMultiViewChart(subViewType, width, time) {
    if (subViewType == "백분위") {
      return HundredPercentSubChartContainer(width: width, time: time);
    } else if (subViewType == "연령별") {
      return AgeSubChartContainer(width: width, time: time);
    } else {
      return Center(
        child: Text('Can\'t Show Yet'),
      );
    }
  }
}
