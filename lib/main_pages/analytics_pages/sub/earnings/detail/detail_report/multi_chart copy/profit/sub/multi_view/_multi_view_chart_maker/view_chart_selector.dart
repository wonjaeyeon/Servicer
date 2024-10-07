import 'package:flutter/material.dart';
import '../calendar_view/calendar_chart.dart';
import '../cost_view/cost_chart.dart';
import '../../../../../../../../../../../data_handler/data_standards/category.dart';
import '../ratio_view/ratio_chart.dart';
import '../schedule_view/schedule_chart.dart';

mixin ViewChartSelector {
  showMultiViewChart(viewType, width) {
    if (viewType == ViewType.ratio) {
      return RatioViewChartContainer();
    } else if (viewType == ViewType.column) {
      return CostViewChartContainer();
    } else if (viewType == ViewType.calendar) {
      return CalendarViewChart();
    } else if (viewType == ViewType.schedule) {
      return ScheduleViewChart();
    } else {
      return Center(
        child: Text('Can\'t Show Yet'),
      );
    }
  }
}
