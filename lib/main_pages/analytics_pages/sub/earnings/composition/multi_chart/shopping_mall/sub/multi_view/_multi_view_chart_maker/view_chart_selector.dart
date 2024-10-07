import 'package:flutter/material.dart';
import '../calendar_view/calendar_chart.dart';
import '../customer_table_view/customer_table_chart_ver3.dart';
import '../ratio_view/ratio_chart_ver2.dart';
import '../trend_view/trend_chart.dart';
import '../../../../../../../../../../data_handler/data_standards/category.dart';
import '../ratio_view/ratio_chart.dart';
import '../schedule_view/schedule_chart.dart';

mixin ViewChartSelector {
  showMultiViewChart(viewType, width) {
    if (viewType == ViewType.ratio) {
      return RatioViewChartContainerV2();
    } else if (viewType == ViewType.column) {
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
