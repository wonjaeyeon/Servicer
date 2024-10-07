import 'package:flutter/material.dart';
import 'package:servicer/main_pages/analytics_pages/sub/earnings/composition/multi_chart/shopping_mall/sub/multi_view/_multi_view_chart_maker/m_data_handler/legend_data_handler.dart';
import 'package:servicer/servicer_modules/shopping_mall_master.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../../../../../../design_standards/colors.dart';
import '../../../../../../../../../../design_standards/text_styles.dart';

class RatioViewChartContainerV2 extends StatefulWidget {
  const RatioViewChartContainerV2({super.key});

  @override
  State<RatioViewChartContainerV2> createState() =>
      _RatioViewChartContainerV2State();
}

class _RatioViewChartContainerV2State extends State<RatioViewChartContainerV2>
    with LegendDataHandler {
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true, color: $$Grey, opacity: 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double _verticalPadding = 15;
    final double _horizontalPadding = 15;
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 0),
        child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 300,
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 0), //*그래프 컨테이너 바깥쪽 간격
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(0),
            ),
            child: SfCircularChart(
              //title: ChartTitle(text: 'Electricity sectors'),
              legend: Legend(
                position: LegendPosition.bottom,
                isVisible: true,
                overflowMode: LegendItemOverflowMode.wrap,
                height: '100%',
              ),
              series: _getLegendDefaultSeries(),
              tooltipBehavior: TooltipBehavior(enable: true),
            )));
  }

  ///Get the default circular series
  List<DoughnutSeries<ChartSampleData, String>> _getLegendDefaultSeries() {
    return <DoughnutSeries<ChartSampleData, String>>[
      DoughnutSeries<ChartSampleData, String>(
          pointColorMapper: (ChartSampleData data, _) => data.pointColor,
          sortingOrder: SortingOrder.descending,
          sortFieldValueMapper: (ChartSampleData data, _) => data.y.toString(),
          dataSource: <ChartSampleData>[
            ChartSampleData(
                x: '스마트스토어',
                y: 56.2,
                pointColor: mallMaster.themeColorOf(Mall.NaverSmartStore)),
            ChartSampleData(
                x: '지그재그',
                y: 12.7,
                pointColor: mallMaster.themeColorOf(Mall.Zigzag)),
            ChartSampleData(
                x: '에이블리',
                y: 1.3,
                pointColor: mallMaster.themeColorOf(Mall.Ably)),
            ChartSampleData(
                x: '쿠팡',
                y: 10,
                pointColor: mallMaster.themeColorOf(Mall.Coupang)),
          ],
          xValueMapper: (ChartSampleData data, _) => data.x as String,
          yValueMapper: (ChartSampleData data, _) => data.y,
          startAngle: 90,
          endAngle: 90,
          dataLabelSettings: const DataLabelSettings(
              isVisible: true, labelPosition: ChartDataLabelPosition.outside)),
    ];
  }
}

class ChartSampleData {
  /// Holds the datapoint values like x, y, etc.,
  ChartSampleData(
      {this.x,
      this.y,
      this.xValue,
      this.yValue,
      this.secondSeriesYValue,
      this.thirdSeriesYValue,
      this.pointColor,
      this.size,
      this.text,
      this.open,
      this.close,
      this.low,
      this.high,
      this.volume});

  /// Holds x value of the datapoint
  final dynamic x;

  /// Holds y value of the datapoint
  final num? y;

  /// Holds x value of the datapoint
  final dynamic xValue;

  /// Holds y value of the datapoint
  final num? yValue;

  /// Holds y value of the datapoint(for 2nd series)
  final num? secondSeriesYValue;

  /// Holds y value of the datapoint(for 3nd series)
  final num? thirdSeriesYValue;

  /// Holds point color of the datapoint
  final Color? pointColor;

  /// Holds size of the datapoint
  final num? size;

  /// Holds datalabel/text value mapper of the datapoint
  final String? text;

  /// Holds open value of the datapoint
  final num? open;

  /// Holds close value of the datapoint
  final num? close;

  /// Holds low value of the datapoint
  final num? low;

  /// Holds high value of the datapoint
  final num? high;

  /// Holds open value of the datapoint
  final num? volume;
}
