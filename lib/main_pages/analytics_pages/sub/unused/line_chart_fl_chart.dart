import 'package:flutter/material.dart';
import '../../../../MOD_PACKAGES/fl_chart_svc/fl_chart.dart';
import '../../../../design_standards/colors.dart';
import '../../../../design_standards/text_styles.dart';
import '../../../../design_standards/widget_styles.dart';
import '../bottomsheet.dart';
import '../../../../data_handler/mapData_handler/line_chart/list_data_handler/list_data_converter.dart';
import '../../../../data_handler/mapData_handler/line_chart/list_data_handler/list_time.dart';
import '../../../../data_handler/mapData_handler/line_chart/axis_converter.dart';
import '../../../../data_handler/text/chart_text.dart';
import '../../../../data_handler/data_standards/time.dart';

class LineChartContainerFLChart extends StatefulWidget {
  final List<FlSpot> flSpotDataByDate;
  final Map<String, dynamic> mapDataByTime;

  final String title;
  final String unit;
  const LineChartContainerFLChart(
      {Key? key,
      required this.title,
      required this.flSpotDataByDate,
      required this.mapDataByTime,
      required this.unit})
      : super(key: key);

  @override
  State<LineChartContainerFLChart> createState() =>
      _LineChartContainerFLChartState();
}

