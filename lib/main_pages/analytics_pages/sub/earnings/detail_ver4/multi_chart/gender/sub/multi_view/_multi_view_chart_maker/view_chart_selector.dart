import 'package:flutter/material.dart';
import '../calendar_view/calendar_chart.dart';
import '../customer_table_view/customer_table_chart_ver2.dart';
import '../customer_table_view/customer_table_chart_ver3.dart';
import '../trend_view/trend_chart.dart';
import '../../../../../../../../../../data_handler/data_standards/category.dart';
import '../treemap_view/treemap_chart_ver1.dart';
import '../customer_table_view/customer_table_chart.dart';
import '../treemap_view/treemap_chart_ver2.dart';

mixin ViewChartSelector {
  showMultiViewChart(viewType, width) {
    if (viewType == ViewType.treemap) {
      return TreemapViewChartContainerV1();
    } else if (viewType == ViewType.trend) {
      return TrendViewChartContainer();
    } else if (viewType == ViewType.calendar) {
      return CalendarViewChart();
    } else if (viewType == ViewType.table) {
      return CustomerTableViewChartV3();
    } else {
      return Center(
        child: Text('Can\'t Show Yet'),
      );
    }
  }
}
