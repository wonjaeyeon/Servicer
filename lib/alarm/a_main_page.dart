import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:servicer/MOD_PACKAGES/BH_touchFX/bh_touchfx.dart';

import 'package:servicer/design_standards/colors.dart';
import 'package:servicer/design_standards/text_styles.dart';
import 'package:servicer/design_standards/widget_styles.dart';
import 'package:servicer/sub_widgets/mainPage_SalesStatus_barchart.dart';

import 'sub/alarm_category.dart';
import 'sub/alarm_date_ver3.dart';

class AlarmMainPage extends StatefulWidget {
  AlarmMainPage({Key? key}) : super(key: key);

  @override
  State<AlarmMainPage> createState() => _AlarmMainPageState();
}

class _AlarmMainPageState extends State<AlarmMainPage> {
  List<dynamic> questions = [
    ["쿠팡", "안녕하세요 질문입니다"],
    ["쿠팡", "안녕하세요 질문입니다"],
    ["쿠팡", "안녕하세요 질문입니다"],
    ["쿠팡", "안녕하세요 질문입니다"],
    ["쿠팡", "안녕하세요 질문입니다"],
    ["쿠팡", "안녕하세요 질문입니다"],
    ["쿠팡", "안녕하세요 질문입니다"],
    ["쿠팡", "안녕하세요 질문입니다"],
    ["쿠팡", "안녕하세요 질문입니다"],
    ["쿠팡", "안녕하세요 질문입니다"],
    ["쿠팡", "안녕하세요 질문입니다"],
    ["쿠팡", "안녕하세요 질문입니다"],
  ];
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  // 우선 오류를 줄이기 위해 Scaffold사용 but 일반적인 화면 구성 방식과는 차이가 있다.
  @override
  Widget build(BuildContext context) {
    final double _verticalPadding = 15;
    final double _horizontalPadding = 15;
    Key _appBarKey = GlobalKey();
    ScrollController _scrollController = ScrollController();
    // _scrollController.addListener(() {
    //   //print(_scrollController.position.pixels);
    // });

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 238, 238, 238),
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
        child: CustomScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              key: _appBarKey,
              backgroundColor: Color.fromARGB(255, 238, 238, 238),
              expandedHeight: 90,
              collapsedHeight: 50,
              toolbarHeight: 50,
              surfaceTintColor: Colors.blue,
              elevation: 2,
              shadowColor: Colors.black,
              flexibleSpace: const FlexibleSpaceBar(
                centerTitle: true,
                title: Text(
                  'Alarm',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
              leading: IconButton(
                iconSize: $bigFontSize,
                icon: const Icon(
                  Icons.arrow_back_ios_rounded,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              automaticallyImplyLeading: true,
              floating: false,
              snap: false,
              pinned: true,

              stretch: false, //* 앱바 늘어나는 효과는 이걸 true로...)
            ),
            SliverToBoxAdapter(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: _horizontalPadding),
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: _verticalPadding),
                      AspectRatio(
                        aspectRatio: 7.0,
                        child: Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: BHTouchFXInkWell(
                            child: Row(
                              children: [
                                SizedBox(width: 10),
                                Flexible(flex: 2, child: Icon(Icons.campaign)),
                                SizedBox(width: 10),
                                Flexible(flex: 3, child: Text('서비서 공지사항')),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "알림",
                          style: TextStyle(
                              fontSize: $bigFontSize,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      ACategory(),
                      // Badge(
                      //   badgeContent: Text(
                      //     "3",
                      //     style: TextStyle(color: Colors.white),
                      //   ),
                      //   child: Icon(Icons.notifications),
                      // ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "새 알림",
                          style: TextStyle(
                              fontSize: $bigFontSize,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      // ListView.builder(
                      //     shrinkWrap: true,
                      //     physics: const NeverScrollableScrollPhysics(),
                      //     scrollDirection: Axis.vertical,
                      //     itemCount: questions.length,
                      //     itemBuilder: (BuildContext context, int index) {
                      //       return Card(
                      //         shape: RoundedRectangleBorder(
                      //             borderRadius: BorderRadius.circular(10)),
                      //         child: BHTouchFXListTile(
                      //           leading: Icon(Icons.question_answer),
                      //           title: Text(questions[index][0]),
                      //           subtitle: Text(questions[index][1]),
                      //           trailing: Icon(Icons.more_vert),
                      //           isThreeLine: true,
                      //           //dense: true,
                      //         ),
                      //       );
                      //     }),
                      // Column(
                      //   children: [
                      //     Card(
                      //       shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(10)),
                      //       child: BHTouchFXListTile(
                      //         leading: Icon(Icons.question_answer),
                      //         title: Text("a"),
                      //         subtitle: Text("b"),
                      //         trailing: Icon(Icons.more_vert),
                      //         isThreeLine: true,
                      //         //dense: true,
                      //       ),
                      //     ),

                      //     Card(
                      //       shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(10)),
                      //       child: BHTouchFXListTile(
                      //         leading: Icon(Icons.question_answer),
                      //         title: Text("a"),
                      //         subtitle: Text("b"),
                      //         trailing: Icon(Icons.more_vert),
                      //         isThreeLine: true,
                      //         //dense: true,
                      //       ),
                      //     ),
                      //     Card(
                      //       shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(10)),
                      //       child: BHTouchFXListTile(
                      //         leading: Icon(Icons.question_answer),
                      //         title: Text("a"),
                      //         subtitle: Text("b"),
                      //         trailing: Icon(Icons.more_vert),
                      //         isThreeLine: true,
                      //         //dense: true,
                      //       ),
                      //     ),
                      //   ],
                      // )
                      ADateV3(),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