class _LineChartContainerFLChartState extends State<LineChartContainerFLChart>
    with TickerProviderStateMixin {
  @override
  void initState() {
    time = Time.day;
    // print(mapToFlSpotConverter2(MapDataTimeRange()
    //     .pickDateRange(widget.mapDataByTime, 20220830, 20220830)));
    super.initState();
  }

  final List<bool> _isSelectedTime = [true, false, false, false, false, false];
  final double _chartAnimationDuration = 4000;

  late Time time;
  late int currentIndex;
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
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: $AnalyticsPageHorizontalPadding,
                  child: SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 12,
                        ),
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
                        Text(
                          ChartText().timeRange(pickTimeRange(
                              widget.flSpotDataByDate, time, 20220830)),
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: $mediumFontSize - 2),
                        ),
                        Text(
                          ChartText().sum(
                              pickTimeRange(
                                  widget.flSpotDataByDate, time, 20220830),
                              widget.unit),
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: $mediumFontSize - 2),
                        ),
                        Text(
                          ChartText().gradientText(pickTimeRange(
                              widget.flSpotDataByDate, time, 20220830)),
                          style: TextStyle(fontSize: $mediumFontSize - 2),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 70,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 200,
              margin:
                  const EdgeInsets.fromLTRB(30, 10, 10, 10), //* 그래프 컨테이너 바깥쪽 간격
              padding: const EdgeInsets.all(4), //* 그래프 컨테이너 안쪽 간격

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
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: LineChart(
                    //! ANCHOR 그래프 몸통 부분
                    LineChartData(
                        minY: 0,
                        maxY: 500000,
                        maxX: ConvertAxis().convertXAxis(time),
                        borderData: FlBorderData(
                            border: const Border(
                          bottom: BorderSide(
                              color: Color.fromARGB(255, 163, 163, 163),
                              width: 1),
                        )),
                        gridData: FlGridData(
                          getDrawingHorizontalLine: (double value) => FlLine(
                              color: Color.fromARGB(255, 207, 207, 207),
                              strokeWidth: 1),
                          getDrawingVerticalLine: (double value) => FlLine(
                              color: Colors.transparent, strokeWidth: 0.5),
                        ),
                        titlesData: FlTitlesData(
                          show: true,
                          topTitles: AxisTitles(
                              // axisNameWidget: Text('그래프',
                              //     style:
                              //         TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                              // axisNameSize: 50,
                              ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 20,
                              interval: 10,
                              getTitlesWidget: (double value, TitleMeta meta) {
                                return Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Text(
                                    '${(value.toInt()).toInt().toString()}일',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 10),
                                  ),
                                );
                              },
                            ),
                          ),
                          leftTitles: AxisTitles(),
                          rightTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              interval: 100000,
                              reservedSize: 36,
                              getTitlesWidget: (double value, TitleMeta meta) {
                                if (value == 0) {
                                  return const SizedBox();
                                }
                                return Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Text(
                                    '${(value.toInt() / 10000).toInt().toString()}만원',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 10),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        clipData: FlClipData.none(),
                        backgroundColor: Colors.transparent,
                        lineBarsData: [
                          dataForLine(widget.flSpotDataByDate, time),
                        ],
                        // borderData: FlBorderData(
                        //   border: Border.all(
                        //     color: Colors.green,
                        //     style: BorderStyle.solid,
                        //     width: 0,
                        //   ),
                        // ),
                        // extraLinesData: ExtraLinesData(horizontalLines: [
                        //   HorizontalLine(
                        //     y: 12000,
                        //     color: $$Grey,
                        //     strokeWidth: 1,
                        //     dashArray: [20, 2],
                        //   ),
                        // ]),
                        lineTouchData: LineTouchData(
                          getTouchedSpotIndicator: (LineChartBarData barData,
                              List<int> spotIndexes) {
                            return spotIndexes.map((spotIndex) {
                              //final spot = barData.spots[spotIndex];

                              return TouchedSpotIndicatorData(
                                FlLine(color: $$Grey, strokeWidth: 0.9),
                                FlDotData(
                                  getDotPainter:
                                      (spot, percent, barData, index) {
                                    return FlDotCirclePainter(
                                        radius: 0.2,
                                        color: Colors.indigo,
                                        strokeWidth: 5,
                                        strokeColor: Colors.indigo);
                                  },
                                ),
                              );
                            }).toList();
                          },
                          touchTooltipData: LineTouchTooltipData(
                              tooltipBgColor: Colors.grey.withOpacity(0.25),
                              getTooltipItems:
                                  (List<LineBarSpot> touchedBarSpots) {
                                return touchedBarSpots.map((barSpot) {
                                  final flSpot = barSpot;

                                  TextAlign textAlign;
                                  switch (flSpot.x.toInt()) {
                                    case 0:
                                      textAlign = TextAlign.left;
                                      break;

                                    default:
                                      textAlign = TextAlign.center;
                                  }

                                  return LineTooltipItem(
                                    '',
                                    const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: ChartText().getSpotDate(
                                            pickTimeRange(
                                                widget.flSpotDataByDate,
                                                time,
                                                20220830),
                                            flSpot.x),
                                        style: TextStyle(
                                          color: $$Grey,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '\n',
                                        style: TextStyle(
                                          color: $$Grey,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      TextSpan(
                                        text: (flSpot.y).toInt().toString(),
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      TextSpan(
                                        text: widget.unit,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      // TextSpan(
                                      //   text: (flSpot.y / 100).toInt().toString(),
                                      //   style: TextStyle(
                                      //     color: $$Grey,
                                      //     fontWeight: FontWeight.normal,
                                      //   ),
                                      // ),
                                      // TextSpan(
                                      //   text: ' 건 ',
                                      //   style: TextStyle(
                                      //     //fontStyle: FontStyle.italic,
                                      //     color: $$Grey,
                                      //     fontWeight: FontWeight.normal,
                                      //   ),
                                      // ),
                                    ],
                                    textAlign: textAlign,
                                  );
                                }).toList();
                              }),
                        )),
                    //make no animation just duration
                    swapAnimationDuration: Duration(milliseconds: 700),
                    // //make swapAnimation fade in and out
                    //swapAnimationCurve: Curves.easeOutSine,
                    swapAnimationCurve: Curves.easeOutCirc,
                  ),
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
                              time = Time.day;
                              break;
                            case 1:
                              time = Time.week;
                              break;
                            case 2:
                              time = Time.month;
                              break;
                            case 3:
                              time = Time.threeMonth;
                              break;
                            case 4:
                              break;
                            case 5:
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
            // Visibility(
            //   visible: listVisible,
            //   child: Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: Container(height: 400, width: 400, child: Calendar()),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

//Function inputs List<FlSpot> and Time
//Returns LineChartBarData
LineChartBarData dataForLine(List<FlSpot> data, Time time) {
  return LineChartBarData(
    curveSmoothness: 0.0,
    preventCurveOverShooting: true,
    dotData: FlDotData(show: false),
    spots: convertToNumber(pickTimeRange(data, time, 20220830)),
    isCurved: true,
    color: Colors.indigo,
    barWidth: 3,
    isStrokeCapRound: true,
    belowBarData: BarAreaData(color: Colors.transparent, show: false),
  );
}
