import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:servicer/design_standards/colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../servicer_modules/get_shoppingmall_theme.dart';

/// 신규 버전 메인 페이지의 위젯형 차트 중 첫 번째임.
/// 주문수와 반품률을 X와 Y축으로 하는 차트로 나타낸다.

class XYChart extends StatefulWidget {
  XYChart({Key? key}) : super(key: key);

  @override
  State<XYChart> createState() => _XYChartState();
}

class _XYChartState extends State<XYChart> {
  List datas = [];
  double rad = 0;
  List<int> indexToShowTooltips = [];
  String tooltipName = '';
  List<ScatterSpot> convertToScatterSeriesData(List datas) {
    List<ScatterSpot> series = [];
    int index = 0;
    for (var data in datas) {
      series.add(
        ScatterSpot(
          data[1].toDouble(), data[2].toDouble(),
          // black color when selected

          color: (indexToShowTooltips.length == 0)
              // ? getColorFromShoppingMall(data[0])
              ? color_theme[index]
              : indexToShowTooltips.contains(datas.indexOf(data))
                  // ? getColorFromShoppingMall(data[0])
                  ? color_theme[index]
                  // : getColorFromShoppingMall(data[0]).withAlpha(100),
                  : color_theme[index].withAlpha(100),
          radius: (indexToShowTooltips.length == 0)
              ? rad
              : indexToShowTooltips.contains(datas.indexOf(data))
                  ? 7
                  : rad,
        ),
      );
      index++;
    }
    //print(series);
    return series;
  }

  List<Color> color_theme = [
    Color(0xff03045E),
    Color(0xff2b325a),
    Color(0xff536056),
    Color(0xff7b8e52),
    Color(0xffa2bc4e),
    Color(0xffb9d827),
    Color(0xffd0f400),
  ];

  @override
  void initState() {
    datas = [
      [ShoppingMall.coupang, 99, 15],
      [ShoppingMall.naverSmartStore, 67, 7],
      [ShoppingMall.elevenStreet, 25, 3],
      [ShoppingMall.gMarket, 26, 2],
      [ShoppingMall.lookpin, 9, 1],
    ];
    animate();
    super.initState();
  }

  void animate() async {
    await Future.delayed(const Duration(milliseconds: 150));
    setState(() {
      rad = 5;
      convertToScatterSeriesData(datas);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              '주문 / 반품',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ),
          SizedBox(height: 10),
          AspectRatio(
            aspectRatio: 1,
            child: Stack(
              children: [
                const Axis(),
                ScatterChart(
                  swapAnimationCurve: Curves.easeOutCirc,
                  swapAnimationDuration: const Duration(milliseconds: 3000),
                  ScatterChartData(
                    scatterLabelSettings: ScatterLabelSettings(
                      getLabelTextStyleFunction: (spotIndex, spot) => TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                    // set maxX to the maximum value of datas list
                    maxX: datas.map((e) => e[1]).reduce((a, b) => a > b ? a : b).toDouble() * 1.1,
                    // set maxY to the maximum value of datas list
                    maxY: datas.map((e) => e[2]).reduce((a, b) => a > b ? a : b).toDouble() * 1.1,
                    // set minX to the minimum value of datas list
                    minX: datas.map((e) => e[1]).reduce((a, b) => a < b ? a : b).toDouble() -
                        datas.map((e) => e[1]).reduce((a, b) => a > b ? a : b).toDouble() * 0.1,
                    // set minY to the minimum value of datas list
                    minY: datas.map((e) => e[2]).reduce((a, b) => a < b ? a : b).toDouble() -
                        datas.map((e) => e[2]).reduce((a, b) => a > b ? a : b).toDouble() * 0.1,
                    backgroundColor: Colors.transparent,
                    scatterSpots: convertToScatterSeriesData(datas),
                    gridData: FlGridData(
                      show: false,
                    ),
                    // remove labels in x and y axis
                    borderData: FlBorderData(show: false),
                    titlesData: FlTitlesData(show: false),
                    // show value while tapping
                    showingTooltipIndicators: indexToShowTooltips,
                    scatterTouchData: ScatterTouchData(
                      enabled: true,
                      handleBuiltInTouches: false,
                      mouseCursorResolver: (FlTouchEvent touchEvent, ScatterTouchResponse? response) {
                        return response == null || response.touchedSpot == null ? MouseCursor.defer : SystemMouseCursors.click;
                      },
                      touchSpotThreshold: 15,
                      touchCallback: (FlTouchEvent event, ScatterTouchResponse? response) {
                        if (response == null) {
                        } else if (response.touchedSpot == null) {
                          setState(() {
                            indexToShowTooltips.clear();

                            convertToScatterSeriesData(datas);
                          });
                          return;
                        } else if (event is FlTapDownEvent) {
                          setState(() {
                            indexToShowTooltips = [response.touchedSpot!.spotIndex];
                            tooltipName = getNameFromShoppingMall(datas[response.touchedSpot!.spotIndex][0]);
                            convertToScatterSeriesData(datas);
                          });
                        }
                      },
                      touchTooltipData: ScatterTouchTooltipData(
                        tooltipBgColor: Colors.grey.withOpacity(0.25),
                        tooltipPadding: const EdgeInsets.all(8),
                        fitInsideHorizontally: true,
                        //fitInsideVertically: true,
                        tooltipRoundedRadius: 8,
                        getTooltipItems: (ScatterSpot touchedSpots) {
                          return ScatterTooltipItem(
                            '',
                            children: [
                              TextSpan(text: tooltipName),
                              TextSpan(text: '\n주문: ${touchedSpots.x.toInt()}건'),
                              TextSpan(text: '\n반품: ${touchedSpots.y.toInt()}건'),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          // make legends
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              legend(ShoppingMall.coupang, color_theme[0]),
              legend(ShoppingMall.naverSmartStore, color_theme[1]),
              legend(ShoppingMall.elevenStreet, color_theme[2]),
              legend(ShoppingMall.gMarket, color_theme[3]),
              legend(ShoppingMall.lookpin, color_theme[4]),
            ],
          ),
        ],
      ),
    );
  }

  legend(ShoppingMall s, [Color? col]) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: col ?? getColorFromShoppingMall(s),
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 5),
        Text(getNameFromShoppingMall(s)),
      ],
    );
  }
}

class Axis extends StatelessWidget {
  const Axis({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Flexible(
              child: Container(
                child: Row(
                  children: [
                    Flexible(
                      // 1 사분면
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.05),
                        ),
                      ),
                    ),
                    Container(color: Colors.black, width: 0.5),
                    // 2 사분면
                    Flexible(
                      child: Container(
                        color: Colors.white.withOpacity(0.07),
                        padding: EdgeInsets.all(5),
                        child: Text('반품 (건)'),
                        alignment: Alignment.topLeft,
                      ),
                    ),
                  ],
                ),
              ),
              flex: 1),
          Container(color: Colors.black, height: 0.5),
          Flexible(
              child: Container(
                child: Row(
                  children: [
                    // 4 사분면
                    Flexible(
                      child: Container(
                        color: Colors.white.withOpacity(0.07),
                      ),
                    ),
                    Container(color: Colors.black, width: 0.5),
                    // 3 사분면
                    Flexible(
                      child: Container(
                        padding: EdgeInsets.all(5),
                        color: Colors.grey.withOpacity(0.05),
                        child: Text('주문 (건)'),
                        alignment: Alignment.topRight,
                      ),
                    ),
                  ],
                ),
              ),
              flex: 1),
        ],
      ),
    );
  }
}
