import 'package:flutter/material.dart';

import '../calendar_view/calendar_chart.dart';
import '../calendar_view/calendar_chart_ver2.dart';
import '../customer_table_view/customer_table_chart_ver3.dart';
import '../treemap_view/ratio_chart_ver2.dart';
import '../treemap_view/treemap_chart_ver1.dart';
import '../trend_view/trend_chart_old.dart';
import '../../../../../../../../../../data_handler/data_standards/category.dart';
import '../treemap_view/ratio_chart.dart';
import '../schedule_view/schedule_chart.dart';
import '../trend_view/trend_chart_ver3.dart';

mixin ViewChartSelector {
  showMultiViewChart(viewType, width) {
    if (viewType == ViewType.treemap) {
      return TreemapViewChartContainerV2();
    } else if (viewType == ViewType.trend) {
      return TrendViewChartContainerV3();
    } else if (viewType == ViewType.calendar) {
      return CalendarViewChartV2();
    } else if (viewType == ViewType.table) {
      return CustomerTableViewChartV3();
    } else {
      return Center(
        child: Text('Can\'t Show Yet'),
      );
    }
  }
}
