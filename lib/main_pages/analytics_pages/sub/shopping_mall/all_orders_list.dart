import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:servicer/design_standards/my_font_icons.dart';
import 'package:servicer/design_standards/text_styles.dart';
import 'package:servicer/main_pages/settings_pages/settings_main_page.dart';
import 'package:servicer/servicer_modules/shopping_mall_master.dart';

class AllOrdersList extends StatefulWidget {
  const AllOrdersList({Key? key}) : super(key: key);

  @override
  State<AllOrdersList> createState() => _AllOrdersListState();
}

class _AllOrdersListState extends State<AllOrdersList> {
  List<Widget> testList = [];
  var f = NumberFormat.currency(locale: "ko_KR", symbol: "￦");

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

  @override
  void initState() {
    _buildOrderRows();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        titleTextStyle:
            TextStyle(color: Colors.black, fontSize: $mediumFontSize),
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        // hide back button
        automaticallyImplyLeading: true,
        title: const Text('전체 기능'),
        actions: [],
      ),
      body: Column(
        children: [
          Container(
            height: 50,
            child: SingleChildScrollView(
              child: Row(
                  // add space between chips
                  children: [
                Chip(label: Text('기준 1')),
                Chip(label: Text('기준 2')),
                Chip(label: Text('기준 3')),
                Chip(label: Text('기준 4')),
                Chip(label: Text('기준 5')),
              ].map((e) {
                return Container(
                  margin: EdgeInsets.only(left: 10, right: 0),
                  child: e,
                );
              }).toList()),
            ),
          ),
          Flexible(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
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
          ),
        ],
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
