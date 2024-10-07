import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:servicer/design_standards/colors.dart';
import 'package:servicer/design_standards/text_styles.dart';
import 'Indicator_revenue.dart';

class PieChartContainerRevenue extends StatefulWidget {
  PieChartContainerRevenue({Key? key}) : super(key: key);

  @override
  State<PieChartContainerRevenue> createState() => _PieChartContainerRevenueState();
}

class _PieChartContainerRevenueState extends State<PieChartContainerRevenue> {
  List<bool> _isSelected = [true, false, false, false, false];
  double _chartAnimationDuration = 600;
  bool toggle = false;
  late List<PieChartSectionData> data;

  List<PieChartSectionData> dataOne = [
    PieChartSectionData(
      value: 10,
      title: '네이버 스마트 스토어',
      showTitle: false,
      //titleStyle: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
      titlePositionPercentageOffset: 0.4,
      color: $$mainColor1,
    ),
    PieChartSectionData(
      value: 30,
      title: '지그재그',
      showTitle: false,
      //titleStyle: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
      titlePositionPercentageOffset: 0.1,
      color: $$mainColor3,
    ),
    PieChartSectionData(
      value: 40,
      title: '에이블리',
      showTitle: false,
      //titleStyle: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
      titlePositionPercentageOffset: 0.1,
      color: $$mainColor5,
    ),
    PieChartSectionData(
      value: 70,
      title: '룩핀',
      showTitle: false,
      //titleStyle: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
      titlePositionPercentageOffset: 0.4,
      color: $$mainColor7,
    ),
  ];

  List<PieChartSectionData> dataTwo = [
    PieChartSectionData(
      value: 20,
      title: '네이버 스마트 스토어',
      showTitle: false,
      //titleStyle: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
      titlePositionPercentageOffset: 0.4,
      color: $$mainColor1,
    ),
    PieChartSectionData(
      value: 10,
      title: '지그재그',
      showTitle: false,
      //titleStyle: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
      titlePositionPercentageOffset: 0.1,
      color: $$mainColor3,
    ),
    PieChartSectionData(
      value: 80,
      title: '에이블리',
      showTitle: false,
      //titleStyle: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
      titlePositionPercentageOffset: 0.1,
      color: $$mainColor5,
    ),
    PieChartSectionData(
      value: 160,
      title: '룩핀',
      showTitle: false,
      //titleStyle: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
      titlePositionPercentageOffset: 0.4,
      color: $$mainColor7,
    ),
  ];

  List<PieChartSectionData> dataThree = [
    PieChartSectionData(
      value: 80,
      title: '네이버 스마트 스토어',
      showTitle: false,
      //titleStyle: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
      titlePositionPercentageOffset: 0.4,
      color: $$mainColor1,
    ),
    PieChartSectionData(
      value: 100,
      title: '지그재그',
      showTitle: false,
      //titleStyle: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
      titlePositionPercentageOffset: 0.1,
      color: $$mainColor3,
    ),
    PieChartSectionData(
      value: 20,
      title: '에이블리',
      showTitle: false,
      //titleStyle: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
      titlePositionPercentageOffset: 0.1,
      color: $$mainColor5,
    ),
    PieChartSectionData(
      value: 10,
      title: '룩핀',
      showTitle: false,
      //titleStyle: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
      titlePositionPercentageOffset: 0.4,
      color: $$mainColor7,
    ),
  ];

