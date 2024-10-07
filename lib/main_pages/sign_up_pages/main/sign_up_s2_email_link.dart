import 'package:flutter/material.dart';
import 'package:servicer/design_standards/text_styles.dart';

import 'sign_up_s1_id.dart';
import 'sign_up_s3_password.dart';

class SignUpEmailLinkPage extends StatefulWidget {
  final String email;
  const SignUpEmailLinkPage({Key? key, required this.email}) : super(key: key);

  @override
  State<SignUpEmailLinkPage> createState() => _SignUpEmailLinkPageState();
}

class _SignUpEmailLinkPageState extends State<SignUpEmailLinkPage> {
  //init
  @override
  void initState() {
    //if 5 seconds past then go to next page
    Future.delayed(Duration(seconds: 5), () {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => SignUpPasswordPage()));
    });
    super.initState();
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
                  widget.email + "으로 인증링크를 보냈어요.",
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
                  '인증링크는 30분 뒤에 만료됩니다.',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //question mark icon
                  Icon(Icons.help_outline),
                  SizedBox(width: 6),
                  Text(
                    '인증 링크를 못 받으셨나요?',
                    style: TextStyle(
                      fontSize: $smallFontSize,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      '재전송',
                      style: TextStyle(
                        fontSize: $smallFontSize,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 100),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '이메일 인증이 완료되면 자동으로 다음 화면으로 넘어갑니다.',
                  style: TextStyle(
                    fontSize: $mediumFontSize,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
