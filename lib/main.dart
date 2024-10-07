import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
//import 'package:servicer/amplifyconfiguration.dart';
import 'package:servicer/debug_pages/ui_test_page.dart';
import 'package:servicer/main_pages/settings_pages/lock_screen/set_lockscreen.dart';

final String _MODE_ = 'UITEST';
var pageBgColor = Color.fromARGB(255, 240, 240, 240);
//! UITEST: 메인화면에서 UI 요소들을 보고 싶을 때 사용!

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  static final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.light);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    //_configureAmplify();
  }

  // void _configureAmplify() async {
  //   bool configured = false;
  //
  //   final auth = AmplifyAuthCognito(); // 2. Auth 서비스 생성
  //   final analytics = AmplifyAnalyticsPinpoint(); // 3. Analytics 서비스 생성
  //
  //   try {
  //     Amplify.addPlugins([auth, analytics]); // 4. 플러그인 추가
  //     await Amplify.configure(amplifyconfig);
  //     configured = true;
  //   } catch (e) {
  //     print(e);
  //   }
  //
  //   if (configured) {
  //     print('Successfully configured Amplify 🎉');
  //   }
  //
  //     // runApp() 호출 전 Flutter SDK 초기화
  // KakaoSdk.init(
  //   nativeAppKey: '20c300eac837902806a20bce56dc261f',
  //   javaScriptAppKey: '4e445a7f04ccade4a542cca0d7168805',
  // );
  // }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: MyApp.themeNotifier,
      builder:
          (BuildContext context, ThemeMode currentThemeMode, Widget? child) {
        return MaterialApp(
          darkTheme: ThemeData.dark(),
          themeMode: currentThemeMode,
          title: 'Flutter Demo',
          initialRoute: '/',
          theme: ThemeData(
            primarySwatch: Colors.indigo,
            fontFamily: 'IBMPlexSansKR',
            // no splash
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            splashFactory: InkRipple.splashFactory,
          ),
          home: (_MODE_ == 'UITEST') ? UITestPage() : Container(),
        );
      },
    );
  }
}
