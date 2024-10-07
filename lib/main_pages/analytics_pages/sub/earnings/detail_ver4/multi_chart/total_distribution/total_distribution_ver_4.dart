import 'package:flutter/material.dart';
import 'package:servicer/design_standards/colors.dart';

import '../../../../../../../data_handler/data_standards/time.dart';
import '../../../../../../../design_standards/text_styles.dart';
import '../../../../../../../design_standards/widget_styles.dart';
import '../../../../bottomsheet.dart';
import '../../../abstract_class/abstractChart.dart';
import 'sub/chart/waterfall_chart.dart';
import 'td_data_handler/y_axis_unit.dart';

class EarningsDistributionChartV4 extends StatefulWidget {
  const EarningsDistributionChartV4({super.key});

  @override
  State<EarningsDistributionChartV4> createState() =>
      _EarningsDistributionChartV4State();
}

class _EarningsDistributionChartV4State
    extends State<EarningsDistributionChartV4> with TDChartYAxisUnit {
  late Time time;
  List<bool> _isSelectedTime = [true, false, false, false, false, false];
  // AnimatedOpacity를 위한 변수
  bool _visible = true;

  @override
  void initState() {
    time = Time.day;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double unityWidth = MediaQuery.of(context).size.width / 7;
    double unityHeight = 40;
    double headerHeight = 32;

    // 2 unity = two rows or columns merge
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: TimeClickerV2(
                isSelectedTime: _isSelectedTime,
                callbackFunction: callbackFunction,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            //현재 그래프 기간
            Align(
              alignment: Alignment.topLeft,
              child: Text(getTimeRange(time),
                  style: TextStyle(fontSize: $mediumFontSize - 2)),
            ),
            const SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                '매출 상세 분포',
                style: TextStyle(fontSize: $mediumFontSize - 2),
              ),
            ),
            WaterfallSubChartContainer(
              time: time,
              width: MediaQuery.of(context).size.width,
            ),
            
            const SizedBox(height: 4),
            Table(
              columnWidths: {
                0: FlexColumnWidth(1),
                1: FlexColumnWidth(1),
                2: FlexColumnWidth(2),
              },
              defaultColumnWidth: FlexColumnWidth(1),
              textDirection: TextDirection.ltr,
              border: TableBorder.all(width: 0.3),
              children: [
                TableRow(children: [
                  Container(
                    height: headerHeight,
                    color: $$lightGrey,
                    alignment: Alignment.center,
                    child: Text("항목",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'IBMPlexSansKR')),
                  ),
                  Container(
                      height: headerHeight,
                      color: $$lightGrey,
                      alignment: Alignment.center,
                      child: Text("상세항목",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'IBMPlexSansKR'))),
                  Container(
                    height: headerHeight,
                    color: $$lightGrey,
                    alignment: Alignment.center,
                    child: Text("금액",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'IBMPlexSansKR')),
                  ),
                ]),
                //NOTE first row - 카드 결제 매출 추이
                TableRow(
                    decoration: BoxDecoration(
                        border: Border(
                      bottom: BorderSide(
                        color: Colors.black,
                        width: 0.6,
                      ),
                    )),
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: $$lightGrey,
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.black,
                                width: 0.6,
                              ),
                            )),
                        height: unityHeight * 3,
                        alignment: Alignment.center,
                        child: Text("카드 결제 매출",
                            style: TextStyle(fontFamily: 'IBMPlexSansKR')),
                      ),
                      Column(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom: BorderSide(
                                  color: Colors.black,
                                  width: 0.3,
                                ),
                              )),
                              height: unityHeight,
                              //color: Colors.white,
                              alignment: Alignment.center,
                              child: Text("영업 매출",
                                  style:
                                      TextStyle(fontFamily: 'IBMPlexSansKR'))),
                          Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom: BorderSide(
                                  color: Colors.black,
                                  width: 0.3,
                                ),
                              )),
                              height: unityHeight,
                              //color: Colors.white,
                              alignment: Alignment.center,
                              child: Text("반품 매출",
                                  style:
                                      TextStyle(fontFamily: 'IBMPlexSansKR'))),
                          Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom: BorderSide(
                                  color: Colors.black,
                                  width: 0.3,
                                ),
                              )),
                              height: unityHeight,
                              //color: Colors.white,
                              alignment: Alignment.center,
                              child: Text("총매출",
                                  style:
                                      TextStyle(fontFamily: 'IBMPlexSansKR'))),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom: BorderSide(
                                  color: Colors.black,
                                  width: 0.3,
                                ),
                              )),
                              height: unityHeight,
                              //color: Colors.white,
                              alignment: Alignment.center,
                              child: Text("256,000원",
                                  style:
                                      TextStyle(fontFamily: 'IBMPlexSansKR'))),
                          Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom: BorderSide(
                                  color: Colors.black,
                                  width: 0.3,
                                ),
                              )),
                              height: unityHeight,
                              //color: Colors.white,
                              alignment: Alignment.center,
                              child: Text("-50,000원",
                                  style:
                                      TextStyle(fontFamily: 'IBMPlexSansKR'))),
                          Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom: BorderSide(
                                  color: Colors.black,
                                  width: 0.3,
                                ),
                              )),
                              height: unityHeight,
                              //color: Colors.white,
                              alignment: Alignment.center,
                              child: Text("206,000원",
                                  style:
                                      TextStyle(fontFamily: 'IBMPlexSansKR'))),
                        ],
                      ),
                    ]),
                //NOTE second row - 현금 매출
                TableRow(
                    decoration: BoxDecoration(
                        border: Border(
                      bottom: BorderSide(
                        color: Colors.black,
                        width: 0.6,
                      ),
                    )),
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: $$lightGrey,
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.black,
                                width: 0.6,
                              ),
                            )),
                        height: unityHeight * 3,
                        alignment: Alignment.center,
                        child: Text("현금 결제 매출",
                            style: TextStyle(fontFamily: 'IBMPlexSansKR')),
                      ),
                      Column(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom: BorderSide(
                                  color: Colors.black,
                                  width: 0.3,
                                ),
                              )),
                              height: unityHeight,
                              //color: Colors.white,
                              alignment: Alignment.center,
                              child: Text("영업 매출",
                                  style:
                                      TextStyle(fontFamily: 'IBMPlexSansKR'))),
                          Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom: BorderSide(
                                  color: Colors.black,
                                  width: 0.3,
                                ),
                              )),
                              height: unityHeight,
                              //color: Colors.white,
                              alignment: Alignment.center,
                              child: Text("반품 매출",
                                  style:
                                      TextStyle(fontFamily: 'IBMPlexSansKR'))),
                          Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom: BorderSide(
                                  color: Colors.black,
                                  width: 0.3,
                                ),
                              )),
                              height: unityHeight,
                              //color: Colors.white,
                              alignment: Alignment.center,
                              child: Text("총매출",
                                  style:
                                      TextStyle(fontFamily: 'IBMPlexSansKR'))),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom: BorderSide(
                                  color: Colors.black,
                                  width: 0.3,
                                ),
                              )),
                              height: unityHeight,
                              //color: Colors.white,
                              alignment: Alignment.center,
                              child: Text("100,000원",
                                  style:
                                      TextStyle(fontFamily: 'IBMPlexSansKR'))),
                          Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom: BorderSide(
                                  color: Colors.black,
                                  width: 0.3,
                                ),
                              )),
                              height: unityHeight,
                              //color: Colors.white,
                              alignment: Alignment.center,
                              child: Text("0원",
                                  style:
                                      TextStyle(fontFamily: 'IBMPlexSansKR'))),
                          Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom: BorderSide(
                                  color: Colors.black,
                                  width: 0.3,
                                ),
                              )),
                              height: unityHeight,
                              //color: Colors.white,
                              alignment: Alignment.center,
                              child: Text("100,000원",
                                  style:
                                      TextStyle(fontFamily: 'IBMPlexSansKR'))),
                        ],
                      ),
                    ]),
                //NOTE third row - 매입
                TableRow(
                    decoration: BoxDecoration(
                        border: Border(
                      bottom: BorderSide(
                        color: Colors.black,
                        width: 0.6,
                      ),
                    )),
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: $$lightGrey,
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.black,
                                width: 0.6,
                              ),
                            )),
                        height: unityHeight * 3,
                        alignment: Alignment.center,
                        child: Text("매입",
                            style: TextStyle(fontFamily: 'IBMPlexSansKR')),
                      ),
                      Column(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom: BorderSide(
                                  color: Colors.black,
                                  width: 0.3,
                                ),
                              )),
                              height: unityHeight,
                              //color: Colors.white,
                              alignment: Alignment.center,
                              child: Text("신고 매입",
                                  style:
                                      TextStyle(fontFamily: 'IBMPlexSansKR'))),
                          Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom: BorderSide(
                                  color: Colors.black,
                                  width: 0.3,
                                ),
                              )),
                              height: unityHeight,
                              //color: Colors.white,
                              alignment: Alignment.center,
                              child: Text("미신고 매입",
                                  style:
                                      TextStyle(fontFamily: 'IBMPlexSansKR'))),
                          Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom: BorderSide(
                                  color: Colors.black,
                                  width: 0.3,
                                ),
                              )),
                              height: unityHeight,
                              //color: Colors.white,
                              alignment: Alignment.center,
                              child: Text("총 매입",
                                  style:
                                      TextStyle(fontFamily: 'IBMPlexSansKR'))),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom: BorderSide(
                                  color: Colors.black,
                                  width: 0.3,
                                ),
                              )),
                              height: unityHeight,
                              //color: Colors.white,
                              alignment: Alignment.center,
                              child: Text("100,000원",
                                  style:
                                      TextStyle(fontFamily: 'IBMPlexSansKR'))),
                          Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom: BorderSide(
                                  color: Colors.black,
                                  width: 0.3,
                                ),
                              )),
                              height: unityHeight,
                              //color: Colors.white,
                              alignment: Alignment.center,
                              child: Text("0원",
                                  style:
                                      TextStyle(fontFamily: 'IBMPlexSansKR'))),
                          Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom: BorderSide(
                                  color: Colors.black,
                                  width: 0.3,
                                ),
                              )),
                              height: unityHeight,
                              //color: Colors.white,
                              alignment: Alignment.center,
                              child: Text("100,000원",
                                  style:
                                      TextStyle(fontFamily: 'IBMPlexSansKR'))),
                        ],
                      ),
                    ]),
                //NOTE fourth row - 매출 세금
                TableRow(
                    decoration: BoxDecoration(
                        border: Border(
                      bottom: BorderSide(
                        color: Colors.black,
                        width: 0.6,
                      ),
                    )),
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: $$lightGrey,
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.black,
                                width: 0.6,
                              ),
                            )),
                        height: unityHeight * 7,
                        alignment: Alignment.center,
                        child: Text("매출 세금",
                            style: TextStyle(fontFamily: 'IBMPlexSansKR')),
                      ),
                      Column(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom: BorderSide(
                                  color: Colors.black,
                                  width: 0.3,
                                ),
                              )),
                              height: unityHeight,
                              //color: Colors.white,
                              alignment: Alignment.center,
                              child: Text("PG사",
                                  style:
                                      TextStyle(fontFamily: 'IBMPlexSansKR'))),
                          Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom: BorderSide(
                                  color: Colors.black,
                                  width: 0.3,
                                ),
                              )),
                              height: unityHeight,
                              //color: Colors.white,
                              alignment: Alignment.center,
                              child: Text("카드 결제",
                                  style:
                                      TextStyle(fontFamily: 'IBMPlexSansKR'))),
                          Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom: BorderSide(
                                  color: Colors.black,
                                  width: 0.3,
                                ),
                              )),
                              height: unityHeight,
                              //color: Colors.white,
                              alignment: Alignment.center,
                              child: Text("가상계좌",
                                  style:
                                      TextStyle(fontFamily: 'IBMPlexSansKR'))),
                          Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom: BorderSide(
                                  color: Colors.black,
                                  width: 0.3,
                                ),
                              )),
                              height: unityHeight,
                              //color: Colors.white,
                              alignment: Alignment.center,
                              child: Text("실시간 계좌 이체",
                                  style:
                                      TextStyle(fontFamily: 'IBMPlexSansKR'))),
                          Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom: BorderSide(
                                  color: Colors.black,
                                  width: 0.3,
                                ),
                              )),
                              height: unityHeight,
                              //color: Colors.white,
                              alignment: Alignment.center,
                              child: Text("휴대폰 결제",
                                  style:
                                      TextStyle(fontFamily: 'IBMPlexSansKR'))),
                          Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom: BorderSide(
                                  color: Colors.black,
                                  width: 0.3,
                                ),
                              )),
                              height: unityHeight,
                              //color: Colors.white,
                              alignment: Alignment.center,
                              child: Text("상품 부가세",
                                  style:
                                      TextStyle(fontFamily: 'IBMPlexSansKR'))),
                          Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom: BorderSide(
                                  color: Colors.black,
                                  width: 0.3,
                                ),
                              )),
                              height: unityHeight,
                              //color: Colors.white,
                              alignment: Alignment.center,
                              child: Text("총 세액",
                                  style:
                                      TextStyle(fontFamily: 'IBMPlexSansKR'))),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom: BorderSide(
                                  color: Colors.black,
                                  width: 0.3,
                                ),
                              )),
                              height: unityHeight,
                              //color: Colors.white,
                              alignment: Alignment.center,
                              child: Text("KCP",
                                  style:
                                      TextStyle(fontFamily: 'IBMPlexSansKR'))),
                          Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom: BorderSide(
                                  color: Colors.black,
                                  width: 0.3,
                                ),
                              )),
                              height: unityHeight,
                              //color: Colors.white,
                              alignment: Alignment.center,
                              child: Text("-5,000원",
                                  style:
                                      TextStyle(fontFamily: 'IBMPlexSansKR'))),
                          Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom: BorderSide(
                                  color: Colors.black,
                                  width: 0.3,
                                ),
                              )),
                              height: unityHeight,
                              //color: Colors.white,
                              alignment: Alignment.center,
                              child: Text("0원",
                                  style:
                                      TextStyle(fontFamily: 'IBMPlexSansKR'))),
                          Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom: BorderSide(
                                  color: Colors.black,
                                  width: 0.3,
                                ),
                              )),
                              height: unityHeight,
                              //color: Colors.white,
                              alignment: Alignment.center,
                              child: Text("-500원",
                                  style:
                                      TextStyle(fontFamily: 'IBMPlexSansKR'))),
                          Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom: BorderSide(
                                  color: Colors.black,
                                  width: 0.3,
                                ),
                              )),
                              height: unityHeight,
                              alignment: Alignment.center,
                              child: Text("-500원",
                                  style:
                                      TextStyle(fontFamily: 'IBMPlexSansKR'))),
                          Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom: BorderSide(
                                  color: Colors.black,
                                  width: 0.3,
                                ),
                              )),
                              height: unityHeight,
                              //color: Colors.white,
                              alignment: Alignment.center,
                              child: Text("-6,000원",
                                  style:
                                      TextStyle(fontFamily: 'IBMPlexSansKR'))),
                          Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom: BorderSide(
                                  color: Colors.black,
                                  width: 0.3,
                                ),
                              )),
                              height: unityHeight,
                              alignment: Alignment.center,
                              child: Text("-12,000원",
                                  style:
                                      TextStyle(fontFamily: 'IBMPlexSansKR'))),
                        ],
                      ),
                    ]),
                //NOTE second row - 현금 매출
                TableRow(
                    decoration: BoxDecoration(
                        border: Border(
                      bottom: BorderSide(
                        color: Colors.black,
                        width: 0.6,
                      ),
                    )),
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: $$lightGrey,
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.black,
                                width: 0.6,
                              ),
                            )),
                        height: unityHeight * 1,
                        alignment: Alignment.center,
                        child: Text("수익",
                            style: TextStyle(fontFamily: 'IBMPlexSansKR')),
                      ),
                      Column(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom: BorderSide(
                                  color: Colors.black,
                                  width: 0.3,
                                ),
                              )),
                              height: unityHeight,
                              //color: Colors.white,
                              alignment: Alignment.center,
                              child: Text("총수익",
                                  style:
                                      TextStyle(fontFamily: 'IBMPlexSansKR'))),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom: BorderSide(
                                  color: Colors.black,
                                  width: 0.3,
                                ),
                              )),
                              height: unityHeight,
                              //color: Colors.white,
                              alignment: Alignment.center,
                              child: Text("194,000원",
                                  style:
                                      TextStyle(fontFamily: 'IBMPlexSansKR'))),
                        ],
                      ),
                    ]),
              ],
            ),
          ],
        ));
  }

  Future<void> callbackFunction(int newIndex) async {
    setState(() {
      //_visible = false;
      for (int i = 0; i < _isSelectedTime.length; i++) {
        if (i == newIndex) {
          _isSelectedTime[i] = true;
        } else {
          _isSelectedTime[i] = false;
          switch (newIndex) {
            case 0:
              //sleep(Duration(milliseconds: 50));
              time = Time.day;
              break;
            case 1:
              time = Time.week;
              break;
            case 2:
              time = Time.month;
              break;
            case 3:
              time = Time.year;
              break;
            case 4:
              time = Time.all;
              break;
            case 5:
              break;
          }
        }
        //print(_isSelectedTime);
      }
      if (newIndex == 5) {
        final data = BottomSheetTime().makeShowModalBottomSheet(context);
        //print startDate whien Navigor.pop
        data.then((value) {
          if (value != null) {
            print(value["startDate"]);
          }
        });
      } else {
        _visible = false;
      }
    });
    await Future.delayed(Duration(milliseconds: 800));
  }
}
