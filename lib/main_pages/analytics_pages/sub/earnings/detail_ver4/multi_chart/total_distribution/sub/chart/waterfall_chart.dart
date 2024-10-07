import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:servicer/design_standards/colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../../../../../data_handler/data_standards/time.dart';

class WaterfallSubChartContainer extends StatefulWidget {
  final double width;
  final Time time;
  const WaterfallSubChartContainer(
      {Key? key, required this.time, required this.width})
      : super(key: key);

  @override
  State<WaterfallSubChartContainer> createState() =>
      WaterfallSubChartContainerState();
}

class WaterfallSubChartContainerState
    extends State<WaterfallSubChartContainer> {
  late TooltipBehavior _tooltipBehavior;
  final String unit = '원';

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true, header: '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: widget.width,
        child: SfCartesianChart(
          plotAreaBorderWidth: 0,
          primaryXAxis: CategoryAxis(
              majorGridLines: const MajorGridLines(width: 0),
              labelIntersectAction: AxisLabelIntersectAction.rotate45),
          primaryYAxis: NumericAxis(
              name: 'Expenditure',
              minimum: 0,
              // maximum: 5000,
              interval: 100000,
              axisLine: const AxisLine(width: 0),
              majorTickLines: const MajorTickLines(size: 0),
              axisLabelFormatter: (AxisLabelRenderDetails details) {
                return ChartAxisLabel(
                    (details.value ~/ 10000).toString() + '만', null);
              }),
          series: _getWaterFallSeries(),
          tooltipBehavior: _tooltipBehavior,
          onTooltipRender: (TooltipArgs args) {
            args.text =
                args.dataPoints![args.pointIndex!.toInt()].x.toString() +
                    ' : ' +
                    (args.dataPoints![args.pointIndex!.toInt()].y / 1000)
                        .toString() +
                    '만';
          },
          onDataLabelRender: (DataLabelRenderArgs dataLabelArgs) {
            if (dataLabelArgs.pointIndex == 0) {
              dataLabelArgs.text = '25.6만';
            } else if (dataLabelArgs.pointIndex == 1) {
              dataLabelArgs.text = '-5만';
            } else if (dataLabelArgs.pointIndex == 2) {
              dataLabelArgs.text = '10만';
            } else if (dataLabelArgs.pointIndex == 3) {
              dataLabelArgs.text = '-10만';
            } else if (dataLabelArgs.pointIndex == 4) {
              dataLabelArgs.text = '-1.2만';
            } else if (dataLabelArgs.pointIndex == 5) {
              dataLabelArgs.text = '19.4만';
            }
          },
        ));
  }

  ///Get the histogram series
  List<WaterfallSeries<_ChartSampleData, dynamic>> _getWaterFallSeries() {
    return <WaterfallSeries<_ChartSampleData, dynamic>>[
      WaterfallSeries<_ChartSampleData, dynamic>(
          dataSource: <_ChartSampleData>[
            _ChartSampleData(
                x: '카드 결제 매출',
                y: 256000,
                intermediateSumPredicate: false,
                totalSumPredicate: false),
            _ChartSampleData(
                x: '카드 반품 매출',
                y: -50000,
                intermediateSumPredicate: false,
                totalSumPredicate: false),
            _ChartSampleData(
                x: '현금 결제 매출',
                y: 100000,
                intermediateSumPredicate: false,
                totalSumPredicate: false),
            _ChartSampleData(
                x: '신고 매입',
                y: -100000,
                intermediateSumPredicate: false,
                totalSumPredicate: false),
            _ChartSampleData(
                x: '매출 세금',
                y: -12000,
                intermediateSumPredicate: false,
                totalSumPredicate: false),
            _ChartSampleData(
                x: '총수익',
                intermediateSumPredicate: true,
                totalSumPredicate: false),
            // _ChartSampleData(
            //     x: 'Tax',
            //     y: -800,
            //     intermediateSumPredicate: false,
            //     totalSumPredicate: false),
            // _ChartSampleData(
            //     x: 'Net Profit',
            //     intermediateSumPredicate: false,
            //     totalSumPredicate: true),
          ],
          xValueMapper: (_ChartSampleData sales, _) => sales.x,
          yValueMapper: (_ChartSampleData sales, _) => sales.y,
          intermediateSumPredicate: (_ChartSampleData sales, _) =>
              sales.intermediateSumPredicate,
          totalSumPredicate: (_ChartSampleData sales, _) =>
              sales.totalSumPredicate,
          dataLabelSettings: const DataLabelSettings(
              isVisible: true, labelAlignment: ChartDataLabelAlignment.auto),
          color: const Color.fromRGBO(0, 189, 174, 1),
          negativePointsColor: const Color.fromRGBO(229, 101, 144, 1),
          intermediateSumColor: const Color.fromRGBO(79, 129, 188, 1),
          totalSumColor: const Color.fromRGBO(79, 129, 188, 1))
    ];
  }
}

class _ChartSampleData {
  _ChartSampleData(
      {this.x, this.y, this.intermediateSumPredicate, this.totalSumPredicate});

  final String? x;
  final num? y;
  final bool? intermediateSumPredicate;
  final bool? totalSumPredicate;
}
