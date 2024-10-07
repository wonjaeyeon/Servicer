import 'package:flutter/material.dart';
import 'package:servicer/main_pages/analytics_pages/earnings/earnings.dart';
import 'package:servicer/main_pages/analytics_pages/orders/orders.dart';
import 'package:servicer/main_pages/analytics_pages/shopping_mall/shopping_mall_v2.dart';
import 'package:servicer/main_pages/analytics_pages/shopping_mall/shopping_mall_v3.dart';
import 'package:servicer/main_pages/analytics_pages/shopping_mall/shopping_mall_v4.dart';
import 'package:servicer/main_pages/analytics_pages/sub/main/ExposureClickBarChart.dart';
import 'package:servicer/main_pages/analytics_pages/sub/main/GenderPieChart.dart';
import 'package:servicer/main_pages/analytics_pages/sub/main/HorizontalPercentageChart.dart';
import 'package:servicer/main_pages/analytics_pages/sub/main/MultiLineChart.dart';
import 'package:servicer/main_pages/analytics_pages/sub/main/PriceRangeChart.dart';
import 'package:servicer/main_pages/analytics_pages/sub/main/SmallBox_Orders.dart';
import 'package:servicer/main_pages/analytics_pages/sub/main/XYChart.dart';

import 'earnings/earnings_ver2.dart';
import 'earnings/earnings_ver3.dart';
import 'sub/main/SmallBox_Earnings.dart';
import 'sub/main/XYChart_ver2.dart';
import 'sub/main/XYChart_ver3.dart';

class AnalyticsMainPage extends StatefulWidget {
  AnalyticsMainPage({Key? key}) : super(key: key);

  @override
  State<AnalyticsMainPage> createState() => _AnalyticsMainPageState();
}

var pageBgColor = Color.fromARGB(255, 238, 238, 238);

class _AnalyticsMainPageState extends State<AnalyticsMainPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double _verticalPadding = 15;
    final double _horizontalPadding = 15;
    Key _appBarKey = GlobalKey();
    ScrollController _scrollController = ScrollController();
    _scrollController.addListener(() {
      //print(_scrollController.position.pixels);
    });

    return Scaffold(
      backgroundColor: pageBgColor,
      body: SafeArea(
        top: true,
        // sliverappbar
        child: CustomScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              key: _appBarKey,
              backgroundColor: pageBgColor,
              expandedHeight: 90,
              collapsedHeight: 50,
              toolbarHeight: 50,
              surfaceTintColor: Colors.blue,
              elevation: 2,
              shadowColor: Colors.black,
              flexibleSpace: const FlexibleSpaceBar(
                centerTitle: true,
                title: Text(
                  'Overview',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
              automaticallyImplyLeading: false,
              floating: false,
              snap: false,
              pinned: true,

              stretch: false, //* 앱바 늘어나는 효과는 이걸 true로...
            ),
            SliverToBoxAdapter(
              child: SingleChildScrollView(
                // physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(height: _verticalPadding),
                    Row(
                      children: [
                        SizedBox(width: _horizontalPadding),
                        // 매출액
                        Flexible(
                          child: AspectRatio(
                            aspectRatio: 1.2,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                children: [
                                  Align(
                                    child: Padding(
                                        child: Text('매출액'),
                                        padding: EdgeInsets.only(
                                            top: _verticalPadding)),
                                    alignment: Alignment.topCenter,
                                  ),
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: SmallBoxEarnings(),
                                    ),
                                  ),
                                  Divider(thickness: 1, height: 0),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  EarningsV3()));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                        child: Text('매출 분석 보기'),
                                        alignment: Alignment.center,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: _horizontalPadding),
                        // 주문건수
                        Flexible(
                          child: AspectRatio(
                            aspectRatio: 1.2,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                children: [
                                  Align(
                                    child: Padding(
                                        child: Text('주문량'),
                                        padding: EdgeInsets.only(top: 10)),
                                    alignment: Alignment.topCenter,
                                  ),
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: SmallBoxOrders(),
                                    ),
                                  ),
                                  Divider(thickness: 1, height: 0),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Orders()));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                        child: Text('주문 분석 보기'),
                                        alignment: Alignment.center,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: _horizontalPadding),
                      ],
                    ),
                    SizedBox(height: _verticalPadding),
                    // 주문수 XY 그래프
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: _horizontalPadding),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: [
                            SizedBox(child: XYChartV3()),
                            Divider(thickness: 1, height: 0),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ShoppingMallAnalyticsPageV4()));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                  child: Text('판매처 분석 보기'),
                                  alignment: Alignment.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: _verticalPadding),
                    // 매출 비율 그래프
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: _horizontalPadding),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: HorizontalPercentageChart(),
                      ),
                    ),
                    SizedBox(height: _verticalPadding),
                    // 성별 비율 그래프
                    Row(
                      children: [
                        SizedBox(width: _horizontalPadding),
                        Flexible(
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: GenderPieChart(),
                            ),
                          ),
                        ),
                        SizedBox(width: _horizontalPadding),
                        Flexible(
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: ExposureClickBarChart(),
                            ),
                          ),
                        ),
                        SizedBox(width: _horizontalPadding),
                      ],
                    ),
                    SizedBox(height: _verticalPadding),
                    Row(
                      children: [
                        SizedBox(width: _horizontalPadding),
                        Flexible(
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: MultiLineChart(),
                            ),
                          ),
                        ),
                        SizedBox(width: _horizontalPadding),
                        Flexible(
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: PriceRangeChart(),
                            ),
                          ),
                        ),
                        SizedBox(width: _horizontalPadding),
                      ],
                    ),
                    SizedBox(height: _verticalPadding),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
