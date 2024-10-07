import 'package:flutter/material.dart';

import '../../../../design_standards/text_styles.dart';
import '../../c_data_handler/name_switch_for_icon.dart';
import 'check_client_ID.dart';
import 'check_client_Password.dart';

class AgreementCheckPage extends StatefulWidget {
  final String mallName;
  AgreementCheckPage({Key? key, required this.mallName}) : super(key: key);

  @override
  State<AgreementCheckPage> createState() => _AgreementCheckPageState();
}

class _AgreementCheckPageState extends State<AgreementCheckPage>
    with IconSwitcher {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('회원 동의 확인'),
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
          padding: const EdgeInsets.all(30),
          child: SizedBox(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: SizedBox(
                  child: iconSwitcher(widget.mallName),
                  height: 50,
                  width: 50,
                ),
              ),
              Text("${widget.mallName} 연동을 위해\n시리즈서로님의 판매처 연결을 시작합니다.",
                  style: TextStyle(fontSize: $mediumFontSize)),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("동의 필수 약관", style: TextStyle(fontSize: $mediumFontSize)),
                  IconButton(
                      onPressed: () => {},
                      icon: Icon(Icons.arrow_forward_ios_rounded,
                          size: $mediumFontSize))
                ],
              ),
              Spacer(),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          //모서리를 둥글게
                          borderRadius: BorderRadius.circular(60)),
                      minimumSize: Size(260, 50), //width, height
                      elevation: 0,
                      alignment: Alignment.center,
                      textStyle: TextStyle(fontSize: $mediumFontSize - 4)),
                  onPressed: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => IDCheckPage(
                                  mallName: widget.mallName,
                                  initialValue_: "seriesserro.com",
                                )));
                  },
                  child: Text('확인'),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
