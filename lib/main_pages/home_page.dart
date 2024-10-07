import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:flutter/services.dart';
import 'package:servicer/design_standards/colors.dart';
import 'package:servicer/design_standards/text_styles.dart';
import 'package:servicer/design_standards/widget_styles.dart';
import 'package:servicer/main_pages/analytics_pages/new_main.dart';
import 'package:servicer/sub_widgets/mainPage_SalesStatus_barchart.dart';
import 'package:servicer/alarm/a_main_page.dart';

import '../MOD_PACKAGES/SVSHorizontalBarChart/SVS_horizontalBarChart.dart';
import '../sample_data/getdata.dart';
import 'package:badges/badges.dart' as badges;
double $cardMenuElevation = 25;
RoundedRectangleBorder $cardMenuShape =
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0));
EdgeInsets $cardMenuVerticalMargin =
    EdgeInsets.symmetric(horizontal: 0, vertical: 8);
EdgeInsets $cardMenuContainerMargin = EdgeInsets.all(16);

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBgColor,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              // 중간에 잘린 배경색
              Container(
                //color: $$mainColor2,
                color: pageBgColor,
                width: double.infinity,
                height: 300,
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 16, bottom: 24),
                        child: Row(
                          children: [
                            Flexible(
                              child: Stack(
                                alignment: Alignment.centerLeft,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: $$mainColor1,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                    ),
                                    height: 28,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        child: Text('공지'),
                                        margin:
                                            EdgeInsets.symmetric(horizontal: 4),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                        ),
                                        height: 20,
                                        width: 50,
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(top: 1),
                                        child: Text(
                                          '새 기능이 추가되었습니다',
                                          style: TextStyle(color: Colors.white),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AlarmMainPage()));
                              },
                              child: badges.Badge(
                                badgeContent: Text('3',
                                    style: TextStyle(color: Colors.white)),
                                child: Icon(
                                  Icons.notifications_outlined,
                                  color: Colors.white,
                                  size: $bigFontSize,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Text(
                        '서비서 님, 좋은 아침이에요! ',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          // color: Colors.white,
                          color: $$mainColor1,
                          fontSize: $bigFontSize,
                        ),
                      ),
                      Text(
                        '이번 달 판매 현황 >',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          // color: Colors.white,
                          color: $$mainColor1,
                          fontSize: $mediumFontSize,
                        ),
                      ),
                      Padding(padding: EdgeInsets.symmetric(vertical: 24)),
                      Card(
                        elevation: $cardMenuElevation,
                        shape: $cardMenuShape,
                        margin: $cardMenuVerticalMargin,
                        child: Container(
                          //height: 120,
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(
                              vertical: 16, horizontal: 16),
                          child: Column(
                            children: [
                              Align(
                                  child: Text('쇼핑몰 주문 현황'),
                                  alignment: Alignment.topLeft),
                              Padding(
                                  padding: EdgeInsets.symmetric(vertical: 6)),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                // make a horizontal timeline chart with 4 icon, title and number; put circle on each timeline points
                                children: [
                                  Flexible(
                                    child: Container(
                                      width: 80,
                                      child: InkWell(
                                        onTap: () {},
                                        child: Column(
                                          children: [
                                            Icon(Icons.shopping_bag_outlined),
                                            SizedBox(height: 6),
                                            Text('결제 대기'),
                                            SizedBox(height: 2),
                                            Text('5',
                                                style: TextStyle(
                                                    fontSize: $mediumFontSize,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Container(
                                      width: 80,
                                      child: InkWell(
                                        onTap: () {},
                                        child: Column(
                                          children: [
                                            Icon(Icons.checklist_outlined),
                                            SizedBox(height: 6),
                                            Text('결제 완료'),
                                            SizedBox(height: 2),
                                            Text('9',
                                                style: TextStyle(
                                                    fontSize: $mediumFontSize,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Container(
                                      width: 80,
                                      child: InkWell(
                                        onTap: () {},
                                        child: Column(
                                          children: [
                                            Icon(Icons.warehouse),
                                            SizedBox(height: 6),
                                            Text('상품 준비'),
                                            SizedBox(height: 2),
                                            Text('7',
                                                style: TextStyle(
                                                    fontSize: $mediumFontSize,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Container(
                                      width: 80,
                                      child: InkWell(
                                        onTap: () {},
                                        child: Column(
                                          children: [
                                            Icon(Icons.warning),
                                            SizedBox(height: 6),
                                            Text('반품/환불'),
                                            SizedBox(height: 2),
                                            Text('2',
                                                style: TextStyle(
                                                    fontSize: $mediumFontSize,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                  padding: EdgeInsets.symmetric(vertical: 4)),
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    height: 2,
                                    width: double.infinity,
                                    color: Colors.indigo[100],
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 16),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        width: 11,
                                        height: 11,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white,
                                            border: Border.all(
                                                color: Colors.indigo,
                                                width: 2)),
                                      ),
                                      Container(
                                        width: 11,
                                        height: 11,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white,
                                            border: Border.all(
                                                color: Colors.indigo,
                                                width: 2)),
                                      ),
                                      Container(
                                        width: 11,
                                        height: 11,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white,
                                            border: Border.all(
                                                color: Colors.indigo,
                                                width: 2)),
                                      ),
                                      Container(
                                        width: 11,
                                        height: 11,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white,
                                            border: Border.all(
                                                color: Colors.indigo,
                                                width: 2)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        elevation: $cardMenuElevation,
                        shape: $cardMenuShape,
                        margin: $cardMenuVerticalMargin,
                        child: Container(
                          margin: $cardMenuContainerMargin,
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text('이번 주 매출'),
                                  SizedBox(width: 10),
                                  Text('768,700 원',
                                      style: TextStyle(
                                          fontSize: $mediumFontSize,
                                          fontWeight: FontWeight.bold)),
                                  Spacer(),
                                  FittedBox(
                                    child: InkWell(
                                      child: const Padding(
                                        padding: EdgeInsets.all(
                                            6), //* 카드 세로 길이에 영향 주지 않는 최소 패딩값임.
                                        child: Text('바로 보기 >'),
                                      ),
                                      onTap: () {},
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      // SECTION 메인화면 매출요약 그래프
                      Card(
                        elevation: $cardMenuElevation,
                        shape: $cardMenuShape,
                        margin: $cardMenuVerticalMargin,
                        child: Container(
                          padding: EdgeInsets.zero,
                          margin: $cardMenuContainerMargin,
                          alignment: Alignment.topCenter,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Align(
                                  child: Text('쇼핑몰 주문 현황'),
                                  alignment: Alignment.topLeft),
                              Padding(
                                  padding: EdgeInsets.symmetric(vertical: 6)),
                              Container(
                                child: SVSHorizontalBarChart(
                                    data: shoppingMallExampleData,
                                    useTestMode: false),
                                alignment: Alignment.topCenter,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
