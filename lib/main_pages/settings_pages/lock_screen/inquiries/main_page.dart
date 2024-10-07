import 'package:flutter/material.dart';
import 'package:servicer/design_standards/colors.dart';
import 'package:servicer/design_standards/text_styles.dart';
import 'package:servicer/design_standards/widget_styles.dart';
import 'package:servicer/main_pages/settings_pages/lock_screen/inquiries/sub/help.dart';

import 'sub/FAQ.dart';

class SettingsPageQuestions extends StatefulWidget {
  const SettingsPageQuestions({Key? key}) : super(key: key);

  @override
  SettingsPageQuestionsState createState() => SettingsPageQuestionsState();
}

class SettingsPageQuestionsState extends State<SettingsPageQuestions> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('고객센터'),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: $mediumFontSize,
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                  title: Text('도움말'),
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => HelpPage()))),
              Divider(height: 0),
              ListTile(
                title: Text('문의하기'),
              ),
              SizedBox(height: 20),
              Container(
                child: Text('약관 및 정책', style: TextStyle(fontSize: 15)),
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 14),
              ),
              ListTile(title: Text('이용약관')),
              Divider(height: 0),
              ListTile(title: Text('위치기반서비스 이용약관')),
              Divider(height: 0),
              ListTile(title: Text('개인정보처리방침')),
              Divider(height: 0),
              ListTile(title: Text('오픈소스 라이선스')),
              Divider(height: 0),
              ListTile(title: Text('맞춤형 광고 안내')),
              Divider(height: 0),
            ],
          ),
        ),
      ),
    );
  }
}
