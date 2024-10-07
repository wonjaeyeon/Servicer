import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../../../../../../../MOD_PACKAGES/BH_touchFX/bh_touchfx.dart';
import '../../../../../../../../../../data_handler/data_standards/time.dart';
import '../../../../../../../../../../design_standards/colors.dart';
import '../../../../../../../../../../design_standards/text_styles.dart';
import '../../../../../../../../../../design_standards/widget_styles.dart';
import '../../../../../../../../../../servicer_modules/shopping_mall_master.dart';

///Chart import
import 'package:syncfusion_flutter_charts/charts.dart' hide LabelPlacement;

///Core import
import 'package:syncfusion_flutter_core/core.dart';

///Core theme import
import 'package:syncfusion_flutter_core/theme.dart';

///Slider import
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../../../../../../bottomsheet.dart';
import '../../../../../../abstract_class/abstractChart.dart';

class HundredPercentSubChartContainer extends StatefulWidget {
  final double width;
  final Time time;
  const HundredPercentSubChartContainer(
      {Key? key, required this.time, required this.width})
      : super(key: key);

  @override
  HundredPercentSubChartContainerState createState() =>
      HundredPercentSubChartContainerState();
}

class HundredPercentSubChartContainerState
    extends State<HundredPercentSubChartContainer>
    with SingleTickerProviderStateMixin, FunctionForClass {
  late TooltipBehavior _tooltipBehavior;
  List<bool> _isSelectedTime = [true, false, false, false, false, false];
  // AnimatedOpacity를 위한 변수
  bool _visible = true;

  final num min = 0, max = 100;
  late RangeController rangeController;
  late TextEditingController textController;
  //late List<_ChartData> data;
  late List<int> selectedItems;
  late SfRangeValues _values;
  late ZoomPanBehavior _zoomPanBehavior;
  late Time currentTime;

  @override
  void initState() {
    currentTime = widget.time;
    _values = SfRangeValues(20.0, 50.0);
    //_chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true, color: $$Grey, opacity: 1);

    selectedItems = <int>[];
    textController = TextEditingController(text: '가격범위에 따른 매출');
    rangeController = RangeController(
      start: 20.0,
      end: 50.0,
    );
    _setTotalDataUsage(SfRangeValues(20.0, 50.0));
    _zoomPanBehavior = ZoomPanBehavior(
      // Enables pinch zooming
      enablePinching: true,
      enablePanning: true,
      enableDoubleTapZooming: true,
      enableSelectionZooming: true,
      selectionRectBorderColor: $$Grey,
      selectionRectBorderWidth: 1,
      selectionRectColor: $$Grey.withOpacity(0.2),
    );
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    rangeController.dispose();
    getChartData(widget.time).clear();
    selectedItems.clear();
    //_setTotalDataUsage(_values);
    super.dispose();
  }

  void _setTotalDataUsage(SfRangeValues values) {
    double dataUsage = 0;
    for (int i = 0; i < getChartData(widget.time).length; i++) {
      if (getChartData(widget.time)[i].pricePercent >= values.start &&
          getChartData(widget.time)[i].pricePercent <= values.end)
        dataUsage += getChartData(widget.time)[i].runs;
    }
    textController.text = '해당 가격 범위 매출 : ${getValueUnit(dataUsage)}';
  }

  @override
  Widget build(BuildContext context) {
    selectedItems.clear();
    _setTotalDataUsage(_values);
    final ThemeData themeData = Theme.of(context);
    //final MediaQueryData mediaQueryData = MediaQuery.of(context);
    for (int i = 0; i < getChartData(widget.time).length; i++) {
      if (getChartData(widget.time)[i].pricePercent >= rangeController.start &&
          getChartData(widget.time)[i].pricePercent <= rangeController.end) {
        //selectedItems.add(getChartData(time).indexOf(getChartData(time)[i]));
        selectedItems.add(i);
      }
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.only(right: 50),
              child: Text("매출액"),
            )),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
          child: Center(
            child: SfRangeSelectorTheme(
              data: SfRangeSelectorThemeData(
                  brightness: themeData.colorScheme.brightness,
                  //labelOffset: const Offset(0, 2),
                  thumbColor: Colors.white,
                  overlayColor: Colors.green.withOpacity(0.12),
                  activeTrackColor: Colors.green,
                  thumbStrokeColor: Colors.green,
                  thumbStrokeWidth: 2.0,
                  inactiveTrackColor: const Color.fromRGBO(194, 194, 194, 1),
                  activeTrackHeight: 10.0,
                  //tickOffset: Offset(0, -4),

                  //inactiveTrackHeight: 10.0,

                  //inactiveTickColor: const Color.fromRGBO(194, 194, 194, 1),
                  // activeLabelStyle: TextStyle(
                  //     fontSize: 12,
                  //     color: themeData.textTheme.bodyLarge!.color!
                  //         .withOpacity(0.87)),
                  // inactiveLabelStyle: TextStyle(
                  //     fontSize: 12,
                  //     color: themeData.textTheme.bodyLarge!.color!
                  //         .withOpacity(0.87)),
                  inactiveRegionColor: Colors.transparent),
              child: SfRangeSelector(
                enableTooltip: true,
                min: min,
                max: max,
                labelFormatterCallback: (actualValue, formattedText) {
                  return formattedText + '%';
                },
                interval: 20,
                controller: rangeController,
                stepSize: 5,
                showTicks: true,
                showLabels: true,
                onChanged: (SfRangeValues values) {
                  _values = values;
                  _setTotalDataUsage(values);
                },
                trackShape: const SfTrackShape(),
                child: SfCartesianChart(
                  zoomPanBehavior: _zoomPanBehavior,
                  //title: ChartTitle(text: 'Data Usage For April 2019'),
                  margin: const EdgeInsets.symmetric(
                      //horizontal: mediaQueryData.size.width * 0.05,
                      vertical: 10),
                  primaryXAxis: NumericAxis(
                    plotOffset: 0,
                    title: AxisTitle(
                        text: '연령 백분위', alignment: ChartAlignment.near),
                    minimum: 0,
                    maximum: 100,
                    labelFormat: '{value}%',
                    isVisible: true,
                    enableAutoIntervalOnZooming: true,
                    labelStyle: const TextStyle(fontFamily: 'IBMPlexSansKR'),
                  ),
                  primaryYAxis: NumericAxis(
                    isVisible: true,
                    // labelPosition: ChartDataLabelPosition.inside,
                    // tickPosition: TickPosition.inside,
                    opposedPosition: true,
                    numberFormat: NumberFormat.currency(
                      locale: 'ko_KR', symbol: '', decimalDigits: 0,
                      //make a custom numberformat
                    ),
                    labelFormat: '{value}원',
                    axisLabelFormatter: (axisLabelRenderArgs) => ChartAxisLabel(
                        getValueUnit(axisLabelRenderArgs.value.toDouble()),
                        TextStyle(
                          fontFamily: 'IBMPlexSansKR',
                          fontSize: $smallFontSize,
                        )),
                    //maximum: 26,
                    labelStyle: const TextStyle(fontFamily: 'IBMPlexSansKR'),
                  ),

                  plotAreaBorderWidth: 0,
                  plotAreaBackgroundColor: Colors.transparent,
                  series: <CartesianSeries<_ChartData, num>>[
                    ColumnSeries<_ChartData, num>(
                        width: 0.8,
                        initialSelectedDataIndexes: selectedItems,
                        selectionBehavior: SelectionBehavior(
                            enable: true,
                            unselectedOpacity: 0,
                            // selectedBorderColor:
                            //     const Color.fromRGBO(0, 178, 206, 1),
                            // selectedColor: const Color.fromRGBO(0, 178, 206, 1),
                            unselectedColor: Colors.transparent,
                            selectionController: rangeController),
                        // dashArray:
                        //     model.isWebFullView ? null : <double>[3, 2],
                        color: const Color.fromRGBO(255, 255, 255, 0),
                        borderColor: const Color.fromRGBO(194, 194, 194, 1),
                        animationDuration: 0,
                        borderWidth: 1,
                        dataSource: getChartData(widget.time),
                        xValueMapper: (_ChartData score, _) =>
                            score.pricePercent,
                        yValueMapper: (_ChartData score, _) => score.runs,
                        pointColorMapper: (_ChartData score, _) =>
                            score.pointColor)
                  ],
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 0),
          // padding: mediaQueryData.orientation == Orientation.landscape ||
          //         model.isWebFullView
          //     ? EdgeInsets.only(bottom: mediaQueryData.size.height * 0.025)
          //     : EdgeInsets.only(bottom: mediaQueryData.size.height * 0.1),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 20,
              child: TextField(
                controller: textController,
                enabled: false,
                readOnly: true,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(border: InputBorder.none),
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<_ChartData> getChartData(Time time) {
    List<_ChartData> chartData = [];
    if (time == Time.day) {
      chartData = <_ChartData>[
        _ChartData(5, 4000, Colors.green[100]),
        _ChartData(10, 6000, Colors.green[200]),
        _ChartData(15, 18000, Colors.green[200]),
        _ChartData(20, 19000, Colors.green[300]),
        _ChartData(25, 18000, Colors.green[300]),
        _ChartData(30, 16000, Colors.green[400]),
        _ChartData(35, 14500, Colors.green[400]),
        _ChartData(40, 20000, Colors.green[500]),
        _ChartData(45, 40000, Colors.green[500]),
        _ChartData(50, 20000, Colors.green[600]),
        _ChartData(55, 30000, Colors.green[600]),
        _ChartData(60, 10000, Colors.green[700]),
        _ChartData(65, 40000, Colors.green[700]),
        _ChartData(70, 30000, Colors.green[800]),
        _ChartData(75, 20000, Colors.green[800]),
        _ChartData(80, 20000, Colors.green[800]),
        _ChartData(85, 8000, Colors.green[800]),
        _ChartData(90, 6000, Colors.green[900]),
        _ChartData(95, 2000, Colors.green[900]),
        _ChartData(100, 1000, Colors.green[900]),
      ];
    } else if (time == Time.week) {
      chartData = <_ChartData>[
        _ChartData(5, 4000 * 7, Colors.green[100]),
        _ChartData(10, 6000 * 7, Colors.green[200]),
        _ChartData(15, 8000 * 7, Colors.green[200]),
        _ChartData(20, 10000 * 7, Colors.green[300]),
        _ChartData(25, 8000 * 7, Colors.green[300]),
        _ChartData(30, 6000 * 7, Colors.green[400]),
        _ChartData(35, 4500 * 7, Colors.green[400]),
        _ChartData(40, 20000 * 6, Colors.green[500]),
        _ChartData(45, 40000 * 6, Colors.green[500]),
        _ChartData(50, 60000 * 6, Colors.green[600]),
        _ChartData(55, 80000 * 6, Colors.green[600]),
        _ChartData(60, 10000 * 6, Colors.green[700]),
        _ChartData(65, 80000 * 6, Colors.green[700]),
        _ChartData(70, 60000 * 6, Colors.green[800]),
        _ChartData(75, 40000 * 6, Colors.green[800]),
        _ChartData(80, 200 * 5, Colors.green[900]),
        _ChartData(85, 4000 * 5, Colors.green[900]),
        _ChartData(90, 6000 * 5, Colors.green[900]),
        _ChartData(95, 8000 * 5, Colors.green[900]),
        _ChartData(100, 10000 * 5, Colors.green[900]),
      ];
    } else if (time == Time.month) {
      chartData = <_ChartData>[
        _ChartData(5, 4000 * 6 * 4, Colors.green[100]),
        _ChartData(10, 6000 * 7 * 4, Colors.green[200]),
        _ChartData(15, 8000 * 7 * 4, Colors.green[200]),
        _ChartData(20, 10000 * 7 * 4, Colors.green[300]),
        _ChartData(25, 80000 * 6 * 4, Colors.green[300]),
        _ChartData(30, 6000 * 7 * 4, Colors.green[400]),
        _ChartData(35, 4500 * 7 * 4, Colors.green[400]),
        _ChartData(40, 20000 * 6 * 4, Colors.green[500]),
        _ChartData(45, 40000 * 7 * 4, Colors.green[500]),
        _ChartData(50, 60000 * 6 * 4, Colors.green[600]),
        _ChartData(55, 80000 * 6 * 4, Colors.green[600]),
        _ChartData(60, 10000 * 8 * 4, Colors.green[700]),
        _ChartData(65, 80000 * 8 * 4, Colors.green[700]),
        _ChartData(70, 60000 * 6 * 4, Colors.green[800]),
        _ChartData(75, 40000 * 6 * 4, Colors.green[800]),
        _ChartData(80, 2000 * 5 * 4, Colors.green[900]),
        _ChartData(85, 4000 * 5 * 4, Colors.green[900]),
        _ChartData(90, 6000 * 5 * 4, Colors.green[900]),
        _ChartData(95, 8000 * 5 * 4, Colors.green[900]),
        _ChartData(100, 10000 * 5 * 4, Colors.green[900]),
      ];
    } else if (time == Time.year) {
      chartData = <_ChartData>[
        _ChartData(5, 4000 * 6 * 4 * 10, Colors.green[100]),
        _ChartData(10, 6000 * 7 * 4 * 10, Colors.green[200]),
        _ChartData(15, 8000 * 7 * 4 * 12, Colors.green[200]),
        _ChartData(20, 10000 * 7 * 4 * 11, Colors.green[300]),
        _ChartData(25, 80000 * 6 * 4 * 11, Colors.green[300]),
        _ChartData(30, 6000 * 7 * 4 * 11, Colors.green[400]),
        _ChartData(35, 4500 * 7 * 4 * 12, Colors.green[400]),
        _ChartData(40, 20000 * 6 * 4 * 12, Colors.green[500]),
        _ChartData(45, 40000 * 7 * 4 * 12, Colors.green[500]),
        _ChartData(50, 60000 * 6 * 4 * 12, Colors.green[600]),
        _ChartData(55, 80000 * 6 * 4 * 12, Colors.green[600]),
        _ChartData(60, 10000 * 8 * 4 * 12, Colors.green[700]),
        _ChartData(65, 80000 * 8 * 4 * 11, Colors.green[700]),
        _ChartData(70, 60000 * 6 * 4 * 11, Colors.green[800]),
        _ChartData(75, 40000 * 6 * 4 * 11, Colors.green[800]),
        _ChartData(80, 2000 * 5 * 4 * 10, Colors.green[900]),
        _ChartData(85, 4000 * 5 * 4 * 10, Colors.green[900]),
        _ChartData(90, 6000 * 5 * 4 * 10, Colors.green[900]),
        _ChartData(95, 8000 * 5 * 4 * 10, Colors.green[900]),
        _ChartData(100, 10000 * 5 * 4 * 10, Colors.green[900]),
      ];
    } else if (time == Time.all) {
      chartData = <_ChartData>[
        _ChartData(5, 4000 * 6 * 4 * 10 * 2, Colors.green[100]),
        _ChartData(10, 6000 * 7 * 4 * 11 * 2, Colors.green[200]),
        _ChartData(15, 8000 * 7 * 4 * 12 * 2, Colors.green[200]),
        _ChartData(20, 10000 * 7 * 4 * 10 * 2, Colors.green[300]),
        _ChartData(25, 80000 * 6 * 4 * 10 * 2, Colors.green[300]),
        _ChartData(30, 6000 * 7 * 4 * 11 * 2, Colors.green[400]),
        _ChartData(35, 4500 * 7 * 4 * 12 * 2, Colors.green[400]),
        _ChartData(40, 20000 * 6 * 4 * 10 * 2, Colors.green[500]),
        _ChartData(45, 40000 * 7 * 4 * 12 * 2, Colors.green[500]),
        _ChartData(50, 60000 * 6 * 4 * 10 * 2, Colors.green[600]),
        _ChartData(55, 80000 * 6 * 4 * 12 * 2, Colors.green[600]),
        _ChartData(60, 10000 * 8 * 4 * 10 * 2, Colors.green[700]),
        _ChartData(65, 80000 * 8 * 4 * 10 * 2, Colors.green[700]),
        _ChartData(70, 60000 * 6 * 4 * 10 * 2, Colors.green[800]),
        _ChartData(75, 40000 * 6 * 4 * 9 * 2, Colors.green[800]),
        _ChartData(80, 2000 * 5 * 4 * 10 * 2, Colors.green[900]),
        _ChartData(85, 4000 * 5 * 4 * 12 * 2, Colors.green[900]),
        _ChartData(90, 6000 * 5 * 4 * 10 * 2, Colors.green[900]),
        _ChartData(95, 8000 * 5 * 4 * 10 * 2, Colors.green[900]),
        _ChartData(100, 10000 * 5 * 4 * 10 * 2, Colors.green[900]),
      ];
    } else {
      chartData = <_ChartData>[];
    }

    return chartData;
  }
}

class _ChartData {
  _ChartData(this.pricePercent, this.runs, this.pointColor);
  final num pricePercent;
  final num runs;
  final Color? pointColor;
}
