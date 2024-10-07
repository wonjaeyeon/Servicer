import 'package:flutter/material.dart';
import '../calendar_view/calendar_chart.dart';
import '../cost_view/cost_chart.dart';
import '../../../../../../../../../../data_handler/data_standards/category.dart';
import '../customer_table_view/earnings_table_chart.dart';
import '../ratio_view/ratio_chart.dart';
import '../ratio_view/ratio_chart_ver2.dart';
import '../ratio_view/ratio_chart_ver3.dart';
import '../schedule_view/schedule_chart.dart';

mixin ViewChartSelector {
  showMultiViewChart(viewType, width) {
    if (viewType == ViewType.ratio) {
      return RatioViewChartContainerV3();
    } else if (viewType == ViewType.column) {
      return CostViewChartContainer();
    } else if (viewType == ViewType.calendar) {
      return CalendarViewChart();
    } else if (viewType == ViewType.table) {
      return EarningsTableViewChart();
    } else {
      return Center(
        child: Text('Can\'t Show Yet'),
      );
    }
  }
}
