import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:servicer/main_pages/settings_pages/logics/settings_definitions.dart';
import 'package:servicer/main_pages/settings_pages/logics/settings_handler_v3.dart';

class SetBio extends StatefulWidget {
  var context2;
  SetBio({Key? key, required this.context2}) : super(key: key);

  @override
  State<SetBio> createState() => _SetBioState();
}

class _SetBioState extends State<SetBio> {
  var localAuth = LocalAuthentication();
  bool b = false; // THIS IS FOR ANIMATION USE
  bool bioAuth = false;
  bool bioAuthClosed = false;

  startBioAuth() async {
    b = await localAuth.authenticate(
      localizedReason: '생체 인식 사용을 위한 인증을 진행합니다. ',
    );
    setState(() {
      bioAuth = b;
      bioAuth ? SettingsHandlerV3().setPreferences(Security.lockScreenType, LockScreenType.bio) : null;
      bioAuthClosed = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    finish();
  }

  finish() {
    Navigator.pop(widget.context2);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => startBioAuth());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          width: double.infinity,
          color: Color.fromARGB(255, 51, 146, 255),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.all(25),
                  child: (bioAuth) ? null : Text('생체 인식을 진행합니다.', style: TextStyle(fontSize: 20, color: Colors.white)),
                ),
                Padding(
                  padding: EdgeInsets.all(45),
                  child: AnimatedOpacity(
                    opacity: bioAuthClosed ? 1 : 0,
                    duration: Duration(seconds: 1),
                    child: (bioAuthClosed)
                        ? (bioAuth)
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.check_circle, size: 50, color: Colors.white),
                                  Text(
                                    '인증이 완료되었습니다!',
                                    style: TextStyle(fontSize: 20, color: Colors.white),
                                  )
                                ],
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.close_rounded, size: 50, color: Colors.white),
                                  Text(
                                    '생체 인식에 실패하였습니다.',
                                    style: TextStyle(fontSize: 20, color: Colors.white),
                                  )
                                ],
                              )
                        : null,
                  ),
                ),
                Padding(
                    padding: EdgeInsets.all(25),
                    child: (bioAuthClosed && !bioAuth)
                        ? Text(
                            '이전 화면으로 되돌아갑니다.',
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          )
                        : Text(
                            '다음부터 생체 인식으로 로그인할 수 있습니다.',
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
