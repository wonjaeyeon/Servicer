import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../servicer_modules/shopping_mall_master.dart';

var f = NumberFormat.currency(locale: "ko_KR", symbol: "￦");

class ShoppingMallAnalysisTabPage1 extends StatefulWidget {
  ShoppingMallAnalysisTabPage1({Key? key}) : super(key: key);

  @override
  State<ShoppingMallAnalysisTabPage1> createState() =>
      _ShoppingMallAnalysisTabPage1State();
}

class _ShoppingMallAnalysisTabPage1State
    extends State<ShoppingMallAnalysisTabPage1> {
  Map data = {};
  List<Widget> testList = [];

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

  @override
  Widget build(BuildContext context) {
    return ListView(
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
                          Text('4',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
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
                          Text('32',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
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
                          Text('6',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
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
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Text(
                      '세부 내역',
                      style: TextStyle(fontSize: 15),
                    ),
                    Spacer(),
                    // make legend

                    InkWell(
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
                  ],
                ),
              ),
              SizedBox(height: 16),
              //flchart
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: (testList.isEmpty) ? 1 : testList.length,
                  itemBuilder: (BuildContext context, int index) {
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
