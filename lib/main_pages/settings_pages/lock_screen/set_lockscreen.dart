import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:servicer/main_pages/settings_pages/lock_screen/set_lockscreen_bio.dart';
import 'package:servicer/main_pages/settings_pages/lock_screen/set_lockscreen_pin.dart';
import 'package:servicer/main_pages/settings_pages/logics/settings_handler_v3.dart';

import '../../../design_standards/text_styles.dart';
import '../logics/settings_definitions.dart';

class SetLockScreen extends StatefulWidget {
  SetLockScreen({Key? key}) : super(key: key);

  @override
  State<SetLockScreen> createState() => _SetLockScreenState();
}

class _SetLockScreenState extends State<SetLockScreen> {
  LocalAuthentication localAuth = LocalAuthentication();
  final GlobalKey key = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('잠금 설정'),
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
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: ListView(
            children: ListTile.divideTiles(context: context, tiles: [
              ListTile(
                title: Text('잠금 사용하기'),
                trailing: FutureBuilder(
                    future: SettingsHandlerV3().getPreferences(Security.lockScreenType),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      return Switch(
                        value: snapshot.data != LockScreenType.none,
                        onChanged: (v) {
                          if (v) {
                            setState(() {
                              //! TODO 핀번호 설정 창으로 넘기기
                              Navigator.push(context, MaterialPageRoute(builder: (context) => SetPin())).then((_) {
                                setState(() {});
                              });
                            });
                          } else {
                            setState(() {
                              //! TODO 잠금화면 사용 안할거냐고 물어보기
                              //TODO 사용안할거라고 하면 저장된 핀번호 지우고 바이오 미사용으로 설정하기
                              SettingsHandlerV3().setPreferences(Security.lockScreenType, LockScreenType.none);
                            });
                          }
                        },
                      );
                    }),
                onTap: () {},
              ),
              FutureBuilder(
                  future: SettingsHandlerV3().getPreferences(Security.lockScreenType),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    return ListTile(
                      enabled: snapshot.data != LockScreenType.none,
                      onTap: () {},
                      title: Text('생체 인증으로 로그인하기'),
                      trailing: (snapshot.data != LockScreenType.none)
                          ? Checkbox(
                              value: snapshot.data == LockScreenType.bio,
                              onChanged: (v) {
                                setBioMethod(v, context);
                              },
                            )
                          : null,
                    );
                  }),
              ListTile(
                  title: FutureBuilder(
                      future: SettingsHandlerV3().getPreferences(Security.lockScreenType),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        return Text(
                          (snapshot.data == LockScreenType.none)
                              ? '보안을 위해 잠금 화면을 설정해 주세요. '
                              : (snapshot.data == LockScreenType.pin)
                                  ? '현재 설정된 잠금 방식: PIN번호'
                                  : (snapshot.data == LockScreenType.bio)
                                      ? '현재 설정된 잠금 방식: PIN 및 생체 인식'
                                      : '',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        );
                      }))
            ]).toList(),
          ),
        ),
      ),
    );
  }

  void setBioMethod(bool? v, BuildContext context) {
    if (v!) {
      setState(() {
        Navigator.push(context, MaterialPageRoute(builder: (context) => SetBio(context2: context))).then((_) {
          setState(() {});
        });
      });
    } else {
      setState(() {
        SettingsHandlerV3().setPreferences(Security.lockScreenType, LockScreenType.pin);
      });
    }
  }
}
