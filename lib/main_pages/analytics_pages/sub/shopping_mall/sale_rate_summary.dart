import 'package:flutter/material.dart';
import 'package:servicer/main_pages/analytics_pages/sub/shopping_mall/sm_data_handler/sm_data_handler.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../d_widget_maker/abstract_class/abstractChart.dart';
import '../../../../data_handler/data_standards/time.dart';
import '../../../../design_standards/colors.dart';
import '../../../../design_standards/text_styles.dart';
import '../../../../design_standards/widget_styles.dart';
import '../bottomsheet.dart';

class SummaryChartContainer extends StatefulWidget {
  final String title;
  final String unit;
  SummaryChartContainer({Key? key, required this.title, required this.unit})
      : super(key: key);

  @override
  State<SummaryChartContainer> createState() => _SummaryChartContainerState();
}

class _SummaryChartContainerState extends State<SummaryChartContainer>
    with FunctionForClass, SMDataHandler {
  late TooltipBehavior _tooltipBehavior;
  late Time time;

  @override
  void initState() {
    time = Time.day;
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
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      AnimatedOpacity(
                        opacity: _visible ? 1.0 : 0.0,
                        duration: _visible
                            ? const Duration(milliseconds: 400)
                            : const Duration(milliseconds: 0),
                        onEnd: () async => {
                          await Future.delayed(
                              const Duration(milliseconds: 400)),
                          setState(() {
                            _visible = true;
                          })
                        },
                        child: Column(
                          children: [
                            Text("실구매율",
                                style: TextStyle(fontSize: $mediumFontSize)),
                            Text(getSoldRate(time, getChartData),
                                style: TextStyle(fontSize: $mediumFontSize)),
                            Text(getSoldTotalRatio(time, getChartData),
                                style: TextStyle(fontSize: $smallFontSize)),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 290,
                        margin: const EdgeInsets.fromLTRB(
                            0, 0, 0, 0), //*그래프 컨테이너 바깥쪽 간격
                        //padding: const EdgeInsets.all(4),
                        child: AnimatedOpacity(
                          opacity: _visible ? 1.0 : 0.0,
                          duration: _visible
                              ? const Duration(milliseconds: 400)
                              : const Duration(milliseconds: 0),
                          onEnd: () async => {
                            await Future.delayed(
                                const Duration(milliseconds: 400)),
                            setState(() {
                              _visible = true;
                            })
                          },
                          child: SfCircularChart(
                            tooltipBehavior: _tooltipBehavior,
                            series: <CircularSeries>[
                              DoughnutSeries<EarningsData, String>(
                                animationDuration: 0,
                                dataSource: getChartData(time),
                                xValueMapper: (EarningsData earnings, _) =>
                                    earnings.earningsCategory,
                                yValueMapper: (EarningsData earnings, _) =>
                                    earnings.salesRate,
                                pointColorMapper: (EarningsData earnings, _) =>
                                    earnings.color,
                                innerRadius: '90%',
                                startAngle: 210,
                                endAngle: 150,
                                cornerStyle: CornerStyle.bothCurve,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
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
                                    time = Time.sixMonth;
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
                              width: 26,
                              height: 26,
                              decoration: BoxDecoration(
                                color: _isSelectedTime[0]
                                    ? $$lightGrey
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: const Center(child: Text('1일'))),
                          Ink(
                              width: 26,
                              height: 26,
                              decoration: BoxDecoration(
                                color: _isSelectedTime[1]
                                    ? $$lightGrey
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: const Center(child: Text('3일'))),
                          Ink(
                              width: 26,
                              height: 26,
                              decoration: BoxDecoration(
                                color: _isSelectedTime[2]
                                    ? $$lightGrey
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: const Center(child: Text('1주'))),
                          Ink(
                              width: 38,
                              height: 26,
                              decoration: BoxDecoration(
                                color: _isSelectedTime[3]
                                    ? $$lightGrey
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: const Center(child: Text('1개월'))),
                          Ink(
                              width: 38,
                              height: 26,
                              decoration: BoxDecoration(
                                color: _isSelectedTime[4]
                                    ? $$lightGrey
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: const Center(child: Text('6개월'))),
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
                ])));
  }

  List<EarningsData> getChartData(Time time) {
    List<EarningsData> chartData = [];
    if (time == Time.day) {
      chartData = [
        EarningsData('sold', 6, Color(0xFFE46059)),
        EarningsData('unsold', 3, $$lightGrey),
      ];
    } else if (time == Time.week) {
      chartData = [
        EarningsData('sold', 6 * 7, Color(0xFFE46059)),
        EarningsData('unsold', 4 * 7, $$lightGrey),
      ];
    } else if (time == Time.month) {
      chartData = [
        EarningsData('sold', 6 * 28, Color(0xFFE46059)),
        EarningsData('unsold', 4 * 29, $$lightGrey),
      ];
    } else if (time == Time.year) {
      chartData = [
        EarningsData('sold', 6 * 28 * 12, Color(0xFFE46059)),
        EarningsData('unsold', 4 * 30 * 12, $$lightGrey),
      ];
    } else if (time == Time.sixMonth) {
      chartData = [
        EarningsData('sold', 6 * 28 * 12 * 2, Color(0xFFE46059)),
        EarningsData('unsold', 4 * 30 * 11 * 2, $$lightGrey),
      ];
    }
    return chartData;
  }
}

class EarningsData {
  EarningsData(this.earningsCategory, this.salesRate, this.color);
  final String earningsCategory;
  final int salesRate;
  final Color color;
}
