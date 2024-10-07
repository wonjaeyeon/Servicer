import 'package:flutter/material.dart';
import '../total_earnings_view/total_earnings_chart.dart';
import '../unit_person_price_view/unit_person_price_chart.dart';
import '../unit_person_price_view/unit_person_price_chart_ver2.dart';
import '../unit_person_price_view/unit_person_price_chart_ver3.dart';

mixin ViewChartSelector {
  showMultiViewChart(subViewType, width, time) {
    if (subViewType == "객단가") {
      return UnitPersonPriceSubChartContainerV3(width: width, time: time);
    } else if (subViewType == "매출포진") {
      return TotalEarningsSubChartContainer(width: width, time: time);
    } else {
      return Center(
        child: Text('Can\'t Show Yet'),
      );
    }
  }
}
