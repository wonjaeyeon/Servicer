import 'package:flutter/material.dart';
import 'package:servicer/main_pages/analytics_pages/earnings/earnings.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../d_widget_maker/abstract_class/abstractChart.dart';
import '../../../../data_handler/data_standards/time.dart';
import '../../../../design_standards/colors.dart';
import '../../../../design_standards/text_styles.dart';
import '../bottomsheet.dart';
import 'return_sub/r_percent_chart.dart';
import 'return_sub/r_count_chart.dart';

class ReturnChartContainer extends StatefulWidget {
  const ReturnChartContainer({super.key});

  @override
  State<ReturnChartContainer> createState() => _ReturnChartContainerState();
}

class _ReturnChartContainerState extends State<ReturnChartContainer>
    with FunctionForClass {
  late TooltipBehavior _tooltipBehavior;
  late Time time;
  List<Widget> valueUnit = <Widget>[Text('%'), Text('건')];
  final List<bool> _selectedUnit = <bool>[true, false];

  @override
  void initState() {
    time = Time.week;
    _tooltipBehavior = TooltipBehavior(enable: true, color: $$Grey, opacity: 1);
    super.initState();
  }

  final List<bool> _isSelectedTime = [true, false, false, false, false, false];
  bool toggle = false;
  // AnimatedOpacity를 위한 변수
  bool _visible = true;
  @override
  Widget build(BuildContext context) {
    final double _verticalPadding = 15;
    final double _horizontalPadding = 15;
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 0),
        child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(0),
            ),
            child: ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 240,
                    margin: const EdgeInsets.fromLTRB(
                        0, 0, 0, 0), //*그래프 컨테이너 바깥쪽 간격
                    //padding: const EdgeInsets.all(4),
                    child: AnimatedOpacity(
                      opacity: _visible ? 1.0 : 0.0,
                      duration: _visible
                          ? const Duration(milliseconds: 400)
                          : const Duration(milliseconds: 0),
                      onEnd: () async => {
                        await Future.delayed(const Duration(milliseconds: 400)),
                        setState(() {
                          _visible = true;
                        })
                      },
                      // child: SfCartesianChart(
                      //   tooltipBehavior: _tooltipBehavior,
                      //   series: <ChartSeries>[
                      //     StackedBarSeries<EarningsData, String>(
                      //       animationDuration: 0,
                      //       dataSource: getChartData(time),
                      //       xValueMapper: (EarningsData earnings, _) =>
                      //           earnings.earningsCategory,
                      //       yValueMapper: (EarningsData earnings, _) =>
                      //           earnings.sold,
                      //       color: Color.fromARGB(255, 2, 0, 117),
                      //       borderRadius: BorderRadius.horizontal(
                      //           left: Radius.circular(0),
                      //           right: Radius.circular(0)),
                      //       dataLabelSettings: DataLabelSettings(
                      //         labelAlignment: ChartDataLabelAlignment.outer,
                      //         offset: Offset(32, 0),
                      //         showCumulativeValues: true,
                      //         labelPosition: ChartDataLabelPosition.outside,
                      //         isVisible: true,
                      //         textStyle: const TextStyle(
                      //             fontFamily: 'IBMPlexSansKR',
                      //             color: Color.fromARGB(255, 2, 0, 117)),
                      //       ),
                      //       width: 0.4,
                      //       name: "반품건수",
                      //     ),
                      //     StackedBarSeries<EarningsData, String>(
                      //       animationDuration: 0,
                      //       dataSource: getChartData(time),
                      //       xValueMapper: (EarningsData earnings, _) =>
                      //           earnings.earningsCategory,
                      //       yValueMapper: (EarningsData earnings, _) =>
                      //           earnings.unSold,
                      //       color: $$mediumGrey,
                      //       borderRadius: BorderRadius.horizontal(
                      //           left: Radius.circular(0),
                      //           right: Radius.circular(10)),
                      //       dataLabelSettings: DataLabelSettings(
                      //         labelAlignment: ChartDataLabelAlignment.outer,
                      //         offset: Offset(42, 0),
                      //         showCumulativeValues: true,
                      //         isVisible: true,
                      //         textStyle: const TextStyle(
                      //             fontFamily: 'IBMPlexSansKR',
                      //             color: Colors.black),
                      //       ),
                      //       width: 0.4,
                      //       name: "판매완료건수",
                      //     ),
                      //   ],
                      //   primaryXAxis: CategoryAxis(
                      //     labelStyle:
                      //         const TextStyle(fontFamily: 'IBMPlexSansKR'),
                      //   ),
                      //   primaryYAxis: NumericAxis(
                      //     labelFormat:
                      //         _selectedUnit[1] ? '{value}건' : '{value}%',
                      //     //make a labeFormat for percentage of sold and unsold
                      //     // labelFormat: '{value}',
                      //     // minimum: 0,
                      //     // maximum: 100,
                      //     // interval: 20,
                      //     // majorGridLines: const MajorGridLines(width: 0),

                      //     opposedPosition: true,
                      //     labelStyle:
                      //         const TextStyle(fontFamily: 'IBMPlexSansKR'),
                      //   ),
                      // ),
                      child: _selectedUnit[0] == true
                          ? RPercentChart(
                              tooltipBehavior: _tooltipBehavior,
                              data: getChartData(time))
                          : RCountChart(
                              tooltipBehavior: _tooltipBehavior,
                              data: getChartData(time)),
                    ),
                  ),
                  Center(
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: ToggleButtons(
                        splashColor: Colors.transparent,
                        renderBorder: false,
                        //borderRadius: BorderRadius.circular(15),
                        constraints: BoxConstraints.expand(
                          height: 25,
                          width: MediaQuery.of(context).size.width * 0.13,
                        ),
                        color: $$Grey,
                        fillColor: Colors.transparent,
                        selectedColor: Colors.black,
                        isSelected: _isSelectedTime,
                        onPressed: (int newIndex) async {
                          setState(() {
                            //_visible = false;
                            for (int i = 0; i < _isSelectedTime.length; i++) {
                              if (i == newIndex) {
                                _isSelectedTime[i] = true;
                              } else {
                                _isSelectedTime[i] = false;
                                switch (newIndex) {
                                  case 0:
                                    //sleep(Duration(milliseconds: 50));
                                    time = Time.week;
                                    break;
                                  case 1:
                                    time = Time.month;
                                    break;
                                  case 2:
                                    time = Time.threeMonth;
                                    break;
                                  case 3:
                                    time = Time.sixMonth;
                                    break;
                                  case 4:
                                    time = Time.year;
                                    break;
                                  case 5:
                                    break;
                                }
                              }
                              //print(_isSelectedTime);
                            }
                            if (newIndex == 5) {
                              final data = BottomSheetTime()
                                  .makeShowModalBottomSheet(context);
                              //print startDate whien Navigor.pop
                              data.then((value) {
                                if (value != null) {
                                  print(value["startDate"]);
                                }
                              });
                            } else {
                              _visible = false;
                            }
                          });
                          await Future.delayed(Duration(milliseconds: 800));
                        },
                        children: [
                          Ink(
                              width: 30,
                              height: 26,
                              decoration: BoxDecoration(
                                color: _isSelectedTime[0]
                                    ? $$lightGrey
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: const Center(child: Text('1주'))),
                          Ink(
                              width: 40,
                              height: 26,
                              decoration: BoxDecoration(
                                color: _isSelectedTime[1]
                                    ? $$lightGrey
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: const Center(child: Text('1개월'))),
                          Ink(
                              width: 40,
                              height: 26,
                              decoration: BoxDecoration(
                                color: _isSelectedTime[2]
                                    ? $$lightGrey
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: const Center(child: Text('3개월'))),
                          Ink(
                              width: 40,
                              height: 26,
                              decoration: BoxDecoration(
                                color: _isSelectedTime[3]
                                    ? $$lightGrey
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: const Center(child: Text('6개월'))),
                          Ink(
                              width: 30,
                              height: 26,
                              decoration: BoxDecoration(
                                color: _isSelectedTime[4]
                                    ? $$lightGrey
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: const Center(child: Text('1년'))),
                          Ink(
                              width: 38,
                              height: 38,
                              decoration: BoxDecoration(
                                color: _isSelectedTime[5]
                                    ? $$lightGrey
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: const Center(
                                  child: Icon(Icons.calendar_month))),
                        ],
                      ),
                    ),
                  ),
                  ToggleButtons(
                    direction: Axis.horizontal,
                    onPressed: (int index) {
                      setState(() {
                        // The button that is tapped is set to true, and the others to false.
                        for (int i = 0; i < _selectedUnit.length; i++) {
                          _selectedUnit[i] = i == index;
                        }
                      });
                    },
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    selectedBorderColor: Colors.grey[600],
                    selectedColor: Colors.white,
                    fillColor: Colors.grey[600],
                    color: Colors.grey[400],
                    constraints: const BoxConstraints(
                      minHeight: 30.0,
                      minWidth: 70.0,
                    ),
                    isSelected: _selectedUnit,
                    children: valueUnit,
                  ),
                ])));
  }

  List<EarningsData> getChartData(Time time) {
    List<EarningsData> chartData = [];
    if (time == Time.week) {
      chartData = [
        EarningsData('기타', 6, 2),
        EarningsData('쿠팡', 4, 5),
        EarningsData('11번가', 9, 6),
        EarningsData('하이버', 5, 9),
        EarningsData('에이블리', 6, 7),
        EarningsData('지마켓', 4, 2),
      ];
    } else if (time == Time.month) {
      chartData = [
        EarningsData('기타', 6, 3),
        EarningsData('쿠팡', 4, 5),
        EarningsData('11번가', 9, 6),
        EarningsData('하이버', 5, 9),
        EarningsData('에이블리', 6, 7),
        EarningsData('지마켓', 4, 2),
      ];
    } else if (time == Time.threeMonth) {
      chartData = [
        EarningsData('지마켓', 4, 2),
        EarningsData('에이블리', 6, 7),
        EarningsData('하이버', 5, 9),
        EarningsData('11번가', 9, 6),
        EarningsData('쿠팡', 4, 5),
        EarningsData('기타', 6, 3),
      ];
    } else if (time == Time.sixMonth) {
      chartData = [
        EarningsData('지마켓', 4, 2),
        EarningsData('에이블리', 6, 7),
        EarningsData('하이버', 5, 9),
        EarningsData('11번가', 9, 6),
        EarningsData('쿠팡', 4, 5),
        EarningsData('기타', 6, 3),
      ];
    } else if (time == Time.year) {
      chartData = [
        EarningsData('지마켓', 4, 2),
        EarningsData('에이블리', 6, 7),
        EarningsData('하이버', 5, 9),
        EarningsData('11번가', 9, 6),
        EarningsData('쿠팡', 4, 5),
        EarningsData('기타', 6, 3),
      ];
    }
    return chartData;
  }
}

class EarningsData {
  EarningsData(this.earningsCategory, this.sold, this.unSold);
  final String earningsCategory;
  final int sold;
  final int unSold;
}
