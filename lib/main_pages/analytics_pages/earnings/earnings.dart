import 'package:flutter/material.dart';
import 'package:servicer/design_standards/colors.dart';
import 'package:servicer/design_standards/text_styles.dart';
import 'package:servicer/main_pages/analytics_pages/sub/unused/vertical_bar_chart.dart';
import 'package:servicer/servicer_modules/shopping_mall_master.dart';
import '../../../data_handler/mapData_handler/line_chart/multi_line/mapData_toMulitmap.dart';
import '../../../data_handler/mapData_handler/mapData_picker.dart';
import '../../../data_handler/mapData_handler/line_chart/map_flspot_converter.dart';
import '../../../data_handler/mapData_handler/get_map_data.dart';
import '../sub/unused/line_chart_ver2.dart';
import '../sub/multi_chart.dart';
import '../sub/unused/line_chart_fl_chart.dart';
import '../sub/pie_chart_fl_chart.dart';
import '../sub/recommendation.dart';

class Earnings extends StatefulWidget {
  const Earnings({Key? key}) : super(key: key);

  @override
  EarningsState createState() => EarningsState();
}

class EarningsState extends State<Earnings> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Color.fromARGB(255, 238, 238, 238),
        foregroundColor: Colors.black,
        elevation: 0,
        title: Text(
          '매출 분석',
          style: TextStyle(fontSize: $mediumFontSize),
        ),
        centerTitle: true,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_rounded),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: ShaderMask(
        shaderCallback: (rect) {
          return LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.transparent,
              Colors.transparent,
              Color.fromARGB(255, 238, 238, 238)
            ],
            stops: [
              0.0,
              0.04,
              0.96,
              1.0
            ], // 10% purple, 80% transparent, 10% purple
          ).createShader(rect);
        },
        blendMode: BlendMode.dstOut,
        child: Container(
          color: Color.fromARGB(255, 238, 238, 238),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                  //매출 추이 그래프
                  // Container(
                  //   width: double.infinity,
                  //   alignment: Alignment.topCenter,
                  //   child: LineChartContainerFLChart(
                  //     title: '매출 추이',
                  //     unit: "원",
                  //     mapDataByTime:
                  //         Picker().earningsByTimeData(shoppingMallDayData, []),
                  //     flSpotDataByDate: mapToFlSpotConverter(
                  //         Picker().earningsData(shoppingMallDayData, [])),
                  //   ),
                  // ),
                  //ver 2
                  Container(
                    width: double.infinity,
                    alignment: Alignment.topCenter,
                    child: LineChartContainerV2(
                      title: '매출 추이',
                      unit: "원",
                    ),
                  ),

                  const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                  Container(
                    alignment: Alignment.topCenter,

                    //NOTE where pie chart data is placed
                    child: PieChartContainerFlChart(
                      profitData:
                          Picker().profitEarningsData(shoppingMallDayData, []),
                      mallData:
                          Picker().mallEarningsData(shoppingMallDayData, []),
                      genderData:
                          Picker().genderEarningsData(shoppingMallDayData, []),
                      title: "매출 분석",
                      unit: "원",
                    ),
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 10)),

                  Container(
                    width: double.infinity,
                    alignment: Alignment.topCenter,
                    child: MultiLineChart(
                      title: "상세 구성",
                      profitData:
                          Picker().profitEarningsData(shoppingMallDayData, []),
                      mallData:
                          Picker().mallEarningsData(shoppingMallDayData, []),
                      priceData:
                          Picker().priceEarningsData(shoppingMallDayData, []),
                    ),
                  ),

                  const Padding(padding: EdgeInsets.symmetric(vertical: 10)),

                  Container(
                      width: double.infinity,
                      alignment: Alignment.topCenter,
                      child: Recommendation()),

                  // SizedBox(
                  //   width: double.infinity,
                  //   child: VerticalBarChartContainer(
                  //       title: '매출액 / 영업이익',
                  //       color: Colors.transparent,
                  //       chart: VerticalBarChartContent()),
                  // ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 20)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
