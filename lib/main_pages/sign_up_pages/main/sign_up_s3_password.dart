import 'package:flutter/material.dart';
import 'package:servicer/design_standards/text_styles.dart';

import 'sign_up_s4_complete.dart';

class SignUpPasswordPage extends StatefulWidget {
  const SignUpPasswordPage({super.key});

  @override
  State<SignUpPasswordPage> createState() => _SignUpPasswordPageState();
}

class _SignUpPasswordPageState extends State<SignUpPasswordPage> {
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
        title: Text('비밀번호 설정'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(25),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '이메일 인증이 완료되었습니다.',
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
                  '로그인에 사용할 비밀번호를 입력해주세요.',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),
              SizedBox(height: 100),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: '비밀번호',
                ),
                obscureText: true,
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: _passwordConfirmController,
                decoration: InputDecoration(
                  labelText: '비밀번호 확인',
                ),
                obscureText: true,
              ),
              SizedBox(height: 100),
              ElevatedButton(
                onPressed: () {
                  //check if password and passwordConfirm are same
                  //if not, show error message
                  //if yes, go to next page
                  if(_passwordController.text == _passwordConfirmController.text) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUpCompletePage(),
                      ),
                    );

                  }
                  else{

                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  child: Text('계속하기'),
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
