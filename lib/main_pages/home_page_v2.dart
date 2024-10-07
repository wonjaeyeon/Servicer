// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:servicer/MOD_PACKAGES/BH_touchFX/bh_touchfx.dart';

import 'package:servicer/MOD_PACKAGES/fl_chart_svc/src/utils/lerp.dart';
import 'package:servicer/MOD_PACKAGES/servicer_neumorphism/servicerNeu.dart';
import 'package:servicer/design_standards/colors.dart';
import 'package:servicer/design_standards/text_styles.dart';
import 'package:servicer/design_standards/widget_styles.dart';
import 'package:servicer/main.dart';
import 'package:servicer/main_pages/analytics_pages/shopping_mall/shopping_mall_v2.dart';
import 'package:servicer/main_pages/settings_pages/settings_main_page.dart';
import 'package:servicer/sub_widgets/mainPage_SalesStatus_barchart.dart';
import 'package:timelines/timelines.dart';
import 'package:servicer/alarm/a_main_page.dart';

import '../MOD_PACKAGES/SVSHorizontalBarChart/SVS_horizontalBarChart.dart';
import '../sample_data/getdata.dart';

//final Color _mainbgColor = pageBgColor;
Color _mainbgColor = Colors.black;

class HomePageV2 extends StatefulWidget {
  HomePageV2({Key? key}) : super(key: key);
  @override
  State<HomePageV2> createState() => _HomePageState();
}

class _HomePageState extends State<HomePageV2> {
  late ScrollController _scrollController;
  //! APPBAR HEIGHT
  double _appBarHeight = 100;
  bool _isTop = true;
  final Color _logoTopColor = Colors.indigo.shade400.withOpacity(0.8);
  final Color _logoNotTopColor = Colors.grey.shade500.withOpacity(0.7);
  //Color _appBarTopColor = pageBgColor.withOpacity(1);
  final Color _appBarTopColor = Colors.white.withOpacity(0.0);
  final Color _appBarNotTopColor = Colors.white.withOpacity(1);

  //variable of image sizes
  double _logoWidth = 149;
  double _logoHeight = 148;
  double _textWidth = 986;
  double _textHeight = 150;

  @override
  void initState() {
    //print(window.viewPadding);
    super.initState();
    _scrollController = ScrollController()..addListener(_changeAppBarColor);
  }

  void _changeAppBarColor() {
    if (_scrollController.hasClients) {
      if (_scrollController.offset > 0) {
        //NOTE when not top
        _isTop = false;
      } else {
        //NOTE when top
        // _appBarColors = Colors.white.withOpacity(0.1);
        _isTop = true;
      }

      // 상태 변경.
      setState(() {});
    }
  }

