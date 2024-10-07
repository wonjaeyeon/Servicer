import 'package:flutter/material.dart';
import 'package:servicer/MOD_PACKAGES/BH_touchFX/bh_touchfx.dart';
import 'package:servicer/main_pages/home_page_v2.dart';

//aws amplify
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:servicer/main_pages/start_page.dart';

//import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:http/http.dart' as http;

import 'sign_up_pages/main/sign_up_s1_id.dart';
import 'sign_up_pages/sign_up_page.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isSignInComplete = false;

  Future<void> _signInAmplify(context) async {
    try {
      final result = await Amplify.Auth.signIn(
        username: _emailController.text,
        password: _passwordController.text,
      );
      if (result.isSignedIn) {
        print('Sign in succeeded');
        print(result.nextStep);
        isSignInComplete = true;
        Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => StartPage()),
        );
      } else {
        print('Sign in not complete');
      }
    } on AuthException catch (e) {
      print('Sign in failed with exception: \n $e');
      // log out
      await Amplify.Auth.signOut();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(25),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '로그인',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 100),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: '이메일',
                ),
              ),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: '비밀번호',
                ),
                obscureText: true,
              ),
              //NOTE  login button
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _signInAmplify(context);
                },
                child: Container(
                  alignment: Alignment.center,
                  child: Text('로그인'),
                  width: double.infinity,
                  height: 60,
                ),
              ),
              // button with background image - naver login
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {},
                child: Container(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/buttons/naver/btnG_아이콘사각.png',
                        width: 30,
                        height: 30,
                      ),
                      Text('네이버 아이디로 로그인'),
                    ],
                  ),
                  width: double.infinity,
                  height: 60,
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF03C75A)), // NOTE 네이버 로그인 버튼 컬러
              ),
              // button with background image - kakao login
              SizedBox(height: 10),
              InkWell(
                onTap: () => {},
                child: Image.asset(
                  'assets/buttons/kakao/kakao_login_large_wide.png',
                  //width: 30,
                  //height: 30,
                  width: double.infinity,
                  height: 60,
                ),
              ),
              // button with background image - apple login
              SizedBox(height: 10),
              // ElevatedButton(
              //   onPressed: () {},
              //   child: Container(
              //     alignment: Alignment.center,
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         Image.asset(
              //           'assets/buttons/apple/Logo - SIWA - Left-aligned - Black - Large@3x.png',
              //           width: 30,
              //           height: 30,
              //         ),
              //         Text('Sign in with Apple',
              //             style: TextStyle(color: Colors.black)),
              //       ],
              //     ),
              //     width: double.infinity,
              //     height: 60,
              //   ),
              //   style: ElevatedButton.styleFrom(
              //       primary: Colors.white), // NOTE 네이버 로그인 버튼 컬러
              // ),
              // SizedBox(height: 10),
              // SignInWithAppleButton(
              //   height: 60,
              //   onPressed: () async {
              //     final credential = await SignInWithApple.getAppleIDCredential(
              //       scopes: [
              //         AppleIDAuthorizationScopes.email,
              //         AppleIDAuthorizationScopes.fullName,
              //       ],
              //       webAuthenticationOptions: WebAuthenticationOptions(
              //         // TODO: Set the `clientId` and `redirectUri` arguments to the values you entered in the Apple Developer portal during the setup
              //         clientId:
              //             'de.lunaone.flutter.signinwithappleexample.service',
              //
              //         redirectUri:
              //             // For web your redirect URI needs to be the host of the "current page",
              //             // while for Android you will be using the API server that redirects back into your app via a deep link
              //             Uri.parse(
              //           'https://flutter-sign-in-with-apple-example.glitch.me/callbacks/sign_in_with_apple',
              //         ),
              //       ),
              //       // TODO: Remove these if you have no need for them
              //       nonce: 'example-nonce',
              //       state: 'example-state',
              //     );
              //
              //     // ignore: avoid_print
              //     print(credential);
              //
              //     // This is the endpoint that will convert an authorization code obtained
              //     // via Sign in with Apple into a session in your system
              //     final signInWithAppleEndpoint = Uri(
              //       scheme: 'https',
              //       host: 'flutter-sign-in-with-apple-example.glitch.me',
              //       path: '/sign_in_with_apple',
              //       queryParameters: <String, String>{
              //         'code': credential.authorizationCode,
              //         if (credential.givenName != null)
              //           'firstName': credential.givenName!,
              //         if (credential.familyName != null)
              //           'lastName': credential.familyName!,
              //         'useBundleId': 'false',
              //         if (credential.state != null) 'state': credential.state!,
              //       },
              //     );
              //
              //     final session = await http.Client().post(
              //       signInWithAppleEndpoint,
              //     );

                  // If we got this far, a session based on the Apple ID credential has been created in your system,
                  // and you can now set this as the app's session
                  // ignore: avoid_print
              //    print(session);
              //  },
              //),
              SizedBox(height: 10),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    child: Text(
                      '아이디/비밀번호 찾기',
                      style: TextStyle(
                        color: Colors.grey,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text('|', style: TextStyle(color: Colors.grey)),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUpIDPage(),
                        ),
                      );
                    },
                    child: Text(
                      '회원가입',
                      style: TextStyle(
                        color: Colors.grey,
                        decoration: TextDecoration.underline,
                      ),
                    ),
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
