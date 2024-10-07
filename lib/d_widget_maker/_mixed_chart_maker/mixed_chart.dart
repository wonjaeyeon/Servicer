import 'package:flutter/material.dart';
import 'package:servicer/d_widget_maker/implement_class/implement_chart.dart';
import '../../data_handler/data_standards/category.dart';
import '../../design_standards/text_styles.dart';
import '../../design_standards/widget_styles.dart';
import '../../main_pages/analytics_pages/sub/multi_chart.dart';
import '../line_chart_maker/multi_line_chart_flchart.dart';
import '../line_chart_maker/stacked_line_chart.dart';
import '../stacked_area_chart/stacked_area_100_chart.dart';
import '../stacked_area_chart/stacked_area_chart.dart';
import '../stacked_column_chart/product_price_chart.dart';
import '../../../data_handler/data_standards/time.dart';

class MixedChart {
  showMixedChart(data, Time time, category, width) {
    //print(time);
    if (category == CompositeDataCategory.profit) {
      return StackedAreaChart(
        time: time,
        width: width,
      );
    } else if (category == CompositeDataCategory.shoppingMall) {
      return StackedLineChart(
        time: time,
        width: width,
      );
    } else if (category == CompositeDataCategory.price) {
      return ProductPriceChart(
        time: time,
        width: width,
      );
    } else if (category == CompositeDataCategory.gender) {
      return StackedAreaHundreadChart(
        time: time,
        width: width,
      );
    } else if (category == CompositeDataCategory.age) {
      return ImplementChart(time: time, width: width);
    } else if (category == CompositeDataCategory.sellingTime) {
    } else {
      return Center(
        child: Text('Can\'t Show Yet'),
      );
    }
  }
}
