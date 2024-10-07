import 'package:flutter/material.dart';
import 'package:kpostal/kpostal.dart';

import 'package:servicer/design_standards/colors.dart';
import 'package:servicer/design_standards/text_styles.dart';

import '../../logics/settings_definitions.dart';
import '../../logics/settings_handler_v3.dart';

class SetClientAddress extends StatefulWidget {
  final String? initialValue_newPostalCode;
  final String? initialValue_address;
  final String? initialValue_addressDetail;

  const SetClientAddress({
    Key? key,
    required this.initialValue_newPostalCode,
    required this.initialValue_address,
    required this.initialValue_addressDetail,
  }) : super(key: key);

  @override
  SetClientAddressState createState() => SetClientAddressState();
}

class SetClientAddressState extends State<SetClientAddress> {
  late TextEditingController controller_newPostalCode = TextEditingController(text: widget.initialValue_newPostalCode ?? '');
  late TextEditingController controller_address = TextEditingController(text: widget.initialValue_address ?? '');
  late TextEditingController controller_addressDetail = TextEditingController(text: widget.initialValue_addressDetail ?? '');
  final formKey = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  bool showDetailedAddressInput = false;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    controller_newPostalCode.dispose();
    controller_address.dispose();
    controller_addressDetail.dispose();
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
        title: Text('회원 주소 설정'),
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
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  controller_address.text = '';
                  controller_addressDetail.text = '';
                  controller_newPostalCode.text = '';
                },
                child: Text(
                  '회원의 주소를 등록합니다.',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: $mediumFontSize - 4,
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 18),
                      child: Form(
                        child: TextFormField(
                          controller: controller_newPostalCode,
                          enabled: false,
                          decoration: InputDecoration(
                            hintText: '우편번호',
                            border: UnderlineInputBorder(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: OutlinedButton(
                      child: Text('주소 찾아보기'),
                      onPressed: () async {
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => KpostalView(
                                callback: (Kpostal result) {
                                  setState(() {
                                    controller_newPostalCode.text = result.postCode;
                                    controller_address.text = result.address;
                                    controller_addressDetail.text = '';
                                  });
                                },
                              ),
                            ));
                      },
                    ),
                  )
                ],
              ),
              Form(
                key: formKey,
                child: TextFormField(
                  controller: controller_address,
                  enabled: false,
                  decoration: InputDecoration(
                    hintText: '주소',
                    border: UnderlineInputBorder(),
                    errorStyle: TextStyle(
                      color: Theme.of(context).colorScheme.error, // or any other color
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return '\'주소 찾아보기\'버튼을 이용해 주소를 검색해주세요.';
                    }
                    return null;
                  },
                ),
              ), //* 자동 입력되는 주소
              Form(
                key: formKey2,
                child: TextFormField(
                  controller: controller_addressDetail,
                  decoration: InputDecoration(
                    hintText: '상세 주소를 입력하세요. (예: 123동 456호)',
                    border: UnderlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.length >= 20) {
                      return '상세 주소는 20자 이하로 입력해주세요.';
                    }
                    return null;
                  },
                ),
              ), //* 상세 주소
              const SizedBox(height: 24),

              Center(
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
                    if (formKey.currentState!.validate() && formKey2.currentState!.validate()) {
                      await SettingsHandlerV3().setPreferences(Client.newPostalCode, controller_newPostalCode.text);
                      await SettingsHandlerV3().setPreferences(Client.address, controller_address.text);
                      await SettingsHandlerV3().setPreferences(Client.addressDetail, controller_addressDetail.text);
                      Navigator.pop(context);
                      print(controller_newPostalCode.text);
                      print(controller_address.text);
                      print(controller_addressDetail.text);

                      SettingsHandlerV3().log();
                    } else {}
                  },
                  child: Text('저장'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
