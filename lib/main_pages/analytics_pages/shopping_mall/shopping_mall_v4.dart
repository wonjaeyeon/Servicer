import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:servicer/MOD_PACKAGES/fl_chart_svc/fl_chart.dart';
import 'package:servicer/design_standards/text_styles.dart';
import 'package:servicer/main.dart';
import 'package:servicer/main_pages/analytics_pages/shopping_mall/shopping_mall_v2.dart';
import 'package:servicer/main_pages/analytics_pages/shopping_mall/sub/s_analysis_tab_page_1.dart';
import 'package:servicer/main_pages/analytics_pages/shopping_mall/sub/s_analysis_tab_page_2.dart';
import 'package:servicer/servicer_modules/shopping_mall_master.dart';

var f = NumberFormat.currency(locale: "ko_KR", symbol: "￦");

class ShoppingMallAnalyticsPageV4 extends StatefulWidget {
  ShoppingMallAnalyticsPageV4({Key? key}) : super(key: key);

  @override
  State<ShoppingMallAnalyticsPageV4> createState() =>
      _ShoppingMallAnalyticsPageV4State();
}

class _ShoppingMallAnalyticsPageV4State
    extends State<ShoppingMallAnalyticsPageV4> {
  BarChartData finalChartData = BarChartData();
  List<Enum> sortedMallList = [];

  // List<Widget> testList = [];

  @override
  void initState() {
    // finalChartData = convertMapsToBarChartData(dataMap_revenue, dataMap_orders);

    super.initState();
  }

  Map<Enum, double> dataMap_revenue = {
    Mall.ElevenStreet: 321050,
    Mall.NaverSmartStore: 421010,
    Mall.Auction: 401040,
    Mall.Coupang: 280040,
    Mall.TenByTen: 121060,
    Mall.Tmon: 221030,
    Mall.Gmarket: 21080,
    Mall.Wemakeprice: 121080,
    Mall.Ably: 221090,
    Mall.Brandi: 121070,
    Mall.Hiver: 481040,
    Mall.KakaoShopping: 121050,
    Mall.Lookpin: 121090,
    Mall.Zigzag: 100030,
  };

  @override
  Widget build(BuildContext context) {
    // scaffold and safearea
    return Scaffold(
      backgroundColor: pageBgColor,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        title: Text('쇼핑몰 분석'),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: $mediumFontSize,
        ),
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
      ),
      body: ShaderMask(
        shaderCallback: (rect) {
          return LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.transparent,
              Colors.transparent,
              Color.fromARGB(255, 238, 238, 238)
            ],
            stops: [
              0.0,
              0.04,
              0.96,
              1.0
            ], // 10% purple, 80% transparent, 10% purple
          ).createShader(rect);
        },
        blendMode: BlendMode.dstOut,
        child: Container(
          // tab ui with 3 tabs
          child: DefaultTabController(
            length: 3,
            child: Column(
              children: [
                // tab bar
                Stack(
                  children: [
                    TabBar(
                      labelStyle: TextStyle(fontSize: $smallFontSize),
                      unselectedLabelColor: Colors.grey,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorPadding: EdgeInsets.symmetric(horizontal: 20),
                      // make the whole tabbar rounded only on bottom
                      isScrollable: false,
                      labelColor: Colors.black,
                      automaticIndicatorColorAdjustment: true,
                      indicatorColor: Colors.black,
                      tabs: [
                        /* 탭 제목 */
                        Tab(
                          text: '주문/결제 현황',
                        ),
                        Tab(
                          text: '통합 분석',
                        ),
                        Tab(
                          text: '추천',
                        ),
                      ],
                    ),
                    // make grey line on the bottom of the tabbar
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 1,
                        color: Colors.grey.withAlpha(50),
                      ),
                    ),
                  ],
                ),

                // tab bar view
                Expanded(
                  child: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      // tab 1
                      ShoppingMallAnalysisTabPage1(),
                      // tab 2
                      ShoppingMallAnalysisTabPage2(),
                      // tab 3
                      Container(
                        child: Center(
                          child: Text('추천'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class Order {
//   String date;
//   Enum mall;
//   String saleType;
//   String quantity;
//   double priceTotal;

//   Order(this["date"], this.mall, this.saleType, this.quantity, this.priceTotal);
// }
