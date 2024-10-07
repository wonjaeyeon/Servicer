import 'package:flutter/material.dart';
import '../candle_view/candle_chart.dart';
import '../cash_flow_sheet_view/cash_flow_sheet_chart.dart';
import '../customer_table_view/earnings_table_chart.dart';
import '../line_view/line_chart.dart';
import '../mall_view/mall_chart.dart';
import '../age_view/age_chart.dart';
import '../date_view/date_chart.dart';
import '../profit_loss_sheet_view/profit_loss_sheet_chart.dart';
import '../range_graph_view/range_graph_chart.dart';
import '../balance_sheet_view/balance_sheet_chart.dart';
import '../waterfall_view/waterfall_chart.dart';

mixin ViewChartSelector {
  showMultiViewChart(subViewType, width, time) {
    if (subViewType == "대차대조표") {
      return BalanceSheetSubChartContainer(width: width, time: time);
    } else if (subViewType == "손익계산서") {
      return ProfitLossSubChartContainer(width: width, time: time);
    } else if (subViewType == "현금흐름표") {
      return CashFlowSubChartContainer(width: width, time: time);
    } else {
      return Center(
        child: Text('Can\'t Show Yet'),
      );
    }
  }
}
