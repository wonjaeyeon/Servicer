import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../d_widget_maker/abstract_class/abstractChart.dart';
import '../../../../data_handler/data_standards/time.dart';
import '../../../../design_standards/colors.dart';
import '../../../../design_standards/text_styles.dart';
import '../bottomsheet.dart';

class AgeChartContainer extends StatefulWidget {
  const AgeChartContainer({super.key});

  @override
  State<AgeChartContainer> createState() => _AgeChartContainerState();
}

class _AgeChartContainerState extends State<AgeChartContainer>
    with FunctionForClass {
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
                      '연령',
                      style: TextStyle(
                          fontSize: $smallFontSize,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 120,
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
                        //plotAreaBorderWidth: 0,
                        tooltipBehavior: _tooltipBehavior,
                        series: <ChartSeries>[
                          ColumnSeries<EarningsData, String>(
                            animationDuration: 0,
                            dataSource: getChartData(time),
                            xValueMapper: (EarningsData earnings, _) =>
                                earnings.genderCategory,
                            yValueMapper: (EarningsData earnings, _) =>
                                earnings.ageOrder,
                            color: Colors.greenAccent[200],
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(2),
                                bottom: Radius.circular(0)),
                            dataLabelSettings: DataLabelSettings(
                              labelAlignment: ChartDataLabelAlignment.top,
                              offset: Offset(0, 30),
                              isVisible: true,
                              textStyle: const TextStyle(
                                  fontFamily: 'IBMPlexSansKR',
                                  color: Color.fromARGB(255, 0, 0, 0)),
                            ),
                            width: 0.4,
                            //name: '${EarningsData.earningsCategory}',
                          ),
                        ],
                        primaryXAxis: CategoryAxis(isVisible: true),
                        primaryYAxis: NumericAxis(
                          isVisible: true,
                          opposedPosition: true,
                          labelFormat: '{value}건',
                          labelStyle:
                              const TextStyle(fontFamily: 'IBMPlexSansKR'),
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
        EarningsData('~20', 16),
        EarningsData('20~30', 20),
        EarningsData('30~40', 15),
        EarningsData('40~50', 10),
        EarningsData('50~60', 8),
        EarningsData('60~', 7),
      ];
    } else if (time == Time.month) {
      chartData = [
        EarningsData('~20', 16 * 4),
        EarningsData('20~30', 14 * 4),
        EarningsData('30~40', 10 * 4),
        EarningsData('40~50', 11 * 4),
        EarningsData('50~60', 9 * 4),
        EarningsData('60~', 5 * 4),
      ];
    } else if (time == Time.threeMonth) {
      chartData = [
        EarningsData('~20', 14 * 4 * 3),
        EarningsData('20~30', 12 * 4 * 3),
        EarningsData('30~40', 17 * 4 * 3),
        EarningsData('40~50', 21 * 4 * 3),
        EarningsData('50~60', 25 * 4 * 3),
        EarningsData('60~', 5 * 4 * 3),
      ];
    } else if (time == Time.sixMonth) {
      chartData = [
        EarningsData('~20', 16 * 4 * 6),
        EarningsData('20~30', 17 * 4 * 6),
        EarningsData('30~40', 13 * 4 * 6),
        EarningsData('40~50', 18 * 4 * 6),
        EarningsData('50~60', 15 * 4 * 6),
        EarningsData('60~', 5 * 4 * 6),
      ];
    } else if (time == Time.year) {
      chartData = [
        EarningsData('~20', 16 * 4 * 12),
        EarningsData('20~30', 17 * 4 * 12),
        EarningsData('30~40', 13 * 4 * 12),
        EarningsData('40~50', 18 * 4 * 12),
        EarningsData('50~60', 15 * 4 * 12),
        EarningsData('60~', 5 * 4 * 12),
      ];
    }
    return chartData;
  }
}

class EarningsData {
  EarningsData(this.genderCategory, this.ageOrder);
  final String genderCategory;
  final int ageOrder;
}
