import 'package:flutter/material.dart';
import '../../../../data_handler/mapData_handler/get_map_data.dart';
import '../../../../data_handler/mapData_handler/mapData_picker.dart';
import '../../sub/earnings/composition/multi_chart/_mixed_chart_maker/e_multi_chart_ver2.dart';

class EarningsAnalysisTabPage2 extends StatefulWidget {
  EarningsAnalysisTabPage2({Key? key}) : super(key: key);

  @override
  State<EarningsAnalysisTabPage2> createState() =>
      _EarningsAnalysisTabPage2State();
}

class _EarningsAnalysisTabPage2State extends State<EarningsAnalysisTabPage2> {
  Map data = {};

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
