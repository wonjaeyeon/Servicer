import 'package:servicer/data_handler/data_standards/category.dart';
import 'package:servicer/design_standards/widget_styles.dart';
import 'package:flutter/material.dart';
import '../../../../../../../design_standards/colors.dart';
import '../../../../../../../design_standards/text_styles.dart';
import '../../../../../../../data_handler/data_standards/time.dart';
import '../../../../bottomsheet.dart';
import 'mixed_chart_selector.dart';
import '../../../abstract_class/abstractChart.dart';

class MultiChartV2 extends StatefulWidget {
  final String title;
  final Map<String, dynamic> profitData;
  final Map<String, dynamic> priceData;
  final Map<String, dynamic> mallData;

  const MultiChartV2(
      {Key? key,
      required this.title,
      this.profitData = const {},
      this.priceData = const {},
      this.mallData = const {}})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => MultiChartV2State();
}

class MultiChartV2State extends State<MultiChartV2>
    with MixedChart, FunctionForClass {
  final List<bool> _isSelectedCategory = [
    true,
    false,
    false,
    false,
  ];
  late bool isShowingMainData;
  late Map<String, dynamic> data;

  //final List<bool> _isSelectedTime = [true, false, false, false, false, false];
  late Time time;
  late CompositeDataCategory category;
  bool _visible = true;

  @override
  void initState() {
    data = widget.mallData;
    time = Time.day;
    category = CompositeDataCategory.shoppingMall;
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
                      height: 16,
                    ),
                    // Padding(
                    //   padding: $AnalyticsPageHorizontalPadding,
                    //   child: Text(
                    //     widget.title,
                    //     style: TextStyle(
                    //       color: Colors.black,
                    //       fontSize: $mediumFontSize,
                    //       fontWeight: FontWeight.bold,
                    //     ),
                    //   ),
                    // ),
                    // const SizedBox(
                    //   height: 4,
                    // ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      //physics: const AlwaysScrollableScrollPhysics(),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          ToggleButtons(
                            splashColor: Colors.transparent,
                            renderBorder: false,
                            constraints: BoxConstraints(
                              minHeight: 15,
                              minWidth: 66,
                              maxHeight: 60,
                              maxWidth: MediaQuery.of(context).size.width,
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
                                      // case 0:
                                      //   category = MapDataCategory.profit;
                                      //   data = widget.profitData;
                                      //   break;
                                      case 0:
                                        category =
                                            CompositeDataCategory.shoppingMall;
                                        data = widget.mallData;
                                        break;
                                      case 1:
                                        category = CompositeDataCategory.price;
                                        data = widget.priceData;
                                        break;
                                      case 2:
                                        category = CompositeDataCategory.gender;
                                        //data = widget.profitData;
                                        break;

                                      case 3:
                                        category = CompositeDataCategory.age;
                                        //data = widget.profitData;
                                        break;
                                    }
                                  }
                                }
                              });
                            },
                            children: [
                              // Ink(
                              //     width: 80,
                              //     height: 30,
                              //     decoration: BoxDecoration(
                              //       color: _isSelectedCategory[0]
                              //           ? $$mediumGrey
                              //           : $$lightGrey,
                              //       borderRadius: BorderRadius.circular(10),
                              //     ),
                              //     child: Center(
                              //       child: Text(
                              //         '매입매출',
                              //         textAlign: TextAlign.left,
                              //         style: TextStyle(
                              //           fontSize: $smallFontSize,
                              //         ),
                              //       ),
                              //     )),
                              Ink(
                                  width: 60,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    //set the background color of the button when it is selected/ not selected
                                    color: _isSelectedCategory[0]
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
                              // Row(
                              //   mainAxisSize: MainAxisSize.min,
                              //   children: [
                              //     const SizedBox(
                              //       width: 1,
                              //     ),
                              //     Container(
                              //       width: 1,
                              //       height: 20,
                              //       color: $$Grey,
                              //     ),
                              //     const SizedBox(
                              //       width: 4,
                              //     ),
                              //     Ink(
                              //         width: 60,
                              //         height: 30,
                              //         decoration: BoxDecoration(
                              //           color: _isSelectedCategory[1]
                              //               ? $$mediumGrey
                              //               : $$lightGrey,
                              //           borderRadius: BorderRadius.circular(10),
                              //         ),
                              //         child: Center(
                              //           child: Text(
                              //             '가격',
                              //             textAlign: TextAlign.left,
                              //             style: TextStyle(
                              //               fontSize: $smallFontSize,
                              //             ),
                              //           ),
                              //         )),
                              //     const SizedBox(
                              //       width: 4,
                              //     ),
                              //     Container(
                              //       width: 1,
                              //       height: 20,
                              //       color: $$Grey,
                              //     ),
                              //     const SizedBox(
                              //       width: 1,
                              //     ),
                              //   ],
                              // ),
                              Ink(
                                  width: 60,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: _isSelectedCategory[1]
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
                                    color: _isSelectedCategory[2]
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
                                    color: _isSelectedCategory[3]
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
                              // Ink(
                              //     width: 100,
                              //     height: 30,
                              //     decoration: BoxDecoration(
                              //       //set the background color of the button when it is selected/ not selected
                              //       color: _isSelectedCategory[5]
                              //           ? $$mediumGrey
                              //           : $$lightGrey,
                              //       borderRadius: BorderRadius.circular(10),
                              //     ),
                              //     child: Center(
                              //       child: Text(
                              //         '5만원 이하',
                              //         textAlign: TextAlign.left,
                              //         style: TextStyle(
                              //           fontSize: $smallFontSize,
                              //         ),
                              //       ),
                              //     )),
                              // Ink(
                              //     width: 100,
                              //     height: 30,
                              //     decoration: BoxDecoration(
                              //       //set the background color of the button when it is selected/ not selected
                              //       color: _isSelectedCategory[6]
                              //           ? $$mediumGrey
                              //           : $$lightGrey,
                              //       borderRadius: BorderRadius.circular(10),
                              //     ),
                              //     child: Center(
                              //       child: Text(
                              //         '5만원 이상',
                              //         textAlign: TextAlign.left,
                              //         style: TextStyle(
                              //           fontSize: $smallFontSize,
                              //         ),
                              //       ),
                              //     )),
                              // Ink(
                              //     width: 100,
                              //     height: 30,
                              //     decoration: BoxDecoration(
                              //       //set the background color of the button when it is selected/ not selected
                              //       color: _isSelectedCategory[7]
                              //           ? $$mediumGrey
                              //           : $$lightGrey,
                              //       borderRadius: BorderRadius.circular(10),
                              //     ),
                              //     child: Center(
                              //       child: Text(
                              //         '영업이익률',
                              //         textAlign: TextAlign.left,
                              //         style: TextStyle(
                              //           fontSize: $smallFontSize,
                              //         ),
                              //       ),
                              //     )),
                              // Ink(
                              //     width: 60,
                              //     height: 30,
                              //     decoration: BoxDecoration(
                              //       //set the background color of the button when it is selected/ not selected
                              //       color: _isSelectedCategory[8]
                              //           ? $$mediumGrey
                              //           : $$lightGrey,
                              //       borderRadius: BorderRadius.circular(10),
                              //     ),
                              //     child: Center(
                              //       child: Text(
                              //         '매출',
                              //         textAlign: TextAlign.left,
                              //         style: TextStyle(
                              //           fontSize: $smallFontSize,
                              //         ),
                              //       ),
                              //     )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                AnimatedOpacity(
                  opacity: _visible ? 1.0 : 0.0,
                  duration: _visible
                      ? const Duration(milliseconds: 400)
                      : const Duration(milliseconds: 0),
                  onEnd: () async {
                    //async
                    await Future.delayed(const Duration(milliseconds: 200));
                    //FIXME 억지로 엄청 빠르게 카테고리 바꿀다가 상세분석 누르면 에러남  -> 0.3초 딜레이 주니까 1차 해결됨(상황보고 더 이상 문제 없으면 이대로 진행)
                    // 300초로 고쳤는데도 문제 있음 -> 200초로 고침
                    setState(() {
                      _visible = true;
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: showMixedChart(data, time, category,
                        MediaQuery.of(context).size.width * 0.7),
                  ),
                ),
                // TimeClicker(
                //   isSelectedTime: _isSelectedTime,
                //   callbackFunction: callbackFunction,
                // ),
                //AnalysisChartAnalysis(timeRange: getTimeRange(time), unit: "원")
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Future<void> callbackFunction(int newIndex) async {
  //   setState(() {
  //     //_visible = false;
  //     for (int i = 0; i < _isSelectedTime.length; i++) {
  //       if (i == newIndex) {
  //         _isSelectedTime[i] = true;
  //       } else {
  //         _isSelectedTime[i] = false;
  //         switch (newIndex) {
  //           case 0:
  //             //sleep(Duration(milliseconds: 50));
  //             time = Time.day;
  //             break;
  //           case 1:
  //             time = Time.week;
  //             break;
  //           case 2:
  //             time = Time.month;
  //             break;
  //           case 3:
  //             time = Time.year;
  //             break;
  //           case 4:
  //             time = Time.all;
  //             break;
  //           case 5:
  //             break;
  //         }
  //       }
  //       //print(_isSelectedTime);
  //     }
  //     if (newIndex == 5) {
  //       final data = BottomSheetTime().makeShowModalBottomSheet(context);
  //       //print startDate whien Navigor.pop
  //       data.then((value) {
  //         if (value != null) {
  //           print(value["startDate"]);
  //         }
  //       });
  //     } else {
  //       _visible = false;
  //     }
  //   });
  //   await Future.delayed(Duration(milliseconds: 800));
  // }
}
