import 'package:flutter/material.dart';
import 'package:servicer/design_standards/widget_styles.dart';

import '../../../servicer_modules/shopping_mall_master.dart';

class Recommendation extends StatefulWidget {
  const Recommendation({super.key});

  @override
  State<Recommendation> createState() => _RecommendationState();
}

class _RecommendationState extends State<Recommendation> {
  @override
  Widget build(BuildContext context) {
    final double _horizontalPadding = 15;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Column(
                children: [
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        '추천',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        child: mallMaster.smallImgOf(Mall.Auction),
                        width: 45,
                        height: 45,
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Text(
                        "이번달 옥션 매출이 많이 올랐어요.",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
