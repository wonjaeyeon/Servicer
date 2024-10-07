import 'package:servicer/MOD_PACKAGES/fl_chart_svc/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:servicer/design_standards/colors.dart';
import 'package:servicer/design_standards/text_styles.dart';
import '../../../data_handler/mapData_handler/pie_chart/map_sectiondata_converter.dart';
import '../../../data_handler/mapData_handler/mapData_time.dart';
import '../../../data_handler/text/chart_text.dart';
import '../../../design_standards/widget_styles.dart';
import 'bottomsheet.dart';
import 'indicator.dart';
import '../../../data_handler/data_standards/category.dart';
import '../../../data_handler/data_standards/time.dart';

class PieChartContainerFlChart extends StatefulWidget {
  final Map<String, dynamic> profitData;
  final Map<String, dynamic> mallData;
  final Map<String, dynamic> genderData;

  final String title;
  final String unit;
  const PieChartContainerFlChart(
      {Key? key,
      this.profitData = const {},
      this.mallData = const {},
      this.genderData = const {},
      required this.title,
      required this.unit})
      : super(key: key);

  @override
  State<PieChartContainerFlChart> createState() =>
      _PieChartContainerFlChartState();
}

class _PieChartContainerFlChartState extends State<PieChartContainerFlChart> {
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
  late List<Widget> data2;
  final List<bool> _isSelectedTime = [true, false, false, false, false, false];
  final double _chartAnimationDuration = 600;
  bool toggle = false;
  late Time time;
  late Map<String, dynamic> data;
  bool _visible = true;

  @override
  void initState() {
    time = Time.day;
    data = widget.profitData;
    //print(data);
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
            Padding(
              padding: $AnalyticsPageHorizontalPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    widget.title,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: $mediumFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
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
                      maxWidth: 100,
                    ),
                    color: $$Grey,
                    fillColor: Colors.transparent,
                    selectedColor: Colors.white,
                    isSelected: _isSelectedCategory,
                    onPressed: (int newIndex) async {
                      _visible = false;

                      setState(() {
                        for (int i = 0; i < _isSelectedCategory.length; i++) {
                          if (i == newIndex) {
                            _isSelectedCategory[i] = true;
                          } else {
                            _isSelectedCategory[i] = false;
                            switch (newIndex) {
                              case 0:
                                data = widget.profitData;
                                break;
                              case 1:
                                data = widget.mallData;
                                break;
                              case 2:
                                data = widget.genderData;
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
                            //set the background color of the button when it is selected/ not selected
                            color: _isSelectedCategory[3]
                                ? $$mediumGrey
                                : $$lightGrey,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              '시간대',
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
                              '가격대',
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
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Center(
                    child: Transform.scale(
                      scale: 0.6,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: MediaQuery.of(context).size.height * 0.2,
                        margin: const EdgeInsets.all(0), //* 그래프 컨테이너 바깥쪽 간격
                        padding: const EdgeInsets.all(0), //* 그래프 컨테이너 안쪽 간격
                        child: Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: PieChart(
                            PieChartData(
                                sectionsSpace: 0.0,
                                centerSpaceRadius: 60.0,
                                //NOTE: 여기가 데이터가 들어가는 중심지
                                sections: convertDataToPieChartSectionData(
                                    MapDataTimeRange()
                                        .pickTimeRange(data, time, 20220830))),
                            swapAnimationDuration: Duration(milliseconds: 0),
                            //swapAnimationCurve: Curves.easeOutCirc,
                            swapAnimationCurve: Curves.easeOutSine,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      // Text(
                      //   '3건',
                      //   style: TextStyle(
                      //     color: Colors.black,
                      //     fontSize: $mediumFontSize - 4,
                      //   ),
                      // ),
                      //원래 텍스트 들어간 자리
                    ],
                  ),
                ],
              ),
            ),
            Center(
              child: Text(
                ChartText().getTimeRange(
                    MapDataTimeRange().pickTimeRange(data, time, 20220830)),
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: $mediumFontSize - 2,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
            ),
            Center(
              child: Text(
                getTotalSumData(
                    MapDataTimeRange().pickTimeRange(data, time, 20220830),
                    widget.unit),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: $mediumFontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36),
              child: Container(
                  // set minimum height of the container
                  height: 120,
                  alignment: Alignment.center,
                  child: IndicatorsWidget(
                      unit: widget.unit,
                      data: convertDataToPieChartSectionData(MapDataTimeRange()
                          .pickTimeRange(data, time, 20220830)))),
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
                              //time = Time.year;
                              break;
                            case 4:
                              //time = Time.all;
                              break;
                            case 5:
                              //time = Time.custom;
                              break;
                          }
                        }
                        //print(_isSelectedTime);
                      }
                      if (newIndex == 5) {
                        final data =
                            BottomSheetTime().makeShowModalBottomSheet(context);
                        //print startDate whien Navigor.pop
                        data.then((value) {
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
                        child: const Center(child: Icon(Icons.calendar_month))),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// //function that input List<String> and return toggleButtons match to List<String>
// Widget toggleButtons(List<String> list) {
//   List<bool> isSelected = List.generate(list.length, (index) => false);
//   return ToggleButtons(
//       splashColor: Colors.transparent,
//       renderBorder: false,
//       //borderRadius: BorderRadius.circular(15),
//       constraints: const BoxConstraints.expand(
//         height: 25,
//         //make it fit to the text
//         width: 46,
//       ),
//       color: $$Grey,
//       fillColor: Colors.transparent,
//       selectedColor: Colors.black,
//       isSelected: isSelected,
//       onPressed: (int newIndex) {
//         setState(() {
//           for (int i = 0; i < isSelected.length; i++) {
//             if (i == newIndex) {
//               isSelected[i] = true;
//             } else {
//               isSelected[i] = false;
//             }
//             //print(_isSelectedTime);
//           }
//         });
//       },
//       children: List.generate(isSelected.length, (index) => Ink()));
// }