  @override
  void initState() {
    super.initState();
    data = dataOne;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Center(
          child: ToggleButtons(
            splashColor: Colors.transparent,
            renderBorder: false,
            //borderRadius: BorderRadius.circular(15),
            constraints: const BoxConstraints.expand(
              height: 25,
              width: 46,
            ),
            color: $$Grey,
            fillColor: Colors.transparent,
            selectedColor: Colors.black,
            children: [
              Ink(
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                    //set the background color of the button when it is selected/ not selected
                    color: _isSelected[0] ? $$lightGrey : Colors.transparent,
                    // here is where we set the rounded corner
                    borderRadius: BorderRadius.circular(100),
                    //don't forget to set the border,
                    //otherwise there will be no rounded corner
                    //border: Border.all(color: Colors.red),
                  ),
                  child: Center(child: Text('일'))),
              Ink(
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                    //set the background color of the button when it is selected/ not selected
                    color: _isSelected[1] ? $$lightGrey : Colors.transparent,
                    // here is where we set the rounded corner
                    borderRadius: BorderRadius.circular(100),
                    //don't forget to set the border,
                    //otherwise there will be no rounded corner
                    //border: Border.all(color: Colors.red),
                  ),
                  child: Center(child: Text('월'))),
              Ink(
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                    //set the background color of the button when it is selected/ not selected
                    color: _isSelected[2] ? $$lightGrey : Colors.transparent,
                    // here is where we set the rounded corner
                    borderRadius: BorderRadius.circular(100),
                    //don't forget to set the border,
                    //otherwise there will be no rounded corner
                    //border: Border.all(color: Colors.red),
                  ),
                  child: Center(child: Text('년'))),
              Ink(
                  width: 38,
                  height: 26,
                  decoration: BoxDecoration(
                    //set the background color of the button when it is selected/ not selected
                    color: _isSelected[3] ? $$lightGrey : Colors.transparent,
                    // here is where we set the rounded corner
                    borderRadius: BorderRadius.circular(100),
                    //don't forget to set the border,
                    //otherwise there will be no rounded corner
                    //border: Border.all(color: Colors.red),
                  ),
                  child: Center(child: Text('전체'))),
              Ink(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    //set the background color of the button when it is selected/ not selected
                    color: _isSelected[4] ? $$lightGrey : Colors.transparent,
                    // here is where we set the rounded corner
                    borderRadius: BorderRadius.circular(100),
                    //don't forget to set the border,
                    //otherwise there will be no rounded corner
                    //border: Border.all(color: Colors.red),
                  ),
                  child: Center(child: Icon(Icons.calendar_month))),
            ],
            isSelected: _isSelected,
            onPressed: (int newIndex) {
              setState(() {
                for (int i = 0; i < _isSelected.length; i++) {
                  if (i == newIndex) {
                    _isSelected[i] = true;
                  } else {
                    _isSelected[i] = false;
                    switch (newIndex) {
                      case 0:
                        data = dataOne;
                        break;
                      case 1:
                        data = dataTwo;
                        break;
                      case 2:
                        data = dataThree;
                        break;
                    }
                  }
                  //print(_isSelected);
                }
              });
            },
          ),
        ),
        Stack(
          children: [
            Center(
              child: Transform.scale(
                scale: 0.6,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  height: MediaQuery.of(context).size.height * 0.2,
                  margin: EdgeInsets.all(0), //* 그래프 컨테이너 바깥쪽 간격
                  padding: EdgeInsets.all(0), //* 그래프 컨테이너 안쪽 간격
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: PieChart(
                      PieChartData(sectionsSpace: 0.0, centerSpaceRadius: 60.0, sections: data),
                      swapAnimationDuration: Duration(milliseconds: _chartAnimationDuration.toInt()),
                      swapAnimationCurve: Curves.easeOutCirc,
                    ),
                  ),
                ),
              ),
            ),
            //FIXME 이 부분 핸드폰 화면 뒤집으면 문제 생긴다. 어떻게 할 것인가?
            Center(
                child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.0044 * MediaQuery.of(context).size.height * 0.02,
                ),
                Text(
                  '3건',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: $mediumFontSize - 4,
                  ),
                ),
                Text(
                  '57,170원',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: $mediumFontSize - 8,
                  ),
                ),
              ],
            ))
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 36),
          child: Container(alignment: Alignment.center, child: IndicatorsWidget(data: data)),
        ),
      ],
    );
  }
}
