import 'package:flutter/material.dart';
import 'package:servicer/MOD_PACKAGES/fl_chart_svc/fl_chart.dart';

import '../../sub/shopping_mall/gender_chart.dart';
import '../../sub/shopping_mall/age_chart.dart';
import '../../sub/shopping_mall/monthly_best_product.dart';
import '../../sub/shopping_mall/sale_rate_summary.dart';
import '../../sub/shopping_mall/return_chart.dart';

class ShoppingMallAnalysisTabPage2 extends StatefulWidget {
  ShoppingMallAnalysisTabPage2({Key? key}) : super(key: key);

  @override
  State<ShoppingMallAnalysisTabPage2> createState() =>
      _ShoppingMallAnalysisTabPage2State();
}

class _ShoppingMallAnalysisTabPage2State
    extends State<ShoppingMallAnalysisTabPage2> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        //!SECTION <요약>
        Container(
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
                    '요약',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
              const SizedBox(height: 4),
              AspectRatio(
                aspectRatio: 1.2,
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: SummaryChartContainer(
                    title: "a",
                    unit: "b",
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        //!SECTION <주요 쇼핑몰 반품률>
        Container(
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
                    '주요 쇼핑몰 반품률',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
              SizedBox(height: 4),
              AspectRatio(
                aspectRatio: 1.2,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  child: ReturnChartContainer(),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        //!SECTION <성별 및 연령>
        Container(
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
                    '성별 및 연령 구성',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Column(
                children: [
                  AspectRatio(
                    aspectRatio: 2.0, //2.3
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      child: GenderChartContainer(),
                    ),
                  ),
                  AspectRatio(
                    aspectRatio: 1.5,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      child: AgeChartContainer(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        //!SECTION <인기 상품 top>
        // typing test
        // example:
        // a brown fox jumps over the lazy dog
        // a lazy fox jumps over the brown dog
        // pika pika p
        Container(
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
                    'Best 상품',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
              SizedBox(height: 4),
              AspectRatio(
                aspectRatio: 1.5,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  child: MonthlyBestProduct(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class SummaryChart extends StatelessWidget {
  const SummaryChart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text('<차트 - 도넛 그래프로 구성 비율>')),
    );
  }
}

class ReturnChart extends StatelessWidget {
  const ReturnChart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Text(
              '<차트 - 겹쳐진 멀티라인 그래프로 절대적 매출/주문량과 반품률을 동시에 보여줌 + 스케치 되어있는 도넛그래프로 총합 비율도 보여줌>')),
    );
  }
}

class GenderAgeChart extends StatelessWidget {
  const GenderAgeChart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text('<스케치했던 성별과 연령을 합친 두 그래프로 구성>')),
    );
  }
}

class BestProducts extends StatelessWidget {
  const BestProducts({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text('<그냥 가장 많은 판매량이 나온 제품과 팔린 쇼핑몰을 보여주기>')),
    );
  }
}
