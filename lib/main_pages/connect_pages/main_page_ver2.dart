import 'package:flutter/material.dart';
import 'package:servicer/design_standards/colors.dart';
import 'package:servicer/design_standards/text_styles.dart';
import 'package:servicer/design_standards/widget_styles.dart';
import '../../servicer_modules/shopping_mall_master.dart';
import 'c_data_handler/name_switch_for_icon.dart';
import '../../MOD_PACKAGES/BH_touchFX/bh_touchfx.dart';
import 'search_page.dart';
import 'sub/Connected_Mall.dart';
import 'sub/required_info/check_client_agree.dart';

List<String> items = [
  '지그재그',
  '스마트스토어',
  '룩핀',
  '11번가',
  '쿠팡',
  '에이블리',
  '브랜디',
  '더보기'
];

double $cardMenuElevation = 25;
RoundedRectangleBorder $cardMenuShape =
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0));
EdgeInsets $cardMenuVerticalMargin =
    EdgeInsets.symmetric(horizontal: 0, vertical: 8);
EdgeInsets $cardMenuContainerMargin = EdgeInsets.all(16);

class ConnectPageV2 extends StatefulWidget {
  ConnectPageV2({Key? key}) : super(key: key);

  @override
  State<ConnectPageV2> createState() => _ConnectPageV2State();
}

