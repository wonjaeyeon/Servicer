import 'package:flutter/material.dart';
import 'package:servicer/design_standards/colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../../../data_handler/mapData_handler/mapData_time.dart';
import '../../../../../../../data_handler/text/chart_text.dart';
import '../../../../../../../design_standards/text_styles.dart';
import '../../../../../../../design_standards/widget_styles.dart';

import '../../../../../../../../data_handler/data_standards/time.dart';
import '../../../../bottomsheet.dart';
import '../../../abstract_class/abstractChart.dart';
import 'sub/analysis/total_summary_analysis.dart';
import 'sub/chart/_multi_view_chart_maker/multi_view_chart.dart';
import 'sub/chart/line_zone_view/line_zone.dart';
import 'sub/chart/summary_view/summary_chart.dart';

class CurrencyFlowChartV2 extends StatefulWidget {
  CurrencyFlowChartV2({Key? key, required double width}) : super(key: key);

  @override
  State<CurrencyFlowChartV2> createState() => _CurrencyFlowChartV2State();
}

class _CurrencyFlowChartV2State extends State<CurrencyFlowChartV2> {
  //late List<ExpenseData> _chartData;
  late Time time;
  late TooltipBehavior _tooltipBehavior;
  List<bool> _isSelectedTime = [true, false, false, false, false, false];
// AnimatedOpacity를 위한 변수
  bool _visible = true;
  @override
  void initState() {
    time = Time.day;
    //_chartData = getChartData(widget.time);
    _tooltipBehavior = TooltipBehavior(enable: true, color: $$Grey, opacity: 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double _verticalPadding = 15;
    final double _horizontalPadding = 15;
    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        const SizedBox(
          height: 10,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: TimeClickerV2(
            isSelectedTime: _isSelectedTime,
            callbackFunction: callbackFunction,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        //현재 그래프 기간
        Padding(
          padding: $AnalyticsPageHorizontalPadding,
          child: Text(getTimeRange(time),
              style: TextStyle(fontSize: $mediumFontSize - 2)),
        ),
        const SizedBox(
          height: 10,
        ),
        SingleChildScrollView(
          // physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: _verticalPadding),
              Row(
                children: [
                  SizedBox(width: _horizontalPadding),
                  // 상세 그래프
                  Flexible(
                    child: AspectRatio(
                      aspectRatio: 1.2,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: [
                            Flexible(
                              child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: SummaryViewChart()),
                            ),
                            Divider(thickness: 1, height: 0),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Container(
                                        color: Colors.white,
                                      ),
                                    ));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                  child: Text('상세 보기'),
                                  alignment: Alignment.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: _horizontalPadding),
                  // 주문건수
                  Flexible(
                    child: AspectRatio(
                      aspectRatio: 1.2,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: [
                            Flexible(
                              child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: SummaryViewChart()),
                            ),
                            Divider(thickness: 1, height: 0),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Container(
                                        color: Colors.white,
                                      ),
                                    ));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                  child: Text('상세 보기'),
                                  alignment: Alignment.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: _horizontalPadding),
                ],
              ),
              SizedBox(height: _verticalPadding),
              Row(
                children: [
                  SizedBox(width: _horizontalPadding),
                  // 상세 그래프
                  Flexible(
                    child: AspectRatio(
                      aspectRatio: 1.2,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: [
                            Flexible(
                              child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: SummaryViewChart()),
                            ),
                            Divider(thickness: 1, height: 0),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Container(
                                        color: Colors.white,
                                      ),
                                    ));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                  child: Text('상세 보기'),
                                  alignment: Alignment.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: _horizontalPadding),
                  // 주문건수
                  Flexible(
                    child: AspectRatio(
                      aspectRatio: 1.2,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: [
                            Flexible(
                              child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Expanded(
                                    child: LineZone(
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                    ),
                                  )),
                            ),
                            Divider(thickness: 1, height: 0),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Container(
                                        color: Colors.white,
                                      ),
                                    ));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                  child: Text('상세 보기'),
                                  alignment: Alignment.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: _horizontalPadding),
                ],
              ),
              SizedBox(height: _verticalPadding),
              // 주문수 XY 그래프
              Padding(
                padding: EdgeInsets.symmetric(horizontal: _horizontalPadding),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        child: Container(
                          color: Colors.white,
                        ),
                      ),
                      Divider(thickness: 1, height: 0),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Container(
                                  color: Colors.white,
                                ),
                              ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            child: Text('판매처 분석 보기'),
                            alignment: Alignment.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: _verticalPadding),
              // 매출 비율 그래프
              Padding(
                padding: EdgeInsets.symmetric(horizontal: _horizontalPadding),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Container(
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: _verticalPadding),
              // 성별 비율 그래프
              Row(
                children: [
                  SizedBox(width: _horizontalPadding),
                  Flexible(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Container(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: _horizontalPadding),
                  Flexible(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Container(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: _horizontalPadding),
                ],
              ),
              SizedBox(height: _verticalPadding),
              Row(
                children: [
                  SizedBox(width: _horizontalPadding),
                  Flexible(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Container(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: _horizontalPadding),
                  Flexible(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Container(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: _horizontalPadding),
                ],
              ),
              SizedBox(height: _verticalPadding),
            ],
          ),
        ),
      ],
    );
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

class ExpenseData {
  ExpenseData(this.expenseCategory, this.profit, this.expense);
  final String expenseCategory;
  final num profit;
  final num expense;
}

//make a function inputs time and outputs time range by subtract time from today
String getTimeRange(Time time) {
  DateTime now = DateTime.now();
  String today = '${now.year}.${now.month}.${now.day}';

  // get StartDate by subtracting time from today
  DateTime startDate = now.subtract(Duration(days: getTimeLength(time)));
  String start = '${startDate.year}.${startDate.month}.${startDate.day}';
  return '$start ~ $today';
}
