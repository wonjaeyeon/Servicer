import 'package:async/async.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:servicer/main_pages/analytics_pages/new_main.dart';
import '../../connect_pages/sub/unused/main_page_ver1.dart';
import 'package:servicer/servicer_modules/shopping_mall_master.dart';
import 'package:timelines/timelines.dart';

import '../../start_page.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';

class ShoppingMallAnalyticsPageV2 extends StatefulWidget {
  ShoppingMallAnalyticsPageV2({Key? key}) : super(key: key);

  @override
  State<ShoppingMallAnalyticsPageV2> createState() =>
      _ShoppingMallAnalyticsPageV2State();
}

List _shoppingMallList = [];
Enum? _selectedMall = null;

class _ShoppingMallAnalyticsPageV2State
    extends State<ShoppingMallAnalyticsPageV2> {
  ScrollController _scrollController = ScrollController();
  double _offset = 0.0;

  @override
  void initState() {
    _shoppingMallList = [
      Mall.Ably,
      Mall.NaverSmartStore,
      Mall.Coupang,
      Mall.Zigzag,
      Mall.Brandi,
    ];

    // subscribe to scroll events
    _scrollController.addListener(() {
      setState(() {
        _offset = _scrollController.offset;
        print(_scrollController.offset);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBgColor,
      // make sliver app bar
      body: CustomScrollView(
        controller: _scrollController,
        physics: const ClampingScrollPhysics(),
        slivers: [
          SliverAppBar(
            backgroundColor: pageBgColor,
            // expandedHeight: 100,
            // collapsedHeight: 100,
            // toolbarHeight: 100,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text('판매처 분석',
                  style: TextStyle(color: Colors.black),
                  textAlign: TextAlign.center),
            ),
            automaticallyImplyLeading: true,
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            floating: true,
            snap: true,
            pinned: true,
            shadowColor: Colors.black,
            elevation: 0,
            stretch: false, //* 앱바 늘어나는 효과는 이걸 true로.
          ),
          SliverAppBar(
            expandedHeight: (_offset > 120) ? 00 : (120 - _offset),
            collapsedHeight: 0,
            toolbarHeight: 0,
            //! FIXME !
            //! FIXME !
            //! FIXME ! 그림자가 아래쪽 슬리버앱바에서만 나오도록 해야함. 그거를 아래쪽 슬리버앱바가
            //! FIXME ! 다 늘어나는 걸 기준으로 가변으로 만들면 좋을거같은데 준내 어렵다.
            //! FIXME !
            backgroundColor: pageBgColor,
            automaticallyImplyLeading: false,
            flexibleSpace: ClipRect(
              child: OverflowBox(
                alignment: Alignment.bottomCenter,
                maxWidth: double.infinity,
                maxHeight: double.infinity,
                child: FittedBox(
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                  child: Container(
                    // NOTE HORIZONTAL PADDING
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    width: MediaQuery.of(context).size.width,
                    // height: 0,
                    child: Center(
                      child: OrderTimeLine2(),
                    ),
                  ),
                ),
              ),
            ),
            floating: true,
            snap: true,
            pinned: true,
            shadowColor: Colors.black,
            elevation: 0,
            stretch: false, //* 앱바 늘어나는 효과는 이걸 true로.
          ),
          SliverAppBar(
            expandedHeight: 20,
            collapsedHeight: 20,
            toolbarHeight: 20,
            // backgroundColor: Colors.grey,
            backgroundColor: pageBgColor,
            automaticallyImplyLeading: false,
            flexibleSpace: Container(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Builder(builder: (context) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('선택한 판매처:', style: TextStyle(fontSize: 15)),
                          SizedBox(width: 10),
                          InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                backgroundColor: pageBgColor,
                                builder: (context) {
                                  return Container(
                                    height: 1500,
                                    padding: const EdgeInsets.all(28.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        // make a title
                                        Container(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('판매처 선택',
                                                  style:
                                                      TextStyle(fontSize: 20)),
                                              InkWell(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Icon(Icons.close),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Flexible(
                                          // listview builder with multiple shopping malls
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount:
                                                _shoppingMallList.length + 1,
                                            itemBuilder: (context, index) {
                                              return SizedBox(
                                                height: 70,
                                                child: (index == 0)
                                                    ? InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            _selectedMall =
                                                                null;
                                                          });
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Row(
                                                          children: [
                                                            SizedBox(
                                                                child: Icon(Icons
                                                                    .stacked_bar_chart),
                                                                width: 45,
                                                                height: 45),
                                                            SizedBox(width: 20),
                                                            Text('전체',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15)),
                                                            Spacer(),
                                                            (_selectedMall ==
                                                                    null)
                                                                ? Icon(
                                                                    Icons.check)
                                                                : SizedBox(),
                                                          ],
                                                        ),
                                                      )
                                                    : InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            _selectedMall =
                                                                _shoppingMallList[
                                                                    index - 1];
                                                          });
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Row(
                                                          children: [
                                                            SizedBox(
                                                                child: mallMaster
                                                                    .smallImgOf(
                                                                        _shoppingMallList[index -
                                                                            1]),
                                                                width: 45,
                                                                height: 45),
                                                            SizedBox(width: 20),
                                                            Text(
                                                                mallMaster.textOf(
                                                                    _shoppingMallList[
                                                                        index -
                                                                            1]),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15)),
                                                            Spacer(),
                                                            (_selectedMall ==
                                                                    _shoppingMallList[
                                                                        index -
                                                                            1])
                                                                ? Icon(
                                                                    Icons.check)
                                                                : SizedBox(),
                                                          ],
                                                        ),
                                                      ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            child: Row(
                              children: [
                                Text(
                                    (_selectedMall == null
                                        ? '전체'
                                        : mallMaster.textOf(_selectedMall!)),
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                                Icon(Icons.keyboard_arrow_down_rounded,
                                    size: 20),
                              ],
                            ),
                          ),
                        ],
                      );
                    }),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('기간:', style: TextStyle(fontSize: 15)),
                        SizedBox(width: 10),
                        InkWell(
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Container(
                                    height: 250,
                                    alignment: Alignment.topLeft,
                                    margin: EdgeInsets.only(
                                        top: 20, left: 20, right: 20),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text('기간 선택',
                                                style: TextStyle(fontSize: 20)),
                                            Spacer(),
                                            InkWell(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              child: Icon(Icons.close),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 20),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text('시작일',
                                                      style: TextStyle(
                                                          fontSize: 15)),
                                                  Container(
                                                    //color: Colors.blue,
                                                    height: 100,
                                                    child: ScrollDatePicker(
                                                      scrollViewOptions:
                                                          DatePickerScrollViewOptions(
                                                        year:
                                                            ScrollViewDetailOptions(
                                                          textStyle: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                          selectedTextStyle:
                                                              TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                          label: '년',
                                                          margin:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 0,
                                                                  left: 12),
                                                        ),
                                                        month:
                                                            ScrollViewDetailOptions(
                                                          textStyle: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                          selectedTextStyle:
                                                              TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                          label: '월',
                                                          margin:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 0),
                                                        ),
                                                        day:
                                                            ScrollViewDetailOptions(
                                                          textStyle: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                          selectedTextStyle:
                                                              TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                          label: '일',
                                                          margin:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 0),
                                                        ),
                                                      ),
                                                      selectedDate:
                                                          DateTime.now(),
                                                      locale:
                                                          Locale.fromSubtags(
                                                              languageCode:
                                                                  'ko'),
                                                      options:
                                                          DatePickerOptions(
                                                              isLoop: false),
                                                      onDateTimeChanged:
                                                          (value) {},
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Column(
                                              children: [
                                                Text(''),
                                                Text('~',
                                                    style: TextStyle(
                                                        fontSize: 20)),
                                              ],
                                            ),
                                            SizedBox(width: 10),
                                            Expanded(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text('종료일',
                                                      style: TextStyle(
                                                          fontSize: 15)),
                                                  Container(
                                                    //color: Colors.red,
                                                    height: 100,
                                                    child: ScrollDatePicker(
                                                      scrollViewOptions:
                                                          DatePickerScrollViewOptions(
                                                        year:
                                                            ScrollViewDetailOptions(
                                                          textStyle: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                          selectedTextStyle:
                                                              TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                          label: '년',
                                                          margin:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 0,
                                                                  left: 12),
                                                        ),
                                                        month:
                                                            ScrollViewDetailOptions(
                                                          textStyle: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                          selectedTextStyle:
                                                              TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                          label: '월',
                                                          margin:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 0),
                                                        ),
                                                        day:
                                                            ScrollViewDetailOptions(
                                                          textStyle: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                          selectedTextStyle:
                                                              TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                          label: '일',
                                                          margin:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 0),
                                                        ),
                                                      ),
                                                      selectedDate:
                                                          DateTime.now(),
                                                      locale:
                                                          Locale.fromSubtags(
                                                              languageCode:
                                                                  'ko'),
                                                      options:
                                                          DatePickerOptions(
                                                              isLoop: false),
                                                      onDateTimeChanged:
                                                          (value) {},
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        // apply button
                                        SizedBox(height: 10),
                                        // bottom button with max width
                                        Flexible(
                                          child: Container(
                                            height: 40,
                                            width: double.infinity,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text('적용',
                                                  style:
                                                      TextStyle(fontSize: 15)),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                });
                          },
                          child: Row(
                            children: [
                              Text('2021.01.01 ~ 2021.01.31',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                              Icon(Icons.keyboard_arrow_down_rounded, size: 20),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            floating: false,
            snap: false,
            pinned: true,
            shadowColor: Colors.black,
            elevation: 0,
            stretch: false, //* 앱바 늘어나는 효과는 이걸 true로.
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              addSemanticIndexes: true,
              [
                Container(
                  child: Center(
                    child: Text('요약',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  color: pageBgColor,
                  height: 123,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              '주문 및 결제 현황',
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  color: pageBgColor,
                  height: 123,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              '최근 주문',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  height: 400,
                  color: Colors.green,
                ),
                Container(
                  height: 500,
                  color: Colors.yellow,
                ),
                Container(
                  height: 400,
                  color: Colors.purple,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OrderTimeLine2 extends StatelessWidget {
  OrderTimeLine2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0),
      padding: EdgeInsets.symmetric(vertical: 16),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                '주문 및 결제 현황',
                style: TextStyle(fontSize: 15),
              ),
            ),
          ),
          SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Icon(Icons.featured_play_list_sharp),
                  SizedBox(height: 4),
                  Text('결제 대기'),
                  Text('4',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              Container(width: 1, height: 100, color: Colors.grey),
              Column(
                children: [
                  Icon(Icons.checklist),
                  SizedBox(height: 4),
                  Text('결제 완료'),
                  Text('32',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              Container(width: 1, height: 100, color: Colors.grey),
              Column(
                children: [
                  Icon(Icons.warehouse),
                  SizedBox(height: 4),
                  Text('상품 준비'),
                  Text('101',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
        ],
      ),
    );
  }
}

class OrderTimeLine extends StatelessWidget {
  OrderTimeLine({Key? key}) : super(key: key);
  double _bigRadius = 40;
  double _timeLineThickness = 4;
  double _dotBorderWidth = 4;

  @override
  Widget build(BuildContext context) {
    Widget dot({Icon? icon, Widget? upperWidget}) => Column(
          children: [
            Column(
              children: [
                (upperWidget == null) ? Container() : upperWidget,
                SizedBox(height: 4),
                Container(
                  alignment: Alignment.center,
                  width: _bigRadius,
                  height: _bigRadius,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border:
                        Border.all(color: Colors.black, width: _dotBorderWidth),
                  ),
                  child: icon ?? Container(),
                ),
              ],
            ),
          ],
        );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Center(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: (_bigRadius + _timeLineThickness) / 2,
                    vertical: (_bigRadius - _timeLineThickness) / 2,
                  ),
                  height: _timeLineThickness,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    // black border at only top and bottom
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // dot(),
                    // dot(),
                    // dot(),
                    dot(
                        icon: Icon(Icons.featured_play_list_outlined),
                        upperWidget: Column(
                          children: [
                            Text('결제 대기'),
                            Text('4', style: TextStyle(fontSize: 20)),
                          ],
                        )),
                    dot(
                        icon: Icon(Icons.checklist),
                        upperWidget: Column(
                          children: [
                            Text('결제 완료'),
                            Text('32', style: TextStyle(fontSize: 20)),
                          ],
                        )),
                    dot(
                        icon: Icon(Icons.warehouse),
                        upperWidget: Column(
                          children: [
                            Text('배송 준비'),
                            Text('101', style: TextStyle(fontSize: 20)),
                          ],
                        )),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