class _ConnectPageV2State extends State<ConnectPageV2> with IconSwitcher {
  bool selected1 = false;
  bool selected2 = false;
  bool selected3 = false;
  bool selected4 = false;
  bool selected5 = false;
  bool selected6 = false;
  bool selected7 = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Key _appBarKey = GlobalKey();
    ScrollController _scrollController = ScrollController();
    _scrollController.addListener(() {
      //print(_scrollController.position.pixels);
    });
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 238, 238, 238),
      // SECTION 전체 페이지 스크롤 뷰
      body: SafeArea(
        top: true,
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
                  'Connect',
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
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 1.2,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            //direction: Axis.horizontal, // 나열 방향
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Text(
                                '시리즈 서로',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: $$mainColor3,
                                  fontSize: $mediumFontSize,
                                ),
                              ),
                              Text(
                                '님이 입점한 판매처',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: $mediumFontSize,
                                ),
                              ),
                              const Spacer(),
                              BHTouchFXInkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ListSearch()));
                                },
                                child: Icon(
                                  Icons.search,
                                  color: Color.fromARGB(255, 87, 85, 85),
                                  size: $bigFontSize,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    Container(
                        width: double.infinity,
                        height: 140,
                        alignment: Alignment.center,
                        child: ConnectedMall()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 1.2,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  child: const Padding(
                                    padding: EdgeInsets.all(
                                        2), //* 카드 세로 길이에 영향 주지 않는 최소 패딩값임.
                                    child: Text('더보기 >'),
                                  ),
                                  onTap: () {},
                                ),
                              ]),
                        ),
                      ),
                    ),

                    // 다른 판매처 등록하기 (Title)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 1.2,
                          child: Text(
                            '다른 판매처 등록하기',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: $mediumFontSize,
                            ),
                          ),
                        ),
                      ),
                    ),

                    // 상태 점검 필요!!!!! -> state 바뀌는 거 + 정렬 다시 + 나중에 chip 추천은 어떻게 할 것인가?
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 24,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            child: FilterChip(
                              label: Text(" #남성의류 "),
                              labelStyle: TextStyle(
                                  color:
                                      selected1 ? Colors.white : Colors.black),
                              selected: selected1,
                              onSelected: (bool value) {
                                selected1 = value;
                                setState(() {});
                              },
                              pressElevation: 4,
                              selectedColor: $$mainColor3,
                              backgroundColor: Colors.white,
                              elevation: 4,
                              showCheckmark: false,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            child: FilterChip(
                              label: Text(" #여성의류 "),
                              labelStyle: TextStyle(
                                  color:
                                      selected2 ? Colors.white : Colors.black),
                              selected: selected2,
                              onSelected: (bool value2) {
                                selected2 = value2;
                                setState(() {});
                              },
                              pressElevation: 15,
                              selectedColor: $$mainColor3,
                              backgroundColor: Colors.white,
                              elevation: 4,
                              showCheckmark: false,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            child: FilterChip(
                              label: Text(" #하계의류 "),
                              labelStyle: TextStyle(
                                  color:
                                      selected3 ? Colors.white : Colors.black),
                              selected: selected3,
                              onSelected: (bool value) {
                                selected3 = value;
                                setState(() {});
                              },
                              pressElevation: 15,
                              selectedColor: $$mainColor3,
                              backgroundColor: Colors.white,
                              elevation: 4,
                              showCheckmark: false,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            child: FilterChip(
                              label: Text(" #니트 "),
                              labelStyle: TextStyle(
                                  color:
                                      selected4 ? Colors.white : Colors.black),
                              selected: selected4,
                              onSelected: (bool value) {
                                selected4 = value;
                                setState(() {});
                              },
                              pressElevation: 15,
                              selectedColor: $$mainColor3,
                              backgroundColor: Colors.white,
                              elevation: 4,
                              showCheckmark: false,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            child: FilterChip(
                              label: Text(" #2022 트랜드 "),
                              labelStyle: TextStyle(
                                  color:
                                      selected5 ? Colors.white : Colors.black),
                              selected: selected5,
                              onSelected: (bool value) {
                                selected5 = value;
                                setState(() {});
                              },
                              pressElevation: 15,
                              selectedColor: $$mainColor3,
                              backgroundColor: Colors.white,
                              elevation: 4,
                              showCheckmark: false,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            child: FilterChip(
                              label: Text(" #여성의류 "),
                              labelStyle: TextStyle(
                                  color:
                                      selected6 ? Colors.white : Colors.black),
                              selected: selected6,
                              onSelected: (bool value) {
                                selected6 = value;
                                setState(() {});
                              },
                              pressElevation: 15,
                              selectedColor: $$mainColor3,
                              backgroundColor: Colors.white,
                              elevation: 4,
                              showCheckmark: false,
                            ),
                          ),
                          SizedBox(
                            width: 24,
                          ),
                        ],
                      ),
                    ),

                    // SECTION 판매처 연결 추천 Grid
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: items.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 6,
                          mainAxisSpacing: 6,
                          crossAxisCount:
                              (MediaQuery.of(context).size.width ~/ 160),
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            elevation:
                                $cardMenuElevation - 20, // card elevation = 25
                            shape: $cardMenuShape,
                            margin: $cardMenuContainerMargin / 2,
                            child: SizedBox(
                              // height: MediaQuery.of(context).size.height >
                              //         MediaQuery.of(context).size.width
                              //     ? MediaQuery.of(context).size.width * 0.36
                              //     : MediaQuery.of(context).size.height * 0.36,
                              // width: 120,
                              child: BHTouchFXInkWell(
                                  onTap: () => showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                          title: Text(items[index]),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: SizedBox(
                                                  child: iconSwitcher(
                                                      items[index]),
                                                  width: 60,
                                                  height: 60,
                                                ),
                                              ),
                                              Text(
                                                  '${items[index]} 연동을 계속 진행하시겠습니까?'),
                                            ],
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      
                                                        builder: (context) =>
                                                            AgreementCheckPage(
                                                                mallName: items[
                                                                    index])));
                                              },
                                              child: const Text('연동'),
                                            ),
                                            TextButton(
                                              onPressed: () => Navigator.pop(
                                                  context, 'Cancel'),
                                              child: const Text('취소'),
                                            ),
                                          ],
                                        ),
                                      ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          height: 1,
                                        ),
                                        flex: 2,
                                      ),
                                      Expanded(
                                          child: SizedBox(
                                            child: iconSwitcher(items[index]),
                                            width: 75,
                                            height: 75,
                                          ),
                                          flex: 8),
                                      Expanded(
                                        child: Container(
                                          height: 1,
                                        ),
                                        flex: 1,
                                      ),
                                      Expanded(
                                          child: FittedBox(
                                              fit: BoxFit.scaleDown,
                                              alignment: Alignment.center,
                                              child: Text(
                                                items[index],
                                                softWrap: true,
                                              )),
                                          flex: 4),
                                      Expanded(
                                        child: Container(
                                          height: 1,
                                        ),
                                        flex: 2,
                                      ),
                                    ],
                                  )),
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 20)),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
