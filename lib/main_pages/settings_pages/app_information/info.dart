import 'package:flutter/material.dart';
import 'package:servicer/design_standards/colors.dart';
import 'package:servicer/design_standards/text_styles.dart';
import 'package:servicer/design_standards/widget_styles.dart';

class SettingPageAppInfo extends StatefulWidget {
  const SettingPageAppInfo({Key? key}) : super(key: key);

  @override
  SettingPageAppInfoState createState() => SettingPageAppInfoState();
}

class SettingPageAppInfoState extends State<SettingPageAppInfo> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('앱 정보'),
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
      body: Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                children: [
                  ListTile(
                    title: Text('앱 버전'),
                    subtitle: Text('0.0.1'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
