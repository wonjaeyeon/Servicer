import 'package:flutter/material.dart';
import 'package:servicer/data_handler/mapData_handler/mapData_element.dart';
import 'package:servicer/design_standards/colors.dart';
import 'package:servicer/design_standards/text_styles.dart';
import 'package:servicer/design_standards/widget_styles.dart';
import 'package:servicer/main_pages/analytics_pages/sub/order_search_widget.dart';
import 'package:servicer/sub_widgets/unused/chart_container.dart';
import 'package:servicer/main_pages/analytics_pages/sub/unused/vertical_bar_chart.dart';
import '../../../data_handler/mapData_handler/get_map_data.dart';
import '../../../data_handler/mapData_handler/mapData_picker.dart';
import '../../../data_handler/mapData_handler/line_chart/map_flspot_converter.dart';
import '../sub/unused/line_chart_ver2.dart';
import '../sub/pie_chart_fl_chart.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  OrdersState createState() => OrdersState();
}

class OrdersState extends State<Orders> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: $$lightGrey,
        foregroundColor: Colors.black,
        elevation: 0,
        title: Text(
          '주문 분석',
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
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10)),
                      // SizedBox(
                      //   width: double.infinity,
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       Container(
                      //         alignment: Alignment.topCenter,
                      //         child: LineChartContainerFLChart(
                      //           title: "주문건 추이",
                      //           unit: "건",
                      //           mapDataByTime: Picker().earningsByTimeData(
                      //               shoppingMallDayData, []),
                      //           flSpotDataByDate: mapToFlSpotConverter(Picker()
                      //               .ordersData(shoppingMallDayData, [])),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      Container(
                        width: double.infinity,
                        alignment: Alignment.topCenter,
                        child: LineChartContainerV2(
                          title: '주문건 추이',
                          unit: "건",
                        ),
                      ),

                      const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10)),
                      SizedBox(
                        child: Container(
                          alignment: Alignment.topCenter,
                          child: PieChartContainerFlChart(
                              profitData: Picker()
                                  .profitOrdersData(shoppingMallDayData, []),
                              mallData: Picker()
                                  .mallOrdersData(shoppingMallDayData, []),
                              genderData: Picker()
                                  .genderOrdersData(shoppingMallDayData, []),
                              title: "주문 구성",
                              unit: "건"),
                        ),
                      ),
                      // Container(
                      //   height: 30,
                      //   width: double.infinity,
                      //   color: $$lightGrey,
                      // ),
                      const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10)),
                      SizedBox(
                          child: Container(
                              alignment: Alignment.topCenter,
                              child: OrderSearchWidget())),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 36),
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       Text(
                      //         '찾아보기',
                      //         textAlign: TextAlign.left,
                      //         style: TextStyle(
                      //           color: Colors.black,
                      //           fontSize: $mediumFontSize,
                      //         ),
                      //       ),
                      //       Text(
                      //         '2021.12 기준 (출처 : 시리즈서로 기업 자료)',
                      //         textAlign: TextAlign.left,
                      //         style: TextStyle(
                      //           fontSize: $mediumFontSize - 6,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // const Padding(
                      //     padding: EdgeInsets.symmetric(vertical: 16)),
                      // Padding(
                      //     padding: EdgeInsets.symmetric(horizontal: 36),
                      //     child: ElementList(
                      //         data: Picker().pickDataByRange(
                      //             shoppingMallDayData, {
                      //       "zigzag",
                      //       "ably",
                      //       "lookpin",
                      //       "smartstore",
                      //       "blue t-shirts"
                      //     }))),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