  // SECTION : APPBAR
  Widget _coolAppBar({double topPadding = 0}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 30),
      height: _appBarHeight,
      width: double.infinity,
      color: _isTop ? _appBarNotTopColor : _appBarNotTopColor,
      padding: EdgeInsets.only(left: 10),
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: topPadding),
          // SECTION 아래가 앱바 내용임
          Row(
            // crossAxisAlignment: CrossAxisAlignment.start,
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                // alignment: Alignment.centerLeft,
                /* fade between two svg images */
                child: Row(
                  children: [
                    AnimatedCrossFade(
                      firstCurve: Curves.easeOutCirc,
                      secondCurve: Curves.easeOutCirc,
                      alignment: Alignment.center,
                      duration: const Duration(milliseconds: 300),
                      //NOTE when not top
                      firstChild: SvgPicture.asset(
                        'assets/svg/logo.svg',
                        height: 25,
                        width: 25,
                        color: _logoNotTopColor,
                      ),
                      //NOTE when top
                      secondChild: SvgPicture.asset(
                        'assets/svg/logo.svg',
                        height: 25,
                        width: 25,
                        color: _logoTopColor,
                      ),
                      //crossFadeState: _isTop ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                      crossFadeState: CrossFadeState.showSecond,
                    ),
                    SizedBox(width: 5),
                    AnimatedCrossFade(
                      firstCurve: Curves.easeOutCirc,
                      secondCurve: Curves.easeOutCirc,
                      alignment: Alignment.center,
                      duration: const Duration(milliseconds: 300),
                      //NOTE when not top
                      firstChild: SvgPicture.asset(
                        'assets/svg/text.svg',
                        height: 25,
                        width: 25 / _textHeight * _textWidth,
                        color: _logoNotTopColor,
                      ),
                      //NOTE when top
                      secondChild: SvgPicture.asset(
                        'assets/svg/text.svg',
                        height: 25,
                        width: 25 / _textHeight * _textWidth,
                        color: _logoTopColor,
                      ),
                      // crossFadeState: _isTop ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                      crossFadeState: CrossFadeState.showSecond,
                    ),
                  ],
                ),
              ),
              Spacer(),
              BHTouchFXInkWell(
                $clickedColor: Colors.transparent,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AlarmMainPage()));
                },
                child: Container(
                  //height: _appBarHeight - topPadding,
                  child: Icon(
                    Icons.notifications,
                    color: Colors.grey.shade500.withOpacity(0.9),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _content({double topPadding = 0}) {
    return Scaffold(
      body: ListView(
        physics: ClampingScrollPhysics(),
        controller: _scrollController,
        children: [
          Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: _appBarHeight - topPadding),
                color: _mainbgColor,
                height: 990,
                width: double.infinity,
                child: HomePageV2Content(),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double topPadding = MediaQuery.of(context).padding.top;
    //print(_topPadding);
    return Scaffold(
      body: Stack(
        children: [
          _content(topPadding: topPadding),
          // blur clipped area: appbar
          ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
              child: _coolAppBar(topPadding: topPadding),
            ),
          ),
        ],
      ),
    );
  }
}

//* SECTION : CONTENT *// --------------------

class HomePageV2Content extends StatefulWidget {
  const HomePageV2Content({Key? key}) : super(key: key);

  @override
  State<HomePageV2Content> createState() => _HomePageV2ContentState();
}

class _HomePageV2ContentState extends State<HomePageV2Content> {
  int _index = 0;
  List<Widget> _CarouselList = [];

  @override
  void initState() {
    setState(() {
      _CarouselList.addAll([
        Container(color: Colors.red.shade100, child: Text('1'), width: double.infinity, alignment: Alignment.center),
        Container(color: Colors.green.shade100, child: Text('2'), width: double.infinity, alignment: Alignment.center),
        Container(color: Colors.blue.shade100, child: Text('3'), width: double.infinity, alignment: Alignment.center),
        Container(color: Colors.yellow.shade100, child: Text('4'), width: double.infinity, alignment: Alignment.center),
        Container(color: Colors.purple.shade100, child: Text('5'), width: double.infinity, alignment: Alignment.center),
      ]);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: pageBgColor, //! 전체 배경 색깔
      backgroundColor: pageBgColor,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              //* 중간에 잘려 있는 배경 색깔
              Container(
                // round under corners
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(41),
                    bottomRight: Radius.circular(41),
                  ),
                ),
                // width is device width
                width: MediaQuery.of(context).size.width,
                height: 170,
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15), //* 카드의 양 옆 좌우 간격
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      // SECTION 쇼핑몰 주문 현황

                      /* 카드 예시 */
                      // NeuCard(rounding:15,
                      //   child: Container(
                      //     margin: _neuCardMargin,
                      //   ),
                      // ),

                      NeuCard(
                        rounding: 15,
                        //bgColor: Colors.indigo.shade100,
                        bgColor: Colors.transparent,
                        borderlineWidth: 0,
                        borderlineOpacity: 0,
                        elevation: 0,
                        child: Stack(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(width: 10),
                                // name of seller
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        // border
                                        //border: Border.all(color: Colors.white, width: 1),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Text('VIP', style: TextStyle(color: Colors.white, fontSize: 10)),
                                    ),
                                    SizedBox(width: 5),
                                    Text('Series Seoro', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                                    Spacer(),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    Text(''),
                                    Spacer(),
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    Text('박병현', style: TextStyle(fontWeight: FontWeight.normal)),
                                    SizedBox(width: 5),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                                      decoration: BoxDecoration(
                                        color: Colors.indigo.shade300,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Text('관리자', style: TextStyle(color: Colors.white, fontSize: 10)),
                                    ),
                                    Spacer(),
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    Text('1234@seriesseoro.com', style: TextStyle(color: Colors.black)),
                                    Spacer(),
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                ),
                              ],
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              // add example chart image
                              child: Container(
                                width: 180,
                                height: 100,
                                // image
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('assets/TEST.png'),
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      NeuCard(
                        rounding: 15,
                        child: Container(
                          //height: 120,
                          width: double.infinity,
                          child: Column(
                            children: [
                              // Align(child: Text('쇼핑몰 주문 현황'), alignment: Alignment.topLeft),
                              // Padding(padding: EdgeInsets.symmetric(vertical: 6)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                            Text('결제 완료', style: TextStyle(fontSize: 11)),
                                            SizedBox(height: 2),
                                            Text('5', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text('>', style: TextStyle(fontSize: 10, color: Colors.grey)),
                                  Flexible(
                                    child: Container(
                                      width: 80,
                                      child: InkWell(
                                        onTap: () {},
                                        child: Column(
                                          children: [
                                            Icon(Icons.checklist_outlined),
                                            SizedBox(height: 6),
                                            Text('배송준비중', style: TextStyle(fontSize: 11)),
                                            SizedBox(height: 2),
                                            Text('9', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text('>', style: TextStyle(fontSize: 10, color: Colors.grey)),
                                  Flexible(
                                    child: Container(
                                      width: 80,
                                      child: InkWell(
                                        onTap: () {},
                                        child: Column(
                                          children: [
                                            Icon(Icons.warehouse),
                                            SizedBox(height: 6),
                                            Text('배송중', style: TextStyle(fontSize: 11)),
                                            SizedBox(height: 2),
                                            Text('7', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text('・・・', style: TextStyle(fontSize: 10, color: Colors.grey)),
                                  Flexible(
                                    child: Container(
                                      width: 80,
                                      child: InkWell(
                                        onTap: () {},
                                        child: Column(
                                          children: [
                                            Icon(Icons.warning),
                                            SizedBox(height: 6),
                                            Text('환불/반품 등', style: TextStyle(fontSize: 11)),
                                            SizedBox(height: 2),
                                            Text('2', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              // Padding(padding: EdgeInsets.symmetric(vertical: 4)),
                              // Stack(
                              //   alignment: Alignment.center,
                              //   children: [
                              //     Container(
                              //       height: 2,
                              //       width: double.infinity,
                              //       color: Colors.indigo[100],
                              //       margin: EdgeInsets.symmetric(horizontal: 0),
                              //     ),
                              //     Row(
                              //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                              //       children: [
                              //         Container(
                              //           width: 11,
                              //           height: 11,
                              //           decoration: BoxDecoration(
                              //               shape: BoxShape.circle,
                              //               color: Colors.white,
                              //               border: Border.all(color: Colors.indigo, width: 2)),
                              //         ),
                              //         Container(
                              //           width: 11,
                              //           height: 11,
                              //           decoration: BoxDecoration(
                              //               shape: BoxShape.circle,
                              //               color: Colors.white,
                              //               border: Border.all(color: Colors.indigo, width: 2)),
                              //         ),
                              //         Container(
                              //           width: 11,
                              //           height: 11,
                              //           decoration: BoxDecoration(
                              //               shape: BoxShape.circle,
                              //               color: Colors.white,
                              //               border: Border.all(color: Colors.indigo, width: 2)),
                              //         ),
                              //         Container(
                              //           width: 11,
                              //           height: 11,
                              //           decoration: BoxDecoration(
                              //               shape: BoxShape.circle,
                              //               color: Colors.white,
                              //               border: Border.all(color: Colors.indigo, width: 2)),
                              //         ),
                              //       ],
                              //     ),
                              //   ],
                              // ),
                            ],
                          ),
                        ),
                      ),
                      // Row(children: [
                      //   Flexible(
                      //       child: NeuCard(
                      //     rounding: 15,
                      //   )),
                      //   SizedBox(width: NeuCard.defaultSpaceBetweenCards * 2),
                      //   Flexible(
                      //       child: NeuCard(
                      //     rounding: 15,
                      //   )),
                      // ]),
                      NeuCard(
                        rounding: 15,
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('이번 주 매출', style: TextStyle(fontSize: 13)),
                                  Container(
                                    width: 200,
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text('768,700 원',
                                          style: TextStyle(fontSize: $mediumFontSize, fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                  //Spacer(),
                                  InkWell(
                                    child: const Padding(
                                      padding: EdgeInsets.all(0), //* 카드 세로 길이에 영향 주지 않는 최소 패딩값임.
                                      child: Text('바로 보기 >', style: TextStyle(fontSize: 13)),
                                    ),
                                    onTap: () {},
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      NeuCard(
                        /// SECTION 이벤트 배너
                        rounding: 15,
                        innerPadding: EdgeInsets.zero,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: CarouselSlider(
                                items: _CarouselList,
                                options: CarouselOptions(
                                  // remove left and right margin
                                  viewportFraction: 1,
                                  autoPlay: true,
                                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                                  autoPlayInterval: Duration(seconds: 5),
                                  pauseAutoPlayOnTouch: true,
                                  autoPlayCurve: Curves.easeInOutCirc,
                                  aspectRatio: 480 / 200, //* NOTE 배너 이미지 사이즈
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      _index = index;
                                    });
                                  },
                                ),
                              ),
                            ),
                            // dot indicator
                            Positioned(
                              bottom: 10,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  for (int i = 0; i < _CarouselList.length; i++)
                                    AnimatedContainer(
                                      duration: Duration(milliseconds: 300),
                                      width: 6,
                                      height: 6,
                                      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: i == _index ? Colors.white : Colors.white.withOpacity(0.4),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // SECTION 메인화면 매출요약 그래프
                      NeuCard(
                        rounding: 15,
                        child: Container(
                          padding: EdgeInsets.zero,
                          alignment: Alignment.topCenter,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Align(child: Text('쇼핑몰 주문 현황', style: TextStyle(fontSize: 13)), alignment: Alignment.topLeft),
                              Padding(padding: EdgeInsets.symmetric(vertical: 6)),
                              Container(
                                child: SVSHorizontalBarChart(data: shoppingMallExampleData, useTestMode: false),
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
// @override
// Widget build(BuildContext context) {
//   return SliverAppBar(
//     expandedHeight: 100,
//     automaticallyImplyLeading: showLeading,
//     backgroundColor: Colors.transparent,
//     pinned: true,
//     floating: false,
//     snap: false,
//     flexibleSpace: ClipRect(
//       child: BackdropFilter(
//         filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//         child: FlexibleSpaceBar(
//           titlePadding: const EdgeInsets.all(8.0),
//           title: Text(
//             'asdf',
//             style: Theme.of(context).textTheme.headline6!.copyWith(fontWeight: FontWeight.bold),
//           ),
//         ),
//       ),
//     ),
//   );
// }
