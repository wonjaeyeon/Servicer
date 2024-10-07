import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:servicer/design_standards/colors.dart';
import 'package:servicer/servicer_modules/get_shoppingmall_theme.dart';

class HorizontalPercentageChart extends StatefulWidget {
  HorizontalPercentageChart({Key? key}) : super(key: key);

  @override
  State<HorizontalPercentageChart> createState() => _HorizontalPercentageChartState();
}

class _HorizontalPercentageChartState extends State<HorizontalPercentageChart> {
  double chartWidth = 22;

  List<Color> color_theme = [$$mainColor2, $$mainColor3, $$mainColor4, $$mainColor5, $$mainColor6];
  double animatedWidth = 0;
  List<List> earnings = [
    [ShoppingMall.coupang, 219400],
    [ShoppingMall.gMarket, 103000],
    [ShoppingMall.naverSmartStore, 523000],
    [ShoppingMall.elevenStreet, 311200],
    [ShoppingMall.lookpin, 214500],
  ];
  List<Expanded> horinzontalBarsList = [];
  List<Row> legends = [];

  @override
  void initState() {
    // sort by earnings
    earnings.sort((a, b) => b[1].compareTo(a[1]));
    int index = 0;
    for (List l in earnings) {
      index++;
      horinzontalBarsList.add(
        Expanded(
          flex: l[1],
          child: AnimatedContainer(
            duration: Duration(milliseconds: 500),
            height: chartWidth,
            color: color_theme[index - 1],
            //color: getColorFromShoppingMall(l[0]),
          ),
        ),
      );
      legends.add(legend(l[0], color_theme[index - 1]));
    }
    animateNow();
    super.initState();
  }

  void animateNow() async {
    await Future.delayed(Duration(milliseconds: 100));
    // animate
    setState(() {
      animatedWidth = MediaQuery.of(context).size.width - 40;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Text('쇼핑몰 매출 비율'),
          SizedBox(height: 10),
          // make a circular mask
          Container(
            // make border
            // decoration: BoxDecoration(
            //   border: Border.all(color: $$mainColor1, width: 1),
            //   borderRadius: BorderRadius.circular(8),
            // ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                alignment: Alignment.centerLeft,
                child: AnimatedContainer(
                  decoration: BoxDecoration(),
                  curve: Curves.easeOutCirc,
                  duration: Duration(milliseconds: 1000),
                  width: animatedWidth,
                  child: Flex(
                    direction: Axis.horizontal,
                    children: horinzontalBarsList,
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: legends,
          ),
        ],
      ),
    );
  }

  Row legend(ShoppingMall s, [Color? col]) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: col ?? getColorFromShoppingMall(s),
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 5),
        Text(getNameFromShoppingMall(s)),
      ],
    );
  }
}
