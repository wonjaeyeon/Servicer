import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class GenderPieChart extends StatefulWidget {
  GenderPieChart({Key? key}) : super(key: key);

  @override
  State<GenderPieChart> createState() => _GenderPieChartState();
}

class _GenderPieChartState extends State<GenderPieChart> {
  List<double> data = [];
  @override
  void initState() {
    data = [75, 119]; // 남, 여
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    data = [175, 119]; // 디버깅용
    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: EdgeInsets.all(15),
          child: PieChart(
            swapAnimationCurve: Curves.easeOutCirc,
            swapAnimationDuration: Duration(milliseconds: 1500),
            PieChartData(
              startDegreeOffset: 270,
              sectionsSpace: 4,
              centerSpaceRadius: double.infinity,
              sections: showingSections(),
            ),
          ),
        ),
        Stack(
          alignment: Alignment.center,
          children: [
            (data[0] > data[1])
                ? Icon(Icons.man, size: 90, color: Colors.blue.withAlpha(70))
                : Icon(Icons.woman, size: 90, color: Colors.pink.withAlpha(70)),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('남:여'),
                // show ratio
                (data[0] > data[1])
                    ? Text(' ${(data[0] / data[1]).toStringAsFixed(2)}:1')
                    : Text('1: ${(data[1] / data[0]).toStringAsFixed(2)}')
              ],
            ),
          ],
        ),
      ],
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(2, (i) {
      final double fontSize = 15;
      final double radius = 30;
      switch (i) {
        case 1:
          return PieChartSectionData(
            color: Colors.blueAccent,
            value: data[0],
            title: data[0].toInt().toString(),
            radius: radius,
            titleStyle: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.white),
          );
        case 0:
          return PieChartSectionData(
            color: Color.fromARGB(255, 255, 114, 161),
            value: data[1],
            title: data[1].toInt().toString(),
            radius: radius,
            titleStyle: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.white),
          );
        default:
          return null!;
      }
    });
  }
}
