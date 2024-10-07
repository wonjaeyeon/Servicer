import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:servicer/MOD_PACKAGES/BH_touchFX/bh_touchfx.dart';
import 'package:servicer/MOD_PACKAGES/fl_chart_svc/fl_chart.dart';
import 'package:servicer/design_standards/text_styles.dart';
import 'package:servicer/main.dart';
import 'package:servicer/main_pages/analytics_pages/shopping_mall/shopping_mall_v2.dart';
import 'package:servicer/main_pages/analytics_pages/shopping_mall/sub/s_analysis_tab_page_2.dart';
import 'package:servicer/servicer_modules/shopping_mall_master.dart';

import '../sub/shopping_mall/all_orders_list.dart';

var f = NumberFormat.currency(locale: "ko_KR", symbol: "￦");

class ShoppingMallAnalyticsPageV3 extends StatefulWidget {
  ShoppingMallAnalyticsPageV3({Key? key}) : super(key: key);

  @override
  State<ShoppingMallAnalyticsPageV3> createState() =>
      _ShoppingMallAnalyticsPageV3State();
}

class _ShoppingMallAnalyticsPageV3State
    extends State<ShoppingMallAnalyticsPageV3> {
  BarChartData finalChartData = BarChartData();
  List<Enum> sortedMallList = [];

  List<Widget> testList = [];

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

  List ordersList = [
    /// 결제 대기: 1
    /// 결제 완료: 2
    /// 상품 준비: 3
    /// 배송 중: 4
    /// 배송 완료: 5
    /// 표시 안함: -1
    {
      "productName": "QCY 무선 블루투스이어폰",
      "mall": Mall.ElevenStreet,
      "date": "2022-11-01",
      "saleType": "REFUND",
      "quantity": 1,
      "priceTotal": 20000,
      "paymentStatus": -1,
    },
    {
      "productName": "쿠팡베이직 네추럴 3겹 천연펄프 롤화장지 30m",
      "mall": Mall.ElevenStreet,
      "date": "2022-11-02",
      "saleType": "SALE",
      "quantity": 1,
      "priceTotal": 19000,
      "paymentStatus": 5
    },
    {
      "productName": "벤션 4극 AUX 오디오 마이크 연장케이블 연장선 0.5m",
      "mall": Mall.ElevenStreet,
      "date": "2022-11-04",
      "saleType": "SALE",
      "quantity": 1,
      "priceTotal": 6500,
      "paymentStatus": 5
    },
    {
      "productName": "모모켓 닌텐도스위치 휴대용 퀵 파우치",
      "mall": Mall.ElevenStreet,
      "date": "2022-11-08",
      "saleType": "CANCEL",
      "quantity": 1,
      "priceTotal": 8000,
      "paymentStatus": 4
    },
    {
      "productName": "Type-C PCB기판 모듈 d형",
      "mall": Mall.Coupang,
      "date": "2022-11-09",
      "saleType": "SALE",
      "quantity": 1,
      "priceTotal": 12000,
      "paymentStatus": 3
    },
    {
      "productName": "오리털 덕 패딩조끼",
      "mall": Mall.NaverSmartStore,
      "date": "2022-11-03",
      "saleType": "SALE",
      "quantity": 1,
      "priceTotal": 89800,
      "paymentStatus": 3
    },
    {
      "productName": "코딩 단가라 울 니트",
      "mall": Mall.NaverSmartStore,
      "date": "2022-11-05",
      "saleType": "SALE",
      "quantity": 1,
      "priceTotal": 58900,
      "paymentStatus": 2
    },
    {
      "productName": "하이엔드 세미와이드 흑청 데님 팬츠",
      "mall": Mall.Ably,
      "date": "2022-11-10",
      "saleType": "SALE",
      "quantity": 1,
      "priceTotal": 39900,
      "paymentStatus": 1
    },
    {
      "productName": "커플 스트라이프 니트 가디건",
      "mall": Mall.Auction,
      "date": "2022-11-07",
      "saleType": "REFUND",
      "quantity": 1,
      "priceTotal": 46800,
      "paymentStatus": -1
    },
    {
      "productName": "일론 카고 팬츠",
      "mall": Mall.Auction,
      "date": "2022-11-08",
      "saleType": "SALE",
      "quantity": 1,
      "priceTotal": 43900,
      "paymentStatus": 2
    },
  ];

  // Map<Enum, double> dataMap_orders = {
  //   Mall.ElevenStreet: 32,
  //   Mall.NaverSmartStore: 42,
  //   Mall.Auction: 42,
  //   Mall.Coupang: 32,
  //   Mall.TenByTen: 12,
  //   Mall.Tmon: 22,
  //   Mall.Gmarket: 2,
  //   Mall.Wemakeprice: 12,
  //   Mall.Ably: 22,
  //   Mall.Brandi: 12,
  //   Mall.Hiver: 42,
  //   Mall.KakaoShopping: 12,
  //   Mall.Lookpin: 12,
  //   Mall.Zigzag: 10,
  // };

  // BarChartData convertMapsToBarChartData(Map<Enum, double> revenueData, Map<Enum, double> ordersData) {
  //   List<BarChartGroupData> barChartGroupDataList = [];
  //   double averageRevenueOfRest = 0;
  //   BarChartData result = BarChartData(
  //     // set maxY to the maximum value of revenueData
  //     maxY: revenueData.values.reduce(max) * 1.1,
  //     barGroups: barChartGroupDataList, alignment: BarChartAlignment.spaceAround,
  //     titlesData: FlTitlesData(
  //       leftTitles: AxisTitles(),
  //       rightTitles: AxisTitles(),
  //       bottomTitles: AxisTitles(
  //         sideTitles: SideTitles(
  //           showTitles: true,
  //           reservedSize: 35,
  //           getTitlesWidget: (value, meta) {
  //             print(value);
  //             return
  //                 //  쇼핑몰 이름 뜨게
  //                 // Text((value != 5) ? '${mallMaster.textOf(sortedMallList[value.toInt()])}' : '기타 평균',
  //                 //     style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal, fontSize: 8));
  //                 //
  //                 (value != 5)
  //                     ? Container(
  //                         height: 30,
  //                         width: 30,
  //                         child: Column(
  //                           children: [
  //                             SizedBox(height: 5),
  //                             mallMaster.smallImgOf(sortedMallList[value.toInt()]),
  //                           ],
  //                         ),
  //                       )
  //                     : Text('기타 평균', style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal, fontSize: 8));
  //           },
  //         ),
  //       ),
  //       topTitles: AxisTitles(),
  //     ),
  //     // remove border
  //     borderData: FlBorderData(show: false),
  //     gridData: FlGridData(
  //       show: false,
  //       drawVerticalLine: true,
  //       getDrawingHorizontalLine: (value) {
  //         return FlLine(
  //           color: Colors.grey,
  //           strokeWidth: 1,
  //         );
  //       },
  //       getDrawingVerticalLine: (value) {
  //         return FlLine(
  //           color: Colors.grey,
  //           strokeWidth: 1,
  //         );
  //       },
  //     ),
  //   );

  //   // first sort the revenueData by double
  //   sortedMallList = revenueData.keys.toList()..sort((k1, k2) => revenueData[k2]!.compareTo(revenueData[k1]!));
  //   // for loop the sortedOrdersData
  //   for (int i = 0; i < sortedMallList.length; i++) {
  //     if (i < 5) {
  //       Enum key = sortedMallList[i];
  //       double revenueValue = revenueData[key]!;
  //       // get the revenueData value by key
  //       double orderValue = ordersData[key]!;
  //       // add the barChartGroupData to the barChartGroupDataList
  //       barChartGroupDataList.add(BarChartGroupData(x: i, groupVertically: false, barRods: [
  //         BarChartRodData(toY: revenueValue, color: Colors.pink, width: 25, borderRadius: BorderRadius.all(Radius.circular(4))),
  //         //BarChartRodData(toY: orderValue, color: Colors.blue, width: 5, borderRadius: BorderRadius.all(Radius.circular(4))),
  //       ]));
  //     } else {
  //       // average the rest of the data
  //       double averageOrdersOfRest = 0;
  //       for (int j = 5; j < sortedMallList.length; j++) {
  //         averageRevenueOfRest += revenueData[sortedMallList[j]]!;
  //         averageOrdersOfRest += ordersData[sortedMallList[j]]!;
  //       }
  //       averageRevenueOfRest = averageRevenueOfRest / (sortedMallList.length - 5);
  //       averageOrdersOfRest = averageOrdersOfRest / (sortedMallList.length - 5);
  //     }
  //     // get the key and value of the sortedOrdersData

  //   }
  //   barChartGroupDataList.add(BarChartGroupData(x: 5, groupVertically: false, barRods: [
  //     BarChartRodData(
  //         toY: averageRevenueOfRest, color: Colors.grey, width: 25, borderRadius: BorderRadius.all(Radius.circular(4))),
  //     //BarChartRodData(toY: averageOrders, color: Colors.blue, width: 5, borderRadius: BorderRadius.all(Radius.circular(4))),
  //   ]));

  //   return result;
  // }

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
      body: SafeArea(
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
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      // tab 1
                      Container(
                        //padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: ListView(
                          shrinkWrap: true,
                          //!SECTION 주문 결제 현황 페이지
                          children: [
                            // SizedBox(height: 16),
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        '주문 및 결제 현황',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Row(
                                            children: [
                                              Icon(Icons
                                                  .featured_play_list_sharp),
                                              SizedBox(width: 10),
                                              Text('결제 대기'),
                                              Spacer(),
                                              Text('4',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ],
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                          ),
                                        ),
                                        Container(
                                            width: double.infinity,
                                            height: 1,
                                            color: Colors.grey,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 10)),
                                        Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Row(
                                            children: [
                                              Icon(Icons.checklist),
                                              SizedBox(width: 10),
                                              Text('결제 완료'),
                                              Spacer(),
                                              Text('32',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ],
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                          ),
                                        ),
                                        Container(
                                            width: double.infinity,
                                            height: 1,
                                            color: Colors.grey,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 10)),
                                        Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Row(
                                            children: [
                                              Icon(Icons.warehouse),
                                              SizedBox(width: 10),
                                              Text('상품 준비'),
                                              Spacer(),
                                              Text('6',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ],
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                          ),
                                        ),
                                      ],
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            /*
                            SizedBox(height: 16),
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
                                        '환불 및 교환 현황',
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
                                              Icon(Icons.featured_play_list_sharp),
                                              SizedBox(width: 10),
                                              Text('결제 대기'),
                                              Spacer(),
                                              Text('4', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
                                              Icon(Icons.checklist),
                                              SizedBox(width: 10),
                                              Text('결제 완료'),
                                              Spacer(),
                                              Text('32', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
                                              Icon(Icons.warehouse),
                                              SizedBox(width: 10),
                                              Text('상품 준비'),
                                              Spacer(),
                                              Text('6', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
                            */
                            SizedBox(height: 16),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 0),
                              padding: EdgeInsets.only(top: 16, bottom: 8),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                //borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: Colors.transparent),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Row(
                                      children: [
                                        Text(
                                          '최근 내역  ',
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        // make legend

                                        BHTouchFXInkWell(
                                          onTap: () {
                                            _buildOrderRows();
                                            setState(() {});
                                          },
                                          child: Icon(
                                            Icons.help_outline_rounded,
                                            size: 16,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Spacer(),
                                        BHTouchFXInkWell(
                                          onTap: () {
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => AllOrdersList()));
                                          },
                                          child: Text(
                                            '전체보기',
                                            style: TextStyle(fontSize: 15, color: Colors.grey),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  SizedBox(height: 8),
                                  //flchart
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: (testList.isEmpty)
                                          ? 1
                                          : testList.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return (testList.isEmpty)
                                            ? Container(
                                                padding: EdgeInsets.all(20),
                                                child: Text('주문 내역이 없습니다.'),
                                                alignment: Alignment.center)
                                            : Column(
                                                children: [testList[index]],
                                              );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
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

  Widget singleDateRow(String date) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
        child: Text(date),
        alignment: Alignment.centerLeft);
  }

  Widget singleOrderRow(Map order) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: mallMaster.smallImgOf(order['mall']),
      ),
      title: Text(order['productName'],
          style: (order['saleType'] == 'SALE')
              ? TextStyle()
              : TextStyle(decoration: TextDecoration.lineThrough)),
      // format price with commas every 3 digits
      subtitle: (order['saleType'] == 'SALE')
          ? Text(f.format(order['priceTotal']))
          // 취소선
          : Text(f.format(order['priceTotal']),
              style: TextStyle(decoration: TextDecoration.lineThrough)),
      trailing: (order['saleType'] == 'CANCEL')
          ? Text('취소', style: TextStyle(fontSize: 12, color: Colors.grey))
          : (order['saleType'] == 'REFUND')
              ? Text('환불', style: TextStyle(fontSize: 12, color: Colors.grey))
              : statusBox(order['paymentStatus']),
    );
  }

  Widget statusBox(int status) {
    // first choose color and text
    Color _statusColor;
    Text _statusText;
    double _fosize = 10;
    switch (status) {
      case 1:
        _statusColor = Colors.grey;
        _statusText = Text('결제 대기',
            style: TextStyle(fontSize: _fosize, color: _statusColor));
        break;
      case 2:
        _statusColor = Colors.black;
        _statusText = Text('결제 완료',
            style: TextStyle(fontSize: _fosize, color: _statusColor));
        break;
      case 3:
        _statusColor = Colors.brown;
        _statusText = Text('상품 준비',
            style: TextStyle(fontSize: _fosize, color: _statusColor));
        break;
      case 4:
        _statusColor = Colors.red;
        _statusText = Text('배송 중',
            style: TextStyle(fontSize: _fosize, color: _statusColor));
        break;
      case 5:
        _statusColor = Colors.black;
        _statusText = Text('배송 완료',
            style: TextStyle(fontSize: _fosize, color: _statusColor));
        break;
      case -1:
        _statusColor = Colors.transparent;
        _statusText =
            Text('', style: TextStyle(fontSize: _fosize, color: _statusColor));
        break;
      default:
        _statusColor = Colors.transparent;
        _statusText =
            Text('', style: TextStyle(fontSize: _fosize, color: _statusColor));
        // return container with rounded border
        break;
    }
    return ConstrainedBox(
      constraints: BoxConstraints(
          minHeight: 5.0, minWidth: 5.0, maxHeight: 20.0, maxWidth: 50.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _statusColor, width: 0.3),
        ),
        child: _statusText,
        alignment: Alignment.center,
      ),
    );
  }

  void _buildOrderRows() {
    // sort orderslist by date and add to testList; add date row if date is changed
    // first sort by date
    ordersList.sort((b, a) => a["date"].compareTo(b["date"]));
    // then add to testList
    for (int i = 0; i < ordersList.length; i++) {
      if (i == 0) {
        testList.add(singleDateRow(ordersList[i]["date"]));
        testList.add(singleOrderRow(ordersList[i]));
        // testList.add(Container(
        //     width: double.infinity,
        //     height: 1,
        //     color: Colors.grey.withAlpha(100),
        //     margin: EdgeInsets.symmetric(horizontal: 10)));
      } else {
        if (ordersList[i]["date"] == ordersList[i - 1]["date"]) {
          testList.add(singleOrderRow(ordersList[i]));
        } else {
          testList.add(singleDateRow(ordersList[i]["date"]));
          testList.add(singleOrderRow(ordersList[i]));
        }
      }
    }
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
