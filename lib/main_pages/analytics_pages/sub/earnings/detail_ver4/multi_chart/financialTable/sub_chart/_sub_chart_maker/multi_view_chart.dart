import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:servicer/main_pages/analytics_pages/sub/earnings/composition/multi_chart/gender/g_data_handler/y_axis_unit.dart';

import '../../../../../../../../../../data_handler/data_standards/category.dart';
import '../../../../../../../../../../data_handler/data_standards/time.dart';
import '../../../../../../../../../../design_standards/colors.dart';
import '../../../../../../../../../../design_standards/text_styles.dart';
import '../../../../../../../../../../design_standards/widget_styles.dart';
import 'view_chart_selector.dart';

class FinancialTableSubChartViewChart extends StatefulWidget {
  final Time time;
  final String subViewType;
  const FinancialTableSubChartViewChart(
      {Key? key, required this.time, required this.subViewType})
      : super(key: key);

  @override
  State<FinancialTableSubChartViewChart> createState() =>
      _FinancialTableSubChartViewChartState();
}

class _FinancialTableSubChartViewChartState
    extends State<FinancialTableSubChartViewChart>
    with ViewChartSelector, GChartYAxisUnit {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double _verticalPadding = 15;
    final double _horizontalPadding = 15;
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Container(
          alignment: Alignment.center,
          child: showMultiViewChart(widget.subViewType,
              MediaQuery.of(context).size.width * 0.9, widget.time),
        ),
      ],
    );
  }
}
