import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../../../../../../../../MOD_PACKAGES/BH_touchFX/bh_touchfx.dart';
import '../../../../../../../../../../servicer_modules/shopping_mall_master.dart';

class SummaryViewChart extends StatefulWidget {
  const SummaryViewChart({super.key});

  @override
  SummaryViewChartState createState() => SummaryViewChartState();
}

class SummaryViewChartState extends State<SummaryViewChart> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '매출 유입/환입',
                style: TextStyle(fontSize: 15),
              ),
            ),
          ),
          SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Icon(Icons.add_circle_outline_rounded),
                    SizedBox(width: 4),
                    Text('유입'),
                    Spacer(),
                    Text('25만 6000원',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
                Container(
                    width: double.infinity,
                    height: 1,
                    color: Colors.grey,
                    margin: EdgeInsets.symmetric(horizontal: 10)),
                Row(
                  children: [
                    Icon(Icons.do_disturb_on_outlined),
                    SizedBox(width: 4),
                    Text('환입'),
                    Spacer(),
                    Text('5만원',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
                Container(
                    width: double.infinity,
                    height: 1,
                    color: Colors.grey,
                    margin: EdgeInsets.symmetric(horizontal: 10)),
                Row(
                  children: [
                    Icon(Icons.list_alt_outlined),
                    SizedBox(width: 4),
                    Text('총 매출'),
                    Spacer(),
                    Text('20만 6000원',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      ),
    );
  }
}
