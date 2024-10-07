import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:servicer/main_pages/analytics_pages/sub/earnings/total/multi_chart/trend/sub/t_chart_analysis.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../../../../d_widget_maker/abstract_class/abstractChart.dart';
import '../../../../../../../data_handler/data_standards/time.dart';
import '../../../../../../../design_standards/colors.dart';
import '../../../../../../../design_standards/text_styles.dart';
import '../../../../../../../design_standards/widget_styles.dart';
import '../../../../bottomsheet.dart';
import 'sub/ep_chart_analysis.dart';
import 'sub_chart/_sub_chart_maker/multi_view_chart.dart';

class ExpectedProfitChartContainer extends StatefulWidget {
  ExpectedProfitChartContainer({Key? key, required double width})
      : super(key: key);

  @override
  State<ExpectedProfitChartContainer> createState() =>
      _ExpectedProfitChartContainerState();
}

class _ExpectedProfitChartContainerState
    extends State<ExpectedProfitChartContainer>
    with FunctionForClass, WidgetForClass {
  final items = ['요약', '그래프'];
  String selectedValue = '요약';
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
                    height: 10,
                  ),
                  //현재 그래프 기간
                  Row(
                    children: [
                      Padding(
                        padding: $AnalyticsPageHorizontalPadding,
                        child: Text(getTimeRange(time),
                            style: TextStyle(fontSize: $mediumFontSize - 2)),
                      ),
                      const Spacer(),
                      //dropBox
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),

                          // dropdown below..
                          child: DropdownButton2<String>(
                            buttonDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              //give border color
                              border: Border.all(
                                color: Colors.grey,
                                width: 1,
                              ),
                              color: Colors.white,
                            ),
                            value: selectedValue,
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedValue = newValue!;
                              });
                            },
                            items: items
                                .map<DropdownMenuItem<String>>(
                                    (String value) => DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        ))
                                .toList(),

                            // add extra sugar..
                            icon: Icon(Icons.arrow_drop_down),
                            iconSize: 42,
                            underline: SizedBox(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  ExpectedProfitSubChartViewChart(
                    time: time,
                    subViewType: selectedValue,
                  ),
                  TimeClicker(
                    isSelectedTime: _isSelectedTime,
                    callbackFunction: callbackFunction,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                  ExpectedProfitChartAnalysis(
                      timeRange: getTimeRange(time), unit: "원"),
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
