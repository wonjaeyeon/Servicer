import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:servicer/debug_pages/barChart_design_page.dart';
import 'package:servicer/debug_pages/lineChart_design_page.dart';
import 'package:servicer/debug_pages/verticalBarChart_design_page.dart';
import 'package:servicer/main_pages/analytics_pages/new_main.dart';
import 'package:servicer/main_pages/home_page_v2.dart';

import '../main_pages/login_page.dart';
import '../main_pages/start_page.dart';
import '../main_pages/test_page.dart';

class UITestPage extends StatefulWidget {
  UITestPage({Key? key}) : super(key: key);

  @override
  State<UITestPage> createState() => _UITestPageState();
}

class _UITestPageState extends State<UITestPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UI 테스트 페이지'),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: ListView(
        children: [
          ElevatedButton(
            child: Text('메인 페이지'),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => StartPage()));
            },
          ),
          ElevatedButton(
            child: Text('선그래프 애니메이션 테스트'),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => LineChartDesignPage()));
            },
          ),
          ElevatedButton(
            child: Text('가로방향 막대그래프 테스트'),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => BarChartDesignPage()));
            },
          ),
          ElevatedButton(
            child: Text('horizontalchart testpage'),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => TestPage()));
            },
          ),
          ElevatedButton(
            child: Text('LOGIN testpage'),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
            },
          ),
          ElevatedButton(
            child: Text('분석 메인 페이지 테스트용'),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => AnalyticsMainPage()));
            },
          ),
          ElevatedButton(
            child: Text('홈 페이지 V2'),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => HomePageV2()));
            },
          ),
        ],
      ),
    );
  }
}
