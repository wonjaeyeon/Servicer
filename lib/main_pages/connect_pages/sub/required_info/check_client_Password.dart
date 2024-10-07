import 'package:flutter/material.dart';

import '../../../../design_standards/colors.dart';
import '../../../../design_standards/text_styles.dart';
import '../../c_data_handler/name_switch_for_icon.dart';
import 'check_client_CompanyNum.dart';

class PWCheckPage extends StatefulWidget {
  final String mallName;

  final String? initialValue_;
  PWCheckPage({
    Key? key,
    required this.mallName,
    required this.initialValue_,
  }) : super(key: key);

  @override
  State<PWCheckPage> createState() => _PWCheckPageState();
}

class _PWCheckPageState extends State<PWCheckPage> with IconSwitcher {
  late TextEditingController controller = TextEditingController(
      text: (widget.initialValue_ == null) ? "" : widget.initialValue_);
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('회원 비밀번호 확인'),
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
              Text("${widget.mallName}에서 사용하는 비밀번호를 입력해주세요.",
                  style: TextStyle(fontSize: $mediumFontSize)),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 8)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Form(
                  //key: formKey,
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '회원 비밀번호을 입력해주세요.';
                      }
                      // check if the email is valid
                      if (!RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)) {
                        return '올바른 비밀번호가 아닙니다.';
                      }
                      return null;
                    },
                    controller: controller,
                    decoration: InputDecoration(
                        hintText: '회원 비밀번호',
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(width: 1, color: $$mainColor3),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(
                              width: 1, color: Color.fromARGB(255, 95, 95, 95)),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        )),
                    keyboardType: TextInputType.name,
                    onTap: () {
                      controller.selection = TextSelection(
                        baseOffset: 0,
                        extentOffset: controller.text.length,
                      );
                    },
                  ),
                ),
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
                            builder: (context) => CNCheckPage(
                                  mallName: widget.mallName,
                                  initialValue_: "222-2222-222",
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
