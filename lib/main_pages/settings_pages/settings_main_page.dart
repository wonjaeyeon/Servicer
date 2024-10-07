import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:servicer/MOD_PACKAGES/BH_touchFX/bh_touchfx.dart';
import 'package:servicer/MOD_PACKAGES/servicer_neumorphism/servicerNeu.dart';
import 'package:servicer/design_standards/text_styles.dart';
import 'package:servicer/main_pages/settings_pages/logics/settings_handler_v3.dart';

import 'app_information/info.dart';
import 'client_information/client_information_settings.dart';
import 'display_theme/display_theme.dart';
import 'lock_screen/inquiries/main_page.dart';
import 'membership/main_page.dart';
import 'notification/notification_settings.dart';

// FIXME : This is for testing. Remove this later.
double membershipLevel = 1;

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        automaticallyImplyLeading: false,
        // make close button on top right corner
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
        title: Text('설정'),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: $bigFontSize,
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        centerTitle: false,
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView(
                    children: ListTile.divideTiles(
                      context: context,
                      tiles: [
                        BHTouchFXListTile(
                          //leading. 타일 앞에 표시되는 위젯. 참고로 타일 뒤에는 trailing 위젯으로 사용 가능
                          leading: Icon(Icons.notifications_none_sharp),
                          title: Text('알림 설정'),
                          trailing: Text('건별'),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationSettingsPage()));
                          },
                        ),
                        BHTouchFXListTile(
                          leading: Icon(Icons.person_outline_sharp),
                          title: Text('회원 정보'),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => SettingPageClientInfo()));
                          },
                        ),
                        BHTouchFXListTile(
                          leading: Icon(Icons.chat_bubble_outline_outlined),
                          title: Text('화면/테마'),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPageScreenTheme()));
                          },
                        ),
                        BHTouchFXListTile(
                          leading: Icon(Icons.question_answer_sharp),
                          title: Text('고객센터/도움말'),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPageQuestions()));
                          },
                        ),
                        BHTouchFXListTile(
                          leading: Icon(Icons.settings_outlined),
                          title: Text('앱 정보'),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => SettingPageAppInfo()));
                          },
                        ),
                        BHTouchFXListTile(
                          leading: Icon(Icons.card_travel_sharp),
                          title: Text('Servicer Membership'),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => MembershipMainPage()));
                          },
                        ),
                        BHTouchEffectWrapper(
                          $clickedColor: Colors.indigo,
                          child: ElevatedButton(
                              onPressed: () async {
                                SettingsHandlerV3().resetPreferences();
                              },
                              child: Text('설정값초기화 <테스트용>')),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              SettingsHandlerV3().log();
                            },
                            child: Text('현재 설정값 프린트 <테스트용>')),
                        // slider choose 1 to 5
                        Row(
                          children: [
                            Text('현재 멤버십 레벨 : $membershipLevel'),
                            Slider(
                              value: membershipLevel,
                              min: 1,
                              max: 5,
                              label: membershipLevel.round().toString(),
                              onChanged: (value) {
                                setState(() {
                                  membershipLevel = value.roundToDouble();
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
