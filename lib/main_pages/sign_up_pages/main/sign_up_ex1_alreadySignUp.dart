import 'package:flutter/material.dart';
import 'package:servicer/design_standards/text_styles.dart';
import 'package:servicer/main_pages/login_page.dart';

import '../../start_page.dart';

class SignUpCompletePage extends StatefulWidget {
  const SignUpCompletePage({super.key});

  @override
  State<SignUpCompletePage> createState() => _SignUpCompletePageState();
}

class _SignUpCompletePageState extends State<SignUpCompletePage> {
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();

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
        title: Text('회원가입 확인'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(25),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '이미 가입된 이메일입니다.',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 50),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '아이디를 잊어버리셨나요?',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),
              SizedBox(
                height: 100,
              ),
              Align(alignment: Alignment.centerLeft,
                child: Text(
                  '비밀번호를 잊어버리셨나요?',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/', (_) => false);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: Text('로그인 하러 가기'),
                    width: double.infinity,
                    height: 50,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
