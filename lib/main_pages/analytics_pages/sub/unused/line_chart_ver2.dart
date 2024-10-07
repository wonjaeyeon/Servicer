import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../d_widget_maker/abstract_class/abstractChart.dart';
import '../../../../data_handler/data_standards/time.dart';
import '../../../../design_standards/colors.dart';
import '../../../../design_standards/text_styles.dart';
import '../../../../design_standards/widget_styles.dart';
import '../bottomsheet.dart';

class LineChartContainerV2 extends StatefulWidget {
  final String title;
  final String unit;
  LineChartContainerV2({Key? key, required this.title, required this.unit})
      : super(key: key);

  @override
  State<LineChartContainerV2> createState() => _LineChartContainerV2State();
}

class _LineChartContainerV2State extends State<LineChartContainerV2>
    with FunctionForClass, WidgetForClass {
  late TooltipBehavior _tooltipBehavior;
  late Time time;

  @override
  void initState() {
    time = Time.day;
    _tooltipBehavior = TooltipBehavior(enable: true, color: $$Grey, opacity: 1);
    super.initState();
  }

  List<bool> _isSelectedTime = [true, false, false, false, false, false];
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
                  const SizedBox(
                    height: 12,
                  ),
                  Padding(
                    padding: $AnalyticsPageHorizontalPadding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 현재 그래프 타이틀
                        Text(
                          widget.title,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: $mediumFontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        //현재 그래프 기간
                        Text(getTimeRange(time),
                            style: TextStyle(fontSize: $mediumFontSize - 2)),
                        Text(
                          "합계 : 46.7만원",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: $mediumFontSize - 2),
                        ),
                        Text(
                          "증가하는 추세 : 10.30%",
                          style: TextStyle(fontSize: $mediumFontSize - 2),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 220,
                    margin: const EdgeInsets.fromLTRB(
                        30, 10, 10, 10), //*그래프 컨테이너 바깥쪽 간격
                    padding: const EdgeInsets.all(4),
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
                      child: SfCartesianChart(
                        enableAxisAnimation: false,
                        tooltipBehavior: _tooltipBehavior,
                        series: <ChartSeries>[
                          LineSeries<EarningsData, String>(
                              animationDuration: 0,
                              dataSource: getChartData(time),
                              xValueMapper: (EarningsData earnings, _) =>
                                  earnings.earningsCategory,
                              yValueMapper: (EarningsData earnings, _) =>
                                  earnings.sales,
                              color: Colors.indigo,
                              width: 2,
                              name: "매출")
                        ],
                        primaryXAxis: CategoryAxis(
                          labelStyle:
                              const TextStyle(fontFamily: 'IBMPlexSansKR'),
                        ),
                        primaryYAxis: NumericAxis(
                          labelFormat: widget.unit == '원'
                              ? '{value}만${widget.unit}'
                              : '{value}${widget.unit}',
                          opposedPosition: true,
                          labelStyle:
                              const TextStyle(fontFamily: 'IBMPlexSansKR'),
                        ),
                      ),
                    ),
                  ),
                  // Center(
                  //   child: FittedBox(
                  //     fit: BoxFit.fitWidth,
                  //     child: ToggleButtons(
                  //       splashColor: Colors.transparent,
                  //       renderBorder: false,
                  //       //borderRadius: BorderRadius.circular(15),
                  //       constraints: BoxConstraints.expand(
                  //         height: 25,
                  //         width: MediaQuery.of(context).size.width * 0.13,
                  //       ),
                  //       color: $$Grey,
                  //       fillColor: Colors.transparent,
                  //       selectedColor: Colors.black,
                  //       isSelected: _isSelectedTime,
                  //       onPressed: (int newIndex) async {
                  //         setState(() {
                  //           //_visible = false;
                  //           for (int i = 0; i < _isSelectedTime.length; i++) {
                  //             if (i == newIndex) {
                  //               _isSelectedTime[i] = true;
                  //             } else {
                  //               _isSelectedTime[i] = false;
                  //               switch (newIndex) {
                  //                 case 0:
                  //                   //sleep(Duration(milliseconds: 50));
                  //                   time = Time.day;
                  //                   break;
                  //                 case 1:
                  //                   time = Time.week;
                  //                   break;
                  //                 case 2:
                  //                   time = Time.month;
                  //                   break;
                  //                 case 3:
                  //                   time = Time.year;
                  //                   break;
                  //                 case 4:
                  //                   time = Time.all;
                  //                   break;
                  //                 case 5:
                  //                   break;
                  //               }
                  //             }
                  //             //print(_isSelectedTime);
                  //           }
                  //           if (newIndex == 5) {
                  //             final data = BottomSheetTime()
                  //                 .makeShowModalBottomSheet(context);
                  //             //print startDate whien Navigor.pop
                  //             data.then((value) {
                  //               if (value != null) {
                  //                 print(value["startDate"]);
                  //               }
                  //             });
                  //           } else {
                  //             _visible = false;
                  //           }
                  //         });
                  //         await Future.delayed(Duration(milliseconds: 800));
                  //       },
                  //       children: [
                  //         Ink(
                  //             width: 26,
                  //             height: 26,
                  //             decoration: BoxDecoration(
                  //               color: _isSelectedTime[0]
                  //                   ? $$lightGrey
                  //                   : Colors.transparent,
                  //               borderRadius: BorderRadius.circular(100),
                  //             ),
                  //             child: const Center(child: Text('일'))),
                  //         Ink(
                  //             width: 26,
                  //             height: 26,
                  //             decoration: BoxDecoration(
                  //               color: _isSelectedTime[1]
                  //                   ? $$lightGrey
                  //                   : Colors.transparent,
                  //               borderRadius: BorderRadius.circular(100),
                  //             ),
                  //             child: const Center(child: Text('주'))),
                  //         Ink(
                  //             width: 26,
                  //             height: 26,
                  //             decoration: BoxDecoration(
                  //               color: _isSelectedTime[2]
                  //                   ? $$lightGrey
                  //                   : Colors.transparent,
                  //               borderRadius: BorderRadius.circular(100),
                  //             ),
                  //             child: const Center(child: Text('월'))),
                  //         Ink(
                  //             width: 26,
                  //             height: 26,
                  //             decoration: BoxDecoration(
                  //               color: _isSelectedTime[3]
                  //                   ? $$lightGrey
                  //                   : Colors.transparent,
                  //               borderRadius: BorderRadius.circular(100),
                  //             ),
                  //             child: const Center(child: Text('년'))),
                  //         Ink(
                  //             width: 38,
                  //             height: 26,
                  //             decoration: BoxDecoration(
                  //               color: _isSelectedTime[4]
                  //                   ? $$lightGrey
                  //                   : Colors.transparent,
                  //               borderRadius: BorderRadius.circular(100),
                  //             ),
                  //             child: const Center(child: Text('전체'))),
                  //         Ink(
                  //             width: 38,
                  //             height: 38,
                  //             decoration: BoxDecoration(
                  //               color: _isSelectedTime[5]
                  //                   ? $$lightGrey
                  //                   : Colors.transparent,
                  //               borderRadius: BorderRadius.circular(100),
                  //             ),
                  //             child: const Center(
                  //                 child: Icon(Icons.calendar_month))),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  TimeClicker(
                    isSelectedTime: _isSelectedTime,
                    callbackFunction: callbackFunction,
                  )
                ])));
  }

  List<EarningsData> getChartData(Time time) {
    List<EarningsData> chartData = [];
    if (time == Time.day) {
      chartData = [
        EarningsData('12:00', 3),
        EarningsData('13:00', 5),
        EarningsData('14:00', 4),
        EarningsData('15:00', 5),
        EarningsData('16:00', 4),
        EarningsData('17:00', 5),
        EarningsData('18:00', 4),
        EarningsData('19:00', 5),
        EarningsData('20:00', 4),
        EarningsData('21:00', 5),
        EarningsData('22:00', 6),
        EarningsData('23:00', 3)
      ];
    } else if (time == Time.week) {
      chartData = [
        EarningsData('Mon', 15),
        EarningsData('Tue', 20),
        EarningsData('Wed', 13),
        EarningsData('Thu', 15),
        EarningsData('Fri', 21),
        EarningsData('Sat', 23),
        EarningsData('Sun', 17),
      ];
    } else if (time == Time.month) {
      chartData = [
        EarningsData('1주', 15 * 7),
        EarningsData('2주', 20 * 7),
        EarningsData('3주', 16 * 7),
        EarningsData('4주', 18 * 7),
      ];
    } else if (time == Time.year) {
      chartData = [
        EarningsData('Jan', 15 * 31),
        EarningsData('Feb', 20 * 28),
        EarningsData('Mar', 16 * 31),
        EarningsData('Apr', 15 * 30),
        EarningsData('May', 19 * 31),
        EarningsData('Jun', 21 * 30),
        EarningsData('Jul', 24 * 31),
        EarningsData('Aug', 18 * 31),
        EarningsData('Sep', 19 * 30),
        EarningsData('Oct', 17 * 31),
        EarningsData('Nov', 18 * 30),
        EarningsData('Dec', 16 * 31),
      ];
    } else if (time == Time.all) {
      chartData = [
        EarningsData('2021.1월', 15 * 31),
        EarningsData('2021.2월', 20 * 28),
        EarningsData('2021.3월', 16 * 31),
        EarningsData('2021.4월', 15 * 30),
        EarningsData('2021.5월', 19 * 31),
        EarningsData('2021.6월', 21 * 30),
        EarningsData('2021.7월', 24 * 31),
        EarningsData('2021.8월', 18 * 31),
        EarningsData('2021.9월', 19 * 30),
        EarningsData('2021.10월', 17 * 31),
        EarningsData('2021.11월', 18 * 30),
        EarningsData('2021.12월', 16 * 31),
        EarningsData('2022.1월', 15 * 31),
        EarningsData('2022.2월', 20 * 28),
        EarningsData('2022.3월', 16 * 31),
        EarningsData('2022.4월', 15 * 30),
        EarningsData('2022.5월', 19 * 31),
        EarningsData('2022.6월', 21 * 30),
        EarningsData('2022.7월', 24 * 31),
        EarningsData('2022.8월', 18 * 31),
        EarningsData('2022.9월', 19 * 30),
        EarningsData('2022.10월', 17 * 31),
        EarningsData('2022.11월', 18 * 30),
        EarningsData('2022.12월', 16 * 31),
      ];
    }
    return chartData;
  }

  Future<void> callbackFunction(int newIndex) async {
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
              time = Time.day;
              break;
            case 1:
              time = Time.week;
              break;
            case 2:
              time = Time.month;
              break;
            case 3:
              time = Time.year;
              break;
            case 4:
              time = Time.all;
              break;
            case 5:
              break;
          }
        }
        //print(_isSelectedTime);
      }
      if (newIndex == 5) {
        final data = BottomSheetTime().makeShowModalBottomSheet(context);
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
  }
}

class EarningsData {
  EarningsData(this.earningsCategory, this.sales);
  final String earningsCategory;
  final int sales;
}
