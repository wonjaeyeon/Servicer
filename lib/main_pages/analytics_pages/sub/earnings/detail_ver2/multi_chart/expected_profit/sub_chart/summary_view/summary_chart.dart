import 'package:flutter/material.dart';
import 'package:servicer/design_standards/colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../../../../../data_handler/data_standards/time.dart';

class SummarySubChartContainer extends StatefulWidget {
  final double width;
  final Time time;
  const SummarySubChartContainer(
      {Key? key, required this.time, required this.width})
      : super(key: key);

  @override
  State<SummarySubChartContainer> createState() =>
      SummarySubChartContainerState();
}

class SummarySubChartContainerState extends State<SummarySubChartContainer> {
  late TooltipBehavior _tooltipBehavior;
  final String unit = '원';

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true, color: $$Grey, opacity: 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 0),
        padding: EdgeInsets.symmetric(vertical: 16),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          // borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.transparent),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  '예상수익 요약 정리',
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
            SizedBox(height: 4),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Icon(Icons.add_circle_outline_rounded),
                        SizedBox(width: 10),
                        Text('매출'),
                        Spacer(),
                        Text('206,000원',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                  ),
                  Container(
                      width: double.infinity,
                      height: 1,
                      color: Colors.grey,
                      margin: EdgeInsets.symmetric(horizontal: 10)),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Icon(Icons.do_disturb_on_outlined),
                        SizedBox(width: 10),
                        Text('예상 비용'),
                        Spacer(),
                        Text('30,000~50,000원',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                  ),
                  Container(
                      width: double.infinity,
                      height: 1,
                      color: Colors.grey,
                      margin: EdgeInsets.symmetric(horizontal: 10)),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Icon(Icons.list_alt_outlined),
                        SizedBox(width: 10),
                        Text('예상 수익'),
                        Spacer(),
                        Text('15,600~18,600원',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<EarningsData> getChartData(Time time) {
    List<EarningsData> chartData = [];
    if (time == Time.day) {
      chartData = [
        EarningsData('12:00', 3),
        EarningsData('13:00', 5),
        EarningsData('14:00', 4),
        EarningsData('15:00', 5),
        EarningsData('16:00', 4),
        EarningsData('17:00', 5),
        EarningsData('18:00', 4),
        EarningsData('19:00', 5),
        EarningsData('20:00', 4),
        EarningsData('21:00', 5),
        EarningsData('22:00', 6),
        EarningsData('23:00', 5)
      ];
    } else if (time == Time.week) {
      chartData = [
        EarningsData('Mon', 15),
        EarningsData('Tue', 20),
        EarningsData('Wed', 13),
        EarningsData('Thu', 15),
        EarningsData('Fri', 21),
        EarningsData('Sat', 23),
        EarningsData('Sun', 17),
      ];
    } else if (time == Time.month) {
      chartData = [
        EarningsData('1주', 15 * 7),
        EarningsData('2주', 20 * 7),
        EarningsData('3주', 16 * 7),
        EarningsData('4주', 18 * 7),
      ];
    } else if (time == Time.year) {
      chartData = [
        EarningsData('Jan', 15 * 31),
        EarningsData('Feb', 20 * 28),
        EarningsData('Mar', 16 * 31),
        EarningsData('Apr', 15 * 30),
        EarningsData('May', 19 * 31),
        EarningsData('Jun', 21 * 30),
        EarningsData('Jul', 24 * 31),
        EarningsData('Aug', 18 * 31),
        EarningsData('Sep', 19 * 30),
        EarningsData('Oct', 17 * 31),
        EarningsData('Nov', 18 * 30),
        EarningsData('Dec', 16 * 31),
      ];
    } else if (time == Time.all) {
      chartData = [
        EarningsData('2021.1월', 15 * 31),
        EarningsData('2021.2월', 20 * 28),
        EarningsData('2021.3월', 16 * 31),
        EarningsData('2021.4월', 15 * 30),
        EarningsData('2021.5월', 19 * 31),
        EarningsData('2021.6월', 21 * 30),
        EarningsData('2021.7월', 24 * 31),
        EarningsData('2021.8월', 18 * 31),
        EarningsData('2021.9월', 19 * 30),
        EarningsData('2021.10월', 17 * 31),
        EarningsData('2021.11월', 18 * 30),
        EarningsData('2021.12월', 16 * 31),
        EarningsData('2022.1월', 15 * 31),
        EarningsData('2022.2월', 20 * 28),
        EarningsData('2022.3월', 16 * 31),
        EarningsData('2022.4월', 15 * 30),
        EarningsData('2022.5월', 19 * 31),
        EarningsData('2022.6월', 21 * 30),
        EarningsData('2022.7월', 24 * 31),
        EarningsData('2022.8월', 18 * 31),
        EarningsData('2022.9월', 19 * 30),
        EarningsData('2022.10월', 17 * 31),
        EarningsData('2022.11월', 18 * 30),
        EarningsData('2022.12월', 16 * 31),
      ];
    }
    return chartData;
  }
}

class EarningsData {
  EarningsData(this.earningsCategory, this.sales);
  final String earningsCategory;
  final int sales;
}
