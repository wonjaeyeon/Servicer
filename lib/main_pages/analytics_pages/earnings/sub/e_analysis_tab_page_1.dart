import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../data_handler/mapData_handler/get_map_data.dart';
import '../../../../data_handler/mapData_handler/mapData_picker.dart';
import '../../../../servicer_modules/shopping_mall_master.dart';
import '../../sub/earnings/total/multi_chart/trend/e_line_chart.dart';
import '../../sub/earnings/total/multi_chart/_mixed_chart_maker/e_multi_chart_ver2.dart';
import '../../sub/line_chart_ver3.dart';

var f = NumberFormat.currency(locale: "ko_KR", symbol: "￦");

class EarningsAnalysisTabPage1 extends StatefulWidget {
  EarningsAnalysisTabPage1({Key? key}) : super(key: key);

  @override
  State<EarningsAnalysisTabPage1> createState() =>
      _EarningsAnalysisTabPage1State();
}

class _EarningsAnalysisTabPage1State extends State<EarningsAnalysisTabPage1> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
        Container(
          width: double.infinity,
          alignment: Alignment.topCenter,
          child: MultiChartV2(
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
