import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:servicer/design_standards/colors.dart';
import 'package:servicer/main_pages/all_features_list/all_features.dart';

import 'package:servicer/main_pages/analytics_pages/new_main.dart';
import 'package:servicer/main_pages/home_page_v2.dart';


import 'connect_pages/main_page_ver2.dart';
import 'home_page.dart';
import 'connect_pages/sub/unused/main_page_ver1.dart';
import 'settings_pages/settings_main_page.dart';
import 'package:servicer/design_standards/my_font_icons.dart';

class StartPage extends StatefulWidget {
  StartPage({Key? key}) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

int bottomNavigationBarIndex = 0;

class _StartPageState extends State<StartPage> {
  @override
  void initState() {
    super.initState();
    bottomNavigationBarIndex = 0;
  }

  List<Widget> pages = [
    HomePageV2(),
    ConnectPageV2(),
    AnalyticsMainPage(),
    AllFeatures(),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      top: false,
      child: Scaffold(
        backgroundColor: pageBgColor,
        // add fade transition between pages
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 100),
          switchInCurve: Curves.easeIn,
          switchOutCurve: Curves.easeOut,
          child: pages[bottomNavigationBarIndex],
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
        bottomNavigationBar: Theme(
          data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: SizedBox(
            height: 90,
            child: BottomNavigationBar(
              onTap: (index) {
                setState(() {
                  bottomNavigationBarIndex = index;
                });
              },
              type: BottomNavigationBarType.fixed,
              currentIndex: bottomNavigationBarIndex,
              enableFeedback: false,

              //
              selectedIconTheme: IconThemeData(color: Colors.black),
              unselectedIconTheme:
                  IconThemeData(color: Colors.black.withAlpha(100)),
              //
              selectedItemColor: Colors.black.withAlpha(255),
              unselectedItemColor: Colors.black.withAlpha(100),
              //
              selectedFontSize: 14,
              unselectedFontSize: 14,
              //
              iconSize: 20,
              //selectedLabelStyle: TextStyle(height: 1.6),

              items: const [
                BottomNavigationBarItem(
                    icon: Icon(MyFont.home), label: ' 홈', tooltip: ''),
                BottomNavigationBarItem(
                    icon: Icon(MyFont.link), label: '연결', tooltip: ''),
                BottomNavigationBarItem(
                    icon: Icon(MyFont.chart_line), label: '분석', tooltip: ''),
                BottomNavigationBarItem(
                    icon: Icon(Icons.menu), label: '전체', tooltip: ''),
              ],
              backgroundColor: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
