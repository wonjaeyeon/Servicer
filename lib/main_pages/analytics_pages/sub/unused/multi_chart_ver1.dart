import 'package:servicer/data_handler/data_standards/category.dart';
import 'package:servicer/design_standards/widget_styles.dart';
import 'package:flutter/material.dart';
import '../../../../d_widget_maker/_mixed_chart_maker/mixed_chart.dart';
import '../../../../design_standards/colors.dart';
import '../../../../design_standards/text_styles.dart';
import '../../../../data_handler/data_standards/time.dart';
import '../bottomsheet.dart';

// class _LineChart extends StatelessWidget {
//   final Map<String, dynamic> data;
//   _LineChart({Key? key, required this.data}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     //print(lineBarsData);
//     return LineChart(
//       lineChartDataMultiLine,
//       swapAnimationDuration: const Duration(milliseconds: 400),
//     );
//   }

//   LineChartData get lineChartDataMultiLine => LineChartData(
//         lineTouchData: lineTouchData,
//         gridData: gridData,
//         titlesData: titlesData,
//         borderData: borderData,

//         //NOTE flSpotList comes
//         lineBarsData: mapOfFlSpotToLineChartBarData(
//             mapOfFlSpotXpointConverter(mapToMapOfFlSpot(data))),
//       );

//   LineTouchData get lineTouchData => LineTouchData(
//         handleBuiltInTouches: true,
//         getTouchedSpotIndicator:
//             (LineChartBarData barData, List<int> spotIndexes) {
//           return spotIndexes.map((spotIndex) {
//             final spot = barData.spots[spotIndex];

//             return TouchedSpotIndicatorData(
//               FlLine(color: $$Grey, strokeWidth: 0.9),
//               FlDotData(
//                 getDotPainter: (spot, percent, barData, index) {
//                   return FlDotCirclePainter(
//                       radius: 0.2,
//                       //color: $$mainColor4,
//                       color: barData.color,
//                       strokeWidth: 5,
//                       strokeColor: barData.color);
//                 },
//               ),
//             );
//           }).toList();
//         },
//         touchTooltipData: LineTouchTooltipData(
//             tooltipBgColor: $$lightGrey,
//             getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
//               return touchedBarSpots.map((barSpot) {
//                 final flSpot = barSpot;

//                 TextAlign textAlign;
//                 switch (flSpot.x.toInt()) {
//                   case 0:
//                     textAlign = TextAlign.left;
//                     break;

//                   default:
//                     textAlign = TextAlign.center;
//                 }

//                 return LineTooltipItem(
//                   '',
//                   const TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold,
//                   ),
//                   children: [
//                     // TextSpan(
//                     //   text: '$barSpot.title',
//                     //   style: TextStyle(
//                     //     color: $$Grey,
//                     //     fontWeight: FontWeight.normal,
//                     //   ),
//                     // ),
//                     // TextSpan(
//                     //   text: '2022.08.',
//                     //   style: TextStyle(
//                     //     color: $$Grey,
//                     //     fontWeight: FontWeight.normal,
//                     //   ),
//                     // ),
//                     // TextSpan(
//                     //   text: ChartText().dateBySubtractingXFromEndDate(
//                     //       flSpot.x.toInt(), 20220830),
//                     //   style: TextStyle(
//                     //     color: $$Grey,
//                     //     fontWeight: FontWeight.normal,
//                     //   ),
//                     // ),
//                     TextSpan(
//                       text: "Will Be Fixed",
//                       style: TextStyle(
//                         color: $$Grey,
//                         fontWeight: FontWeight.normal,
//                       ),
//                     ),
//                     TextSpan(
//                       text: '\n',
//                       style: TextStyle(
//                         color: $$Grey,
//                         fontWeight: FontWeight.normal,
//                       ),
//                     ),
//                     TextSpan(
//                       text: (flSpot.y).toInt().toString(),
//                       style: const TextStyle(
//                         color: Colors.black,
//                         fontWeight: FontWeight.normal,
//                       ),
//                     ),
//                     const TextSpan(
//                       text: ' 원',
//                       style: TextStyle(
//                         //fontStyle: FontStyle.italic,
//                         fontWeight: FontWeight.normal,
//                       ),
//                     ),
//                     // TextSpan(
//                     //   text: (flSpot.y / 100).toInt().toString(),
//                     //   style: TextStyle(
//                     //     color: $$Grey,
//                     //     fontWeight: FontWeight.normal,
//                     //   ),
//                     // ),
//                     // TextSpan(
//                     //   text: ' 건 ',
//                     //   style: TextStyle(
//                     //     //fontStyle: FontStyle.italic,
//                     //     color: $$Grey,
//                     //     fontWeight: FontWeight.normal,
//                     //   ),
//                     // ),
//                   ],
//                   textAlign: textAlign,
//                 );
//               }).toList();
//             }),
//       );

