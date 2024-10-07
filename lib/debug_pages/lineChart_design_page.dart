import 'package:flutter/material.dart';
import 'package:servicer/MOD_PACKAGES/fl_chart_svc/fl_chart.dart';
import 'package:flutter/services.dart';

class LineChartDesignPage extends StatefulWidget {
  LineChartDesignPage({Key? key}) : super(key: key);

  @override
  State<LineChartDesignPage> createState() => _LineChartDesignPageState();
}

class _LineChartDesignPageState extends State<LineChartDesignPage> {
  double _chartAnimationDuration = 400;
  bool toggle = false;
  late LineChartBarData data;
  LineChartBarData dataOne = LineChartBarData(
    isCurved: true,
    curveSmoothness: 0.0,
    preventCurveOverShooting: true,
    belowBarData: BarAreaData(color: Color.fromARGB(0, 96, 125, 139), show: true),
    dotData: FlDotData(show: false),
    color: Colors.black,
    barWidth: 3,
    isStrokeCapRound: true,
    spots: [
      FlSpot(1, 40000),
      FlSpot(2, 10000),
      FlSpot(3, 20000),
      FlSpot(4, 30000),
      FlSpot(5, -20000),
      FlSpot(6, 10000),
      FlSpot(7, 12000),
      FlSpot(8, 26000),
      FlSpot(9, 12000),
      FlSpot(10, 26000),
      FlSpot(11, 40000),
      FlSpot(12, 10000),
      FlSpot(13, 20000),
      FlSpot(14, 30000),
      FlSpot(15, -20000),
      FlSpot(16, 10000),
      FlSpot(17, 12000),
      FlSpot(18, 26000),
      FlSpot(19, 12000),
      FlSpot(20, 26000),
      FlSpot(21, 40000),
      FlSpot(22, 10000),
      FlSpot(23, 20000),
      FlSpot(24, 30000),
      FlSpot(25, -20000),
      FlSpot(26, 10000),
      FlSpot(27, 12000),
      FlSpot(28, 26000),
      FlSpot(29, 12000),
      FlSpot(30, 26000),
    ],
  );

  LineChartBarData dataTwo = LineChartBarData(
    isCurved: true,
    curveSmoothness: 0.0,
    preventCurveOverShooting: true,
    dotData: FlDotData(show: false),
    color: Colors.black,
    barWidth: 3,
    isStrokeCapRound: true,
    belowBarData: BarAreaData(color: Color.fromARGB(0, 96, 125, 139), show: true),
    spots: [
      FlSpot(5, -20000),
      FlSpot(6, 10000),
      FlSpot(7, 12000),
      FlSpot(8, 26000),
      FlSpot(9, 12000),
      FlSpot(10, 26000),
    ],
  );
  @override
  void initState() {
    super.initState();
    data = dataOne;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.4,
              margin: EdgeInsets.all(16), //* 그래프 컨테이너 바깥쪽 간격
              padding: EdgeInsets.all(4), //* 그래프 컨테이너 안쪽 간격
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.white, Colors.white],
                  begin: Alignment.topLeft,
                  end: Alignment(0.8, 1),
                  tileMode: TileMode.mirror,
                ),
                borderRadius: BorderRadius.all(Radius.circular(32)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: LineChart(
                  //! ANCHOR 그래프 몸통 부분
                  LineChartData(
                    gridData: FlGridData(
                      getDrawingHorizontalLine: (double value) => FlLine(color: Color.fromARGB(45, 0, 0, 0), strokeWidth: 1),
                      getDrawingVerticalLine: (double value) => FlLine(color: Color.fromARGB(45, 0, 0, 0), strokeWidth: 0.5),
                    ),
                    titlesData: FlTitlesData(
                      show: true,
                      topTitles: AxisTitles(
                        axisNameWidget: Text('그래프', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        axisNameSize: 50,
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 30,
                          interval: 5,
                        ),
                      ),
                      rightTitles: AxisTitles(),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: 10000,
                          reservedSize: 50,
                          getTitlesWidget: (double value, TitleMeta meta) {
                            return Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                '${(value.toInt() / 10000).toInt().toString()}만원',
                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 10),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    clipData: FlClipData.none(),
                    backgroundColor: Colors.transparent,
                    lineBarsData: [
                      data,
                    ],
                    borderData: FlBorderData(
                      border: Border.all(
                        color: Colors.green,
                        style: BorderStyle.solid,
                        width: 0,
                      ),
                    ),
                  ),
                  swapAnimationDuration: Duration(milliseconds: _chartAnimationDuration.toInt()),
                  swapAnimationCurve: Curves.easeOutCirc,
                ),
              ),
            ),
            ElevatedButton(
              child: Text('change data'),
              onPressed: () {
                toggle = !toggle;
                print(toggle);
                setState(() {
                  data = (toggle) ? dataTwo : dataOne;
                });
              },
            ),
            Container(
              color: Colors.black12,
              child: Column(
                children: [
                  Text('애니메이션 시간: $_chartAnimationDuration ms'),
                  Slider(
                    value: _chartAnimationDuration,
                    min: 0,
                    max: 4000,
                    divisions: (4000 / 50).toInt(), //*NOTE max에서 간격을 나눠야 제대로 작동함.
                    onChanged: (value) {
                      HapticFeedback.lightImpact();
                      setState(() {
                        _chartAnimationDuration = value;
                      });
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
