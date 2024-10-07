import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChartContainer extends StatelessWidget {
  final double size;
  final double scale;
  final String title;
  final Widget chart;

  const ChartContainer({
    Key? key,
    required this.size,
    required this.title,
    required this.scale,
    required this.chart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Container(
          width: size,
          height: size,
          child: Transform.scale(scale: scale, child: chart),
        ),
      ),
    );
  }
}