//   FlTitlesData get titlesData => FlTitlesData(
//         bottomTitles: AxisTitles(),
//         rightTitles: AxisTitles(
//           sideTitles: SideTitles(showTitles: false),
//         ),
//         topTitles: AxisTitles(
//           sideTitles: SideTitles(showTitles: false),
//         ),
//         leftTitles: AxisTitles(),
//       );

//   // Widget leftTitleWidgets(double value, TitleMeta meta) {
//   //   const style = TextStyle(
//   //     color: Color(0xff75729e),
//   //     fontWeight: FontWeight.bold,
//   //     fontSize: 14,
//   //   );
//   //   String text;
//   //   switch (value.toInt()) {
//   //     case 1:
//   //       text = '1m';
//   //       break;
//   //     case 2:
//   //       text = '2m';
//   //       break;
//   //     case 3:
//   //       text = '3m';
//   //       break;
//   //     case 4:
//   //       text = '5m';
//   //       break;
//   //     case 5:
//   //       text = '6m';
//   //       break;
//   //     default:
//   //       return Container();
//   //   }

//   //   return Text(text, style: style, textAlign: TextAlign.center);
//   // }

//   // SideTitles leftTitles() => SideTitles(
//   //       getTitlesWidget: leftTitleWidgets,
//   //       showTitles: true,
//   //       interval: 1,
//   //       reservedSize: 40,
//   //     );

//   // Widget bottomTitleWidgets(double value, TitleMeta meta) {
//   //   const style = TextStyle(
//   //     color: Color(0xff72719b),
//   //     fontWeight: FontWeight.bold,
//   //     fontSize: 16,
//   //   );
//   //   Widget text;
//   //   switch (value.toInt()) {
//   //     case 2:
//   //       text = const Text('SEPT', style: style);
//   //       break;
//   //     case 7:
//   //       text = const Text('OCT', style: style);
//   //       break;
//   //     case 12:
//   //       text = const Text('DEC', style: style);
//   //       break;
//   //     default:
//   //       text = const Text('');
//   //       break;
//   //   }

//   //   return SideTitleWidget(
//   //     axisSide: meta.axisSide,
//   //     space: 10,
//   //     child: text,
//   //   );
//   // }

//   // SideTitles get bottomTitles => SideTitles(
//   //       showTitles: true,
//   //       reservedSize: 32,
//   //       interval: 1,
//   //       getTitlesWidget: bottomTitleWidgets,
//   //     );

//   FlGridData get gridData => FlGridData(show: false);

//   FlBorderData get borderData => FlBorderData(
//         show: true,
//         border: const Border(
//           bottom: BorderSide(color: Colors.transparent),
//           left: BorderSide(color: Colors.transparent),
//           right: BorderSide(color: Colors.transparent),
//           top: BorderSide(color: Colors.transparent),
//         ),
//       );
// }

/////////////////////////////////////////////////////////////////////////////////////////
//NOTE MultiLineChart 시작 부분
class MultiLineChart extends StatefulWidget {
  final String title;
  final Map<String, dynamic> profitData;
  final Map<String, dynamic> priceData;
  final Map<String, dynamic> mallData;

