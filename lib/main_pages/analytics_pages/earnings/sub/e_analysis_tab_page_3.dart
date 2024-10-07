import 'package:flutter/material.dart';
import 'package:servicer/MOD_PACKAGES/fl_chart_svc/fl_chart.dart';
import 'package:servicer/main_pages/analytics_pages/sub/earnings/detail/detail_chart/e_total_chart.dart';

import '../../../../data_handler/mapData_handler/get_map_data.dart';
import '../../../../data_handler/mapData_handler/mapData_picker.dart';
import '../../sub/earnings/detail/detail_report/multi_chart copy/_mixed_chart_maker/e_detail_report_ver2.dart';
import '../../sub/earnings/detail/e_detail_report.dart';
import '../../sub/earnings/detail_ver4/multi_chart/_mixed_chart_maker/e_multi_chart_ver2.dart';
import '../../sub/earnings/detail_ver3/multi_chart/_mixed_chart_maker/e_multi_chart_ver2.dart';

class EarningsAnalysisTabPage3 extends StatefulWidget {
  EarningsAnalysisTabPage3({Key? key}) : super(key: key);

  @override
  State<EarningsAnalysisTabPage3> createState() =>
      _EarningsAnalysisTabPage3State();
}

class _EarningsAnalysisTabPage3State extends State<EarningsAnalysisTabPage3> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        // const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
        // ETotalChart(),
        // const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
        // EarningsDetailReportV2(
        //   title: "상세 리포트",
        // ),
        const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
        Container(
          width: double.infinity,
          alignment: Alignment.topCenter,
          child: DetailMultiChart(
            title: "매출 구성",
            profitData: Picker().profitEarningsData(shoppingMallDayData, []),
            mallData: Picker().mallEarningsData(shoppingMallDayData, []),
            priceData: Picker().priceEarningsData(shoppingMallDayData, []),
          ),
        ),
      ],
    );
  }
}
