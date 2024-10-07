import 'package:servicer/MOD_PACKAGES/fl_chart_svc/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:servicer/design_standards/colors.dart';
import 'package:servicer/design_standards/text_styles.dart';
import 'indicator.dart';

class ProductListContainer extends StatefulWidget {
  ProductListContainer({Key? key}) : super(key: key);

  @override
  State<ProductListContainer> createState() => _ProductListContainerState();
}

class _ProductListContainerState extends State<ProductListContainer> {
  List<bool> _isSelected = [true, false, false, false, false, false, false, false, false];
  double _chartAnimationDuration = 600;
  bool toggle = false;
  late List<Widget> data;

  List<Widget> dataOne = [
    ListTile(
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Transform.scale(
            scale: 1.6,
            child: Icon(
              Icons.fullscreen,
              size: 50,
            ),
          ),
        ],
      ),
      trailing: Text('36건'),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.symmetric(vertical: 4)),
          Text(
            '네이비 야상코드',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: $mediumFontSize - 4,
            ),
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 8)),
        ],
      ),
      onTap: () {},
    ),
    SizedBox(
      height: 5,
    ),
    ListTile(
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Transform.scale(
            scale: 1.6,
            child: Icon(
              Icons.fullscreen,
              size: 50,
            ),
          ),
        ],
      ),
      trailing: Text('27건'),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.symmetric(vertical: 4)),
          Text(
            '라이트블루 니트',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: $mediumFontSize - 4,
            ),
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 8)),
        ],
      ),
      onTap: () {},
    ),
    SizedBox(
      height: 5,
    ),
    ListTile(
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Transform.scale(
            scale: 1.6,
            child: Icon(
              Icons.fullscreen,
              size: 50,
            ),
          ),
        ],
      ),
      trailing: Text('11건'),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.symmetric(vertical: 4)),
          Text(
            '베이지 팬츠',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: $mediumFontSize - 4,
            ),
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 8)),
        ],
      ),
      onTap: () {},
    ),
    SizedBox(
      height: 5,
    ),
    ListTile(
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Transform.scale(
            scale: 1.6,
            child: Icon(
              Icons.fullscreen,
              size: 50,
            ),
          ),
        ],
      ),
      trailing: Text('7건'),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.symmetric(vertical: 4)),
          Text(
            '회색 줄무니 맨투맨',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: $mediumFontSize - 4,
            ),
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 8)),
        ],
      ),
      onTap: () {},
    ),
    SizedBox(
      height: 5,
    ),
    ListTile(
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Transform.scale(
            scale: 1.6,
            child: Icon(
              Icons.fullscreen,
              size: 50,
            ),
          ),
        ],
      ),
      trailing: Text('5건'),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.symmetric(vertical: 4)),
          Text(
            '블루 스웨터',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: $mediumFontSize - 4,
            ),
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 8)),
        ],
      ),
      onTap: () {},
    ),
  ];

  List<Widget> dataThree = [
    ListTile(
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Transform.scale(
            scale: 1.6,
            child: Icon(
              Icons.fullscreen,
              size: 50,
            ),
          ),
        ],
      ),
      trailing: Text('108건'),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.symmetric(vertical: 4)),
          Text(
            '쿨링 반팔 니트',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: $mediumFontSize - 4,
            ),
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 8)),
        ],
      ),
      onTap: () {},
    ),
    SizedBox(
      height: 5,
    ),
    ListTile(
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Transform.scale(
            scale: 1.6,
            child: Icon(
              Icons.fullscreen,
              size: 50,
            ),
          ),
        ],
      ),
      trailing: Text('97건'),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.symmetric(vertical: 4)),
          Text(
            '데님 팬츠',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: $mediumFontSize - 4,
            ),
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 8)),
        ],
      ),
      onTap: () {},
    ),
    SizedBox(
      height: 5,
    ),
    ListTile(
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Transform.scale(
            scale: 1.6,
            child: Icon(
              Icons.fullscreen,
              size: 50,
            ),
          ),
        ],
      ),
      trailing: Text('79건'),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.symmetric(vertical: 4)),
          Text(
            '일자 츄리닝 바지',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: $mediumFontSize - 4,
            ),
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 8)),
        ],
      ),
      onTap: () {},
    ),
    SizedBox(
      height: 5,
    ),
    ListTile(
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Transform.scale(
            scale: 1.6,
            child: Icon(
              Icons.fullscreen,
              size: 50,
            ),
          ),
        ],
      ),
      trailing: Text('9건'),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.symmetric(vertical: 4)),
          Text(
            '체크 린넨 남방 셔츠',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: $mediumFontSize - 4,
            ),
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 8)),
        ],
      ),
      onTap: () {},
    ),
    SizedBox(
      height: 5,
    ),
    ListTile(
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Transform.scale(
            scale: 1.6,
            child: Icon(
              Icons.fullscreen,
              size: 50,
            ),
          ),
        ],
      ),
      trailing: Text('5건'),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.symmetric(vertical: 4)),
          Text(
            '블루 스웨터',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: $mediumFontSize - 4,
            ),
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 8)),
        ],
      ),
      onTap: () {},
    ),
  ];

  List<Widget> dataTwo = [
    ListTile(
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Transform.scale(
            scale: 1.6,
            child: Icon(
              Icons.fullscreen,
              size: 50,
            ),
          ),
        ],
      ),
      trailing: Text('78건'),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.symmetric(vertical: 4)),
          Text(
            '히든 밴딩 슬랙스',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: $mediumFontSize - 4,
            ),
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 8)),
        ],
      ),
      onTap: () {},
    ),
    SizedBox(
      height: 5,
    ),
    ListTile(
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Transform.scale(
            scale: 1.6,
            child: Icon(
              Icons.fullscreen,
              size: 50,
            ),
          ),
        ],
      ),
      trailing: Text('57건'),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.symmetric(vertical: 4)),
          Text(
            '화이트 면 셔츠',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: $mediumFontSize - 4,
            ),
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 8)),
        ],
      ),
      onTap: () {},
    ),
    SizedBox(
      height: 5,
    ),
    ListTile(
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Transform.scale(
            scale: 1.6,
            child: Icon(
              Icons.fullscreen,
              size: 50,
            ),
          ),
        ],
      ),
      trailing: Text('11건'),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.symmetric(vertical: 4)),
          Text(
            '반팔 니트 티셔츠',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: $mediumFontSize - 4,
            ),
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 8)),
        ],
      ),
      onTap: () {},
    ),
    SizedBox(
      height: 5,
    ),
    ListTile(
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Transform.scale(
            scale: 1.6,
            child: Icon(
              Icons.fullscreen,
              size: 50,
            ),
          ),
        ],
      ),
      trailing: Text('9건'),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.symmetric(vertical: 4)),
          Text(
            '체크 린넨 남방 셔츠',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: $mediumFontSize - 4,
            ),
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 8)),
        ],
      ),
      onTap: () {},
    ),
    SizedBox(
      height: 5,
    ),
    ListTile(
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Transform.scale(
            scale: 1.6,
            child: Icon(
              Icons.fullscreen,
              size: 50,
            ),
          ),
        ],
      ),
      trailing: Text('5건'),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.symmetric(vertical: 4)),
          Text(
            '블루 스웨터',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: $mediumFontSize - 4,
            ),
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 8)),
        ],
      ),
      onTap: () {},
    ),
  ];

  @override
  void initState() {
    super.initState();
    data = dataOne;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(padding: EdgeInsets.symmetric(vertical: 6)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: AlwaysScrollableScrollPhysics(),
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 24,
              ),
              ToggleButtons(
                splashColor: Colors.transparent,
                renderBorder: false,
                //borderRadius: BorderRadius.circular(15),
                constraints: BoxConstraints(
                  minHeight: 15,
                  minWidth: 76,
                  maxHeight: 60,
                  maxWidth: 180,
                ),
                color: $$Grey,
                fillColor: Colors.transparent,
                selectedColor: Colors.white,

                children: [
                  Ink(
                      width: 70,
                      height: 40,
                      decoration: BoxDecoration(
                        //set the background color of the button when it is selected/ not selected
                        color: _isSelected[0] ? $$Grey : $$lightGrey,
                        // here is where we set the rounded corner
                        borderRadius: BorderRadius.circular(10),
                        //don't forget to set the border,
                        //otherwise there will be no rounded corner
                        //border: Border.all(color: Colors.red),
                      ),
                      child: Center(
                        child: Text(
                          '실시간',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: $mediumFontSize,
                          ),
                        ),
                      )),
                  Ink(
                      width: 60,
                      height: 40,
                      decoration: BoxDecoration(
                        //set the background color of the button when it is selected/ not selected
                        color: _isSelected[1] ? $$Grey : $$lightGrey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          '구매',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: $mediumFontSize,
                          ),
                        ),
                      )),
                  Ink(
                      width: 70,
                      height: 40,
                      decoration: BoxDecoration(
                        color: _isSelected[2] ? $$Grey : $$lightGrey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          '수익률',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: $mediumFontSize,
                          ),
                        ),
                      )),
                  Ink(
                      width: 60,
                      height: 40,
                      decoration: BoxDecoration(
                        //set the background color of the button when it is selected/ not selected
                        color: _isSelected[3] ? $$Grey : $$lightGrey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          '거래',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: $mediumFontSize,
                          ),
                        ),
                      )),
                  Ink(
                      width: 60,
                      height: 40,
                      decoration: BoxDecoration(
                        //set the background color of the button when it is selected/ not selected
                        color: _isSelected[4] ? $$Grey : $$lightGrey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          '관심',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: $mediumFontSize,
                          ),
                        ),
                      )),
                  Ink(
                      width: 100,
                      height: 40,
                      decoration: BoxDecoration(
                        //set the background color of the button when it is selected/ not selected
                        color: _isSelected[5] ? $$Grey : $$lightGrey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          '5만원 이하',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: $mediumFontSize,
                          ),
                        ),
                      )),
                  Ink(
                      width: 100,
                      height: 40,
                      decoration: BoxDecoration(
                        //set the background color of the button when it is selected/ not selected
                        color: _isSelected[6] ? $$Grey : $$lightGrey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          '5만원 이상',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: $mediumFontSize,
                          ),
                        ),
                      )),
                  Ink(
                      width: 100,
                      height: 40,
                      decoration: BoxDecoration(
                        //set the background color of the button when it is selected/ not selected
                        color: _isSelected[7] ? $$Grey : $$lightGrey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          '영업이익률',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: $mediumFontSize,
                          ),
                        ),
                      )),
                  Ink(
                      width: 60,
                      height: 40,
                      decoration: BoxDecoration(
                        //set the background color of the button when it is selected/ not selected
                        color: _isSelected[8] ? $$Grey : $$lightGrey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          '매출',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: $mediumFontSize,
                          ),
                        ),
                      )),
                ],
                isSelected: _isSelected,
                onPressed: (int newIndex) {
                  setState(() {
                    for (int i = 0; i < _isSelected.length; i++) {
                      if (i == newIndex) {
                        _isSelected[i] = true;
                      } else {
                        _isSelected[i] = false;
                        //data = newIndex == 1 ? dataTwo : dataOne;
                        switch (newIndex) {
                          case 0:
                            data = dataOne;
                            break;
                          case 1:
                            data = dataTwo;
                            break;
                          case 2:
                            data = dataThree;
                            break;
                        }
                      }
                      //print(_isSelected);
                    }
                  });
                },
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            alignment: Alignment.topCenter,
            height: 360,
            child: ListView(
              physics: NeverScrollableScrollPhysics(),
              children: data.toList(),
            ),
          ),
        ),
        Center(
          child: TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.black, textStyle: TextStyle(decorationColor: $$Grey, fontSize: $mediumFontSize - 4),
            ),
            onPressed: () {},
            child: Text(
              '더보기 >',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
