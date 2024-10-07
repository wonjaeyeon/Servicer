import 'package:flutter/material.dart';
import 'package:servicer/design_standards/text_styles.dart';
import 'package:servicer/design_standards/widget_styles.dart';
import '../../../data_handler/mapData_handler/get_map_data.dart';
import '../../../data_handler/mapData_handler/mapData_picker.dart';
import 'element_list.dart';

class OrderSearchWidget extends StatefulWidget {
  const OrderSearchWidget({super.key});

  @override
  State<OrderSearchWidget> createState() => _OrderSearchWidgetState();
}

class _OrderSearchWidgetState extends State<OrderSearchWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(0),
        ),
        child: ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Padding(
              padding: $AnalyticsPageHorizontalPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(padding: EdgeInsets.symmetric(vertical: 8)),
                  Text(
                    '찾아보기',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: $mediumFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '2021.12 기준 (출처 : 시리즈서로 기업 자료)',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: $mediumFontSize - 6,
                    ),
                  ),
                ],
              ),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 16)),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 36),
                child: ElementList(
                    data: Picker().pickDataByRange(shoppingMallDayData, {
                  "zigzag",
                  "ably",
                  "lookpin",
                  "smartstore",
                  "blue t-shirts"
                }))),
          ],
        ),
      ),
    );
  }
}
