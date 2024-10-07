import 'package:flutter/material.dart';
import 'package:servicer/design_standards/text_styles.dart';

import 'sign_up_s2_email_link.dart';

class SignUpIDPage extends StatefulWidget {
  const SignUpIDPage({super.key});

  @override
  State<SignUpIDPage> createState() => _SignUpIDPageState();
}

class _SignUpIDPageState extends State<SignUpIDPage> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool isButtonDisabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // back button
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('회원가입'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(25),
          child: Stack(
            alignment: Alignment.center,
            children: [
              isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container(),
              Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '안녕하세요! \n가입을 시작할게요.',
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
                      '로그인에 사용할 이메일을 입력해주세요.',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '이 이메일 주소가 로그인과 비밀번호 찾기등에 사용되니 주로 사용하는 이메일로 설정해주세요.',
                      style: TextStyle(
                        fontSize: $smallFontSize,
                      ),
                    ),
                  ),
                  SizedBox(height: 100),
                  Form(
                    key: _formKey,
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '회원 이메일을 입력해주세요.';
                        }
                        // check if the email is valid
                        else if (!RegExp(
                                r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value)) {
                          return '올바른 이메일 형식이 아닙니다.';
                        }
                        return null;
                      },
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: '이메일',
                      ),
                    ),
                  ),
                  SizedBox(height: 100),
                  ElevatedButton(
                    onPressed: isButtonDisabled
                        ? null
                        : () async {
                            if (_formKey.currentState!.validate()) {
                              //delay for 3 second
                              setState(() {
                                isLoading = true;
                                isButtonDisabled = true;
                              });

                              await Future.delayed(Duration(seconds: 3), () {});
                              setState(() {
                                isLoading = false;
                              });
                              //navigate to next page
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignUpEmailLinkPage(
                                    email: _emailController.text,
                                  ),
                                ),
                              );
                            }
                          },
                    child: Container(
                      alignment: Alignment.center,
                      child: Text('계속하기'),
                      width: double.infinity,
                      height: 60,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                    onPressed: isButtonDisabled
                        ? null
                        : () async {
                            if (_formKey.currentState!.validate()) {
                              //delay for 3 second
                              setState(() {
                                isLoading = true;
                                isButtonDisabled = true;
                              });

                              await Future.delayed(Duration(seconds: 3), () {});
                              setState(() {
                                isLoading = false;
                              });
                              //navigate to next page
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignUpEmailLinkPage(
                                    email: _emailController.text,
                                  ),
                                ),
                              );
                            }
                          },
                    child: Text(
                      '이미 계정이 있는 경우',
                      style: TextStyle(
                        fontSize: $smallFontSize,
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
