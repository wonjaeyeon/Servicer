import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../d_widget_maker/abstract_class/abstractChart.dart';
import '../../../../data_handler/data_standards/time.dart';
import '../../../../design_standards/colors.dart';
import '../../../../design_standards/text_styles.dart';
import '../bottomsheet.dart';
import 'sm_data_handler/sm_data_handler.dart';

class GenderChartContainer extends StatefulWidget {
  const GenderChartContainer({super.key});

  @override
  State<GenderChartContainer> createState() => _GenderChartContainerState();
}

class _GenderChartContainerState extends State<GenderChartContainer>
    with FunctionForClass, SMDataHandler {
  late TooltipBehavior _tooltipBehavior;
  late Time time;

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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      '성별',
                      style: TextStyle(
                          fontSize: $smallFontSize,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 140,
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
                      child: SfCartesianChart(
                        //get the number of maleOrder by using function getChartData
                        //get the number of femaleOrder by using function getChartData
                        title: ChartTitle(
                            text: getRatio(
                                time, getChartData(time)[0], getChartData)),
                        //"${getChartData(time)[0].maleOrder}:${getChartData(time)[0].femaleOrder}"),
                        plotAreaBorderWidth: 0,
                        tooltipBehavior: _tooltipBehavior,
                        series: <ChartSeries>[
                          StackedBar100Series<EarningsData, String>(
                            animationDuration: 0,
                            dataSource: getChartData(time),
                            xValueMapper: (EarningsData earnings, _) =>
                                earnings.genderCategory,
                            yValueMapper: (EarningsData earnings, _) =>
                                earnings.maleOrder,
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(10),
                                right: Radius.circular(0)),
                            dataLabelSettings: DataLabelSettings(
                              labelAlignment: ChartDataLabelAlignment.middle,
                              labelPosition: ChartDataLabelPosition.outside,
                              isVisible: getChartData(time)[0].maleOrder == 0
                                  ? false
                                  : true,
                              textStyle: const TextStyle(
                                  fontFamily: 'IBMPlexSansKR',
                                  color: Colors.white),
                            ),
                            width: 0.4,
                            name: "남성",
                          ),
                          StackedBar100Series<EarningsData, String>(
                            animationDuration: 0,
                            dataSource: getChartData(time),
                            xValueMapper: (EarningsData earnings, _) =>
                                earnings.genderCategory,
                            yValueMapper: (EarningsData earnings, _) =>
                                earnings.femaleOrder,
                            color: Color.fromARGB(255, 255, 114, 161),
                            borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(0),
                                right: Radius.circular(10)),
                            dataLabelSettings: DataLabelSettings(
                              labelAlignment: ChartDataLabelAlignment.middle,
                              isVisible: getChartData(time)[0].femaleOrder == 0
                                  ? false
                                  : true,
                              textStyle: const TextStyle(
                                  fontFamily: 'IBMPlexSansKR',
                                  color: Colors.white),
                            ),
                            width: 0.4,
                            name: "여성",
                          ),
                        ],
                        primaryXAxis: CategoryAxis(isVisible: false),
                        primaryYAxis: NumericAxis(
                          isVisible: false,
                          labelFormat: '{value}건',
                        ),
                        borderColor: Colors.transparent,
                      ),
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
                ])));
  }

  List<EarningsData> getChartData(Time time) {
    List<EarningsData> chartData = [];
    if (time == Time.week) {
      chartData = [
        EarningsData('성별비율', 16, 9),
      ];
    } else if (time == Time.month) {
      chartData = [
        EarningsData('성별비율', 36, 23),
      ];
    } else if (time == Time.threeMonth) {
      chartData = [
        EarningsData('성별비율', 114, 102),
      ];
    } else if (time == Time.sixMonth) {
      chartData = [
        EarningsData('성별비율', 204, 232),
      ];
    } else if (time == Time.year) {
      chartData = [
        EarningsData('성별비율', 434, 412),
      ];
    }
    return chartData;
  }
}

class EarningsData {
  EarningsData(this.genderCategory, this.maleOrder, this.femaleOrder);
  final String genderCategory;
  final int maleOrder;
  final int femaleOrder;
}
