import 'package:flutter/material.dart';
import 'package:servicer/d_widget_maker/abstract_class/abstractchart.dart';

import '../../data_handler/data_standards/time.dart';

class ImplementChart extends AbstractChart {
  ImplementChart({Key? key, required Time time, required double width})
      : super(key: key, time: time, width: width);

  @override
  State<ImplementChart> createState() => _ImplementChartState();
}

class _ImplementChartState extends State<ImplementChart> with FunctionForClass {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(getTimeRange(widget.time)),
    );
  }
}