  const MultiLineChart(
      {Key? key,
      required this.title,
      this.profitData = const {},
      this.priceData = const {},
      this.mallData = const {}})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => MultiLineChartState();
}

class MultiLineChartState extends State<MultiLineChart> {
  final List<bool> _isSelectedCategory = [
    true,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  late bool isShowingMainData;
  late Map<String, dynamic> data;

  final List<bool> _isSelectedTime = [true, false, false, false, false, false];
  late Time time;
  late CompositeDataCategory category;
  bool _visible = true;

  @override
  void initState() {
    data = widget.profitData;
    time = Time.day;
    category = CompositeDataCategory.profit;
    super.initState();
  }

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
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: $AnalyticsPageHorizontalPadding,
                      child: Text(
                        widget.title,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: $mediumFontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          ToggleButtons(
                            splashColor: Colors.transparent,
                            renderBorder: false,
                            constraints: const BoxConstraints(
                              minHeight: 15,
                              minWidth: 66,
                              maxHeight: 60,
                              maxWidth: 120,
                            ),
                            color: $$Grey,
                            fillColor: Colors.transparent,
                            selectedColor: Colors.white,
                            isSelected: _isSelectedCategory,
                            onPressed: (int newIndex) async {
                              _visible = false;

                              setState(() {
                                for (int i = 0;
                                    i < _isSelectedCategory.length;
                                    i++) {
                                  if (i == newIndex) {
                                    _isSelectedCategory[i] = true;
                                  } else {
                                    _isSelectedCategory[i] = false;
                                    switch (newIndex) {
                                      case 0:
                                        category = CompositeDataCategory.profit;
                                        data = widget.profitData;
                                        break;
                                      case 1:
                                        category =
                                            CompositeDataCategory.shoppingMall;
                                        data = widget.mallData;
                                        break;
                                      case 2:
                                        category = CompositeDataCategory.price;
                                        data = widget.priceData;
                                        break;
                                      case 3:
                                        category = CompositeDataCategory.gender;
                                        //data = widget.profitData;
                                        break;

                                      case 4:
                                        category = CompositeDataCategory.age;
                                        //data = widget.profitData;
                                        break;
                                    }
                                  }
                                }
                              });
                            },
                            children: [
                              Ink(
                                  width: 80,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: _isSelectedCategory[0]
                                        ? $$mediumGrey
                                        : $$lightGrey,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '손익비율',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: $smallFontSize,
                                      ),
                                    ),
                                  )),
                              Ink(
                                  width: 60,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    //set the background color of the button when it is selected/ not selected
                                    color: _isSelectedCategory[1]
                                        ? $$mediumGrey
                                        : $$lightGrey,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '입점몰',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: $smallFontSize,
                                      ),
                                    ),
                                  )),
                              Ink(
                                  width: 60,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: _isSelectedCategory[2]
                                        ? $$mediumGrey
                                        : $$lightGrey,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '가격',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: $smallFontSize,
                                      ),
                                    ),
                                  )),
                              Ink(
                                  width: 60,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    //set the background color of the button when it is selected/ not selected
                                    color: _isSelectedCategory[3]
                                        ? $$mediumGrey
                                        : $$lightGrey,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '성별',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: $smallFontSize,
                                      ),
                                    ),
                                  )),
                              Ink(
                                  width: 60,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: _isSelectedCategory[4]
                                        ? $$mediumGrey
                                        : $$lightGrey,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '연령대',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: $smallFontSize,
                                      ),
                                    ),
                                  )),
                              Ink(
                                  width: 100,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    //set the background color of the button when it is selected/ not selected
                                    color: _isSelectedCategory[5]
                                        ? $$mediumGrey
                                        : $$lightGrey,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '5만원 이하',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: $smallFontSize,
                                      ),
                                    ),
                                  )),
                              Ink(
                                  width: 100,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    //set the background color of the button when it is selected/ not selected
                                    color: _isSelectedCategory[6]
                                        ? $$mediumGrey
                                        : $$lightGrey,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '5만원 이상',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: $smallFontSize,
                                      ),
                                    ),
                                  )),
                              Ink(
                                  width: 100,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    //set the background color of the button when it is selected/ not selected
                                    color: _isSelectedCategory[7]
                                        ? $$mediumGrey
                                        : $$lightGrey,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '영업이익률',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: $smallFontSize,
                                      ),
                                    ),
                                  )),
                              Ink(
                                  width: 60,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    //set the background color of the button when it is selected/ not selected
                                    color: _isSelectedCategory[8]
                                        ? $$mediumGrey
                                        : $$lightGrey,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '매출',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: $smallFontSize,
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // Padding(
                //   padding: $AnalyticsPageHorizontalPadding,
                //   child: Text(
                //       ChartText().getTimeRange(MapDataTimeRange()
                //           .pickTimeRange(data, time, 20220830)),
                //       style: TextStyle(fontSize: $mediumFontSize - 2)),
                // ),
                // Padding(
                //   padding: $AnalyticsPageHorizontalPadding,
                //   child: Column(
                //       mainAxisAlignment: MainAxisAlignment.start,
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: ChartText().mapDataGradient(mapToMapOfFlSpot(
                //           MapDataTimeRange()
                //               .pickTimeRange(data, time, 20220830)))),
                // ),
                // const SizedBox(
                //   height: 37,
                // ),
                // Container(
                //   width: MediaQuery.of(context).size.width * 0.7,
                //   height: 270,
                //   margin: const EdgeInsets.all(16),
                //   padding: const EdgeInsets.all(4),
                //   child: Padding(
                //     padding: const EdgeInsets.all(4.0),
                //     child: _LineChart(
                //         data: MapDataTimeRange()
                //             .pickTimeRange(data, time, 20220830)),
                //   ),
                // ),
                // const SizedBox(
                //   height: 10,
                // ),
                AnimatedOpacity(
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
                  child: Container(
                    alignment: Alignment.center,
                    child: MixedChart().showMixedChart(data, time, category,
                        MediaQuery.of(context).size.width * 0.7),
                  ),
                ),
                Center(
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
                    onPressed: (int newIndex) {
                      setState(() {
                        for (int i = 0; i < _isSelectedTime.length; i++) {
                          if (i == newIndex) {
                            _isSelectedTime[i] = true;
                          } else {
                            _isSelectedTime[i] = false;
                            switch (newIndex) {
                              case 0:
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
                          final TimeRangePopeddata = BottomSheetTime()
                              .makeShowModalBottomSheet(context);
                          //print startDate when Navigor.pop
                          TimeRangePopeddata.then((value) {
                            if (value != null) {
                              print(value["startDate"]);
                            }
                          });
                        }
                      });
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
                          child: const Center(child: Text('일'))),
                      Ink(
                          width: 26,
                          height: 26,
                          decoration: BoxDecoration(
                            color: _isSelectedTime[1]
                                ? $$lightGrey
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: const Center(child: Text('주'))),
                      Ink(
                          width: 26,
                          height: 26,
                          decoration: BoxDecoration(
                            color: _isSelectedTime[2]
                                ? $$lightGrey
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: const Center(child: Text('월'))),
                      Ink(
                          width: 26,
                          height: 26,
                          decoration: BoxDecoration(
                            color: _isSelectedTime[3]
                                ? $$lightGrey
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: const Center(child: Text('년'))),
                      Ink(
                          width: 38,
                          height: 26,
                          decoration: BoxDecoration(
                            color: _isSelectedTime[4]
                                ? $$lightGrey
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: const Center(child: Text('전체'))),
                      Ink(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            color: _isSelectedTime[5]
                                ? $$lightGrey
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child:
                              const Center(child: Icon(Icons.calendar_month))),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
