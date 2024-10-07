import 'package:flutter/material.dart';
import '../candle_view/candle_chart.dart';
import '../customer_table_view/earnings_table_chart.dart';
import '../line_view/line_chart.dart';
import '../mall_view/mall_chart.dart';
import '../age_view/age_chart.dart';
import '../date_view/date_chart.dart';
import '../range_graph_view/range_graph_chart.dart';
import '../summary_view/summary_chart.dart';
import '../waterfall_view/waterfall_chart.dart';

mixin ViewChartSelector {
  showMultiViewChart(subViewType, width, time) {
    if (subViewType == "요약") {
      return SummarySubChartContainer(width: width, time: time);
    } else if (subViewType == "그래프") {
      return RangeGraphSubChartContainer(width: width, time: time);
    } else if (subViewType == "표") {
      return EarningsTableViewChart(width: width, time: time);
    } else {
      return Center(
        child: Text('Can\'t Show Yet'),
      );
    }
  }
}
