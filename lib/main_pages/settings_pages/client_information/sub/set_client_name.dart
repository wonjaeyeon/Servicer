import 'package:flutter/material.dart';

import 'package:servicer/design_standards/colors.dart';
import 'package:servicer/design_standards/text_styles.dart';
import 'package:servicer/main_pages/settings_pages/logics/settings_definitions.dart';
import 'package:servicer/main_pages/settings_pages/logics/settings_handler_v3.dart';

class SetClientName extends StatefulWidget {
  final String? initialValue_;

  SetClientName({
    Key? key,
    required this.initialValue_,
  }) : super(key: key);

  @override
  SetClientNameState createState() => SetClientNameState();
}

class SetClientNameState extends State<SetClientName> {
  late TextEditingController controller =
      TextEditingController(text: (widget.initialValue_ == null) ? "" : widget.initialValue_);
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('회원 이름 설정'),
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
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 24),
                child: Row(
                  children: [
                    Flexible(
                      child: Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 12)),
              Text(
                '회원 이름을 입력해주세요.',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: $mediumFontSize - 4,
                ),
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 8)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Form(
                  key: formKey,
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty || value.length < 2) {
                        return '이름은 2자 이상이어야 합니다.';
                      }
                      if (!RegExp(r"^[ㄱ-ㅎ가-힣]*$").hasMatch(value)) {
                        return '이름은 한글만 입력할 수 있습니다.';
                      }
                      return null;
                    },
                    controller: controller,
                    decoration: InputDecoration(
                        hintText: '회원 이름',
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(width: 1, color: $$mainColor3),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(width: 1, color: Color.fromARGB(255, 95, 95, 95)),
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
              Padding(padding: EdgeInsets.symmetric(vertical: 8)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black, backgroundColor: Color.fromARGB(255, 228, 228, 228), shape: RoundedRectangleBorder(
                            //모서리를 둥글게
                            borderRadius: BorderRadius.circular(60)), //글자색
                        minimumSize: Size(240, 50), //width, height
                        elevation: 0,
                        alignment: Alignment.center,
                        textStyle: TextStyle(fontSize: $mediumFontSize - 4)),
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        SettingsHandlerV3().setPreferences(Client.name, controller.text);
                        Navigator.pop(context);
                      } else {
                        print('bad input');
                      }
                    },
                    child: Text('저장'),
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
