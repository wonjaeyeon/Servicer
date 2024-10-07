import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/material.dart';
//aws amplify
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();
  final _verifyNumberConfirmController = TextEditingController();
  bool isSignUpComplete = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkKakaoTalkInstallation().then((value) {
      if (value) {
        print('KakaoTalk is installed');
      } else {
        print('KakaoTalk is not installed');
      }
    });
  }

  Future<String> _onSignUp(LoginData data) async {
    LoginData _loginData = data;
    try {
      print("Sign up...");
      await Amplify.Auth.signUp(
          username: data.name,
          password: data.password,
          options: CognitoSignUpOptions(
              userAttributes: {CognitoUserAttributeKey.email: data.name}));
      setState(() {
        isSignUpComplete = true;
      });
    } on AuthException catch (e) {
      return '${e.message} - ${e.recoverySuggestion}';
    }
    return 'Sign up succeeded';
  }

  void _verifyCode(LoginData data, String code) async {
    try {
      SignUpResult res = await Amplify.Auth.confirmSignUp(
          username: data.name, confirmationCode: code);

      if (res.isSignUpComplete) {
        // 회원 가입 성공!!
      }
    } on AuthException catch (e) {
      // 에러 핸들링
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // back button
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('회원가입'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(25),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '회원가입',
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
              TextField(
                controller: _passwordConfirmController,
                decoration: InputDecoration(
                  labelText: '비밀번호 확인',
                ),
                obscureText: true,
              ),
              TextButton(
                  onPressed: () {
                    LoginData(_emailController.text, _passwordController.text);
                    _onSignUp(LoginData(
                        _emailController.text, _passwordController.text));
                  },
                  child: Text("인증번호 받기")),
              TextField(
                controller: _verifyNumberConfirmController,
                decoration: InputDecoration(
                  labelText: '인증번호',
                ),
                obscureText: true,
              ),
              //NOTE  login button
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // LoginData(_emailController.text, _passwordController.text);

                  // _onSignUp(LoginData(
                  //         _emailController.text, _passwordController.text))
                  //     .then((value) => print(value));

                  _verifyCode(
                      LoginData(
                          _emailController.text, _passwordController.text),
                      _verifyNumberConfirmController.text);
                },
                child: Container(
                  alignment: Alignment.center,
                  child: Text('확인'),
                  width: double.infinity,
                  height: 60,
                ),
              ),

              SizedBox(height: 10),

              // make a kakao sign up button
              ElevatedButton(
                onPressed: () {
                  loginWithKakao();
                },
                child: Container(
                  alignment: Alignment.center,
                  child: Text('카카오로 회원가입'),
                  width: double.infinity,
                  height: 60,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<bool> checkKakaoTalkInstallation() async {
  final bool installed = await isKakaoTalkInstalled();
  return installed;
}

Future<void> loginWithKakao() async {
//* 카카오톡 실행이 가능하면 카카오톡으로 로그인, 아니면 카카오계정으로 로그인
  if (await isKakaoTalkInstalled()) {
    try {
      await UserApi.instance.loginWithKakaoTalk();
      print('카카오톡으로 로그인 성공');
    } catch (error) {
      print('카카오톡으로 로그인 실패 $error');

      // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
      // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
      if (error is PlatformException && error.code == 'CANCELED') {
        return;
      }
      // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
      try {
        await UserApi.instance.loginWithKakaoAccount();
        print('카카오계정으로 로그인 성공');
      } catch (error) {
        print('카카오계정으로 로그인 실패 $error');
      }
    }
  } else {
    try {
      await UserApi.instance.loginWithKakaoAccount();
      print('카카오계정으로 로그인 성공}');
    } catch (error) {
      print('카카오계정으로 로그인 실패 $error');
    }
  }

  //* ask for additional info
  User user;
  try {
    user = await UserApi.instance.me();
  } catch (error) {
    print('사용자 정보 요청 실패 $error');
    return;
  }

  //* 사용자의 추가 동의가 필요한 사용자 정보 동의 항목 확인
  List<String> scopes = [];
  //* 만약 사용자에게 이메일 수집 동의롤 못받았다면 다시 요청
  user.kakaoAccount?.email ?? scopes.add('account_email');
  if (scopes.length > 0) {
    print('사용자에게 추가 동의 받아야 하는 항목이 있습니다');

    // OpenID Connect 사용 시
    // scope 목록에 "openid" 문자열을 추가하고 요청해야 함
    // 해당 문자열을 포함하지 않은 경우, ID 토큰이 재발급되지 않음
    // scopes.add("openid")

    // scope 목록을 전달하여 추가 항목 동의 받기 요청
    // 지정된 동의 항목에 대한 동의 화면을 거쳐 다시 카카오 로그인 수행
    OAuthToken token;
    try {
      token = await UserApi.instance.loginWithNewScopes(scopes);
      print('현재 사용자가 동의한 동의 항목: ${token.scopes}');
    } catch (error) {
      print('추가 동의 요청 실패 $error');
      return;
    }

    // 사용자 정보 재요청
    try {
      User user = await UserApi.instance.me();
      print('사용자 정보 요청 성공'
          '\n회원번호: ${user.id}'
          '\n닉네임: ${user.kakaoAccount?.profile?.nickname}'
          '\n이메일: ${user.kakaoAccount?.email}');
    } catch (error) {
      print('사용자 정보 수집 2차 동의 중 실패 $error');
    }
  } else {
    try {
      User user = await UserApi.instance.me();
      print('사용자 정보 요청 성공'
          '\n회원번호: ${user.id}'
          '\n닉네임: ${user.kakaoAccount?.profile?.nickname}'
          '\n이메일: ${user.kakaoAccount?.email}');
    } catch (error) {
      print('사용자 정보 동의 1차에서 받았으나 오류: $error');
    }
  }
  //! hgfhhfhfhfjhggggh
  //NOTE 이 부분 로그아웃 버튼 만들어서 카카오/구글/애플 로그아웃 버튼 만들기(버튼 하나에서 그냥 로그아웃 성공하면 끝나는 로그아웃 버튼 만들기)
  // log out
  try {
    await UserApi.instance.logout();
    print('로그아웃 성공');
  } catch (error) {
    print('로그아웃 실패 $error');
  }
}

class LoginData {
  LoginData(this.name, this.password);
  final String name;
  final String password;
}
