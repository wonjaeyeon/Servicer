import 'package:flutter/material.dart';
import 'package:servicer/d_widget_maker/implement_class/implement_chart.dart';
import '../../../../../../../data_handler/data_standards/category.dart';
import '../../../../../../../design_standards/text_styles.dart';
import '../../../../../../../design_standards/widget_styles.dart';
import '../../../../multi_chart.dart';

import '../age/age_chart.dart';
import '../gender/gender_chart_ver3.dart';
import '../product_price/product_price_chart_ver2.dart';
import '../product_price/product_price_chart_ver4.dart';
import '../profit/profit_chart_ver2.dart';
import '../shopping_mall/shopping_mall_chart.dart';
import '../profit/profit_chart.dart';
import '../product_price/product_price_chart.dart';
import '../../../../../../../../data_handler/data_standards/time.dart';
import '../age/age_chart_ver2_old.dart';
import '../age/age_chart_ver3.dart';

mixin MixedChart {
  showMixedChart(data, Time time, category, width) {
    //print(time);
    if (category == CompositeDataCategory.profit) {
      return ProfitAnalysisChartV2(
        //time: time,
        width: width,
      );
    } else if (category == CompositeDataCategory.shoppingMall) {
      return MallAnalysisChart(
        //time: time,
        width: width,
      );
    } else if (category == CompositeDataCategory.price) {
      return ProductPriceAnalysisChartV4(
        //time: time,
        width: width,
      );
    } else if (category == CompositeDataCategory.gender) {
      return GenderAnalysisChartV3(
        //time: time,
        width: width,
      );
    } else if (category == CompositeDataCategory.age) {
      return AgeAnalysisChartV3(width: width);
    } else if (category == CompositeDataCategory.sellingTime) {
    } else {
      return Center(
        child: Text('Can\'t Show Yet'),
      );
    }
  }
}
