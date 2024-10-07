import 'package:flutter/material.dart';
import 'package:servicer/d_widget_maker/implement_class/implement_chart.dart';
import '../../../../../../../data_handler/data_standards/category.dart';

import '../age/age_chart.dart';
import '../shopping_mall_distribution/shopping_mall_distribution.dart';
import '../total_distribution/currency_flow.dart';
import '../total_distribution/currency_flow_ver_2.dart';
import '../total_distribution/currency_flow_ver_3.dart';
import '../total_distribution/total_distribution_ver_4.dart';
import '../expected_profit/e_line_chart.dart';
import '../financialTable/ft_line_chart.dart';
import '../profit/profit_chart_ver2.dart';
import '../../../../../../../../data_handler/data_standards/time.dart';
import '../trend/e_line_chart.dart';

mixin MixedChart {
  showMixedChart(data, Time time, category, width) {
    //print(time);
    if (category == TotalDataCategory.totalSummary) {
      return EarningsDistributionChartV4(
          // time: time,
          // width: width,
          );
    } else if (category == TotalDataCategory.trend) {
      return ShoppingMallDistributionChart(
          // title: "매출 추이",
          // unit: "원",
          //time: time,
          );
    } else if (category == TotalDataCategory.profitLoss) {
      return ProfitAnalysisChartV2(
        //time: time,
        width: width,
      );
    } else if (category == TotalDataCategory.financialTable) {
      return FinancialTableChartContainer(
        //time: time,
        width: width,
      );
    } else if (category == TotalDataCategory.expectedProfit) {
      return ExpectedProfitChartContainer(width: width);
    } else {
      return Center(
        child: Text('Can\'t Show Yet'),
      );
    }
  }
}
