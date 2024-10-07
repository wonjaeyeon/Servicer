import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:servicer/main_pages/login_page.dart';
import 'package:servicer/main_pages/settings_pages/lock_screen/set_lockscreen.dart';
import 'package:servicer/main_pages/settings_pages/logics/settings_handler_v3.dart';

import '../../../design_standards/text_styles.dart';
import '../logics/settings_definitions.dart';
import 'sub/set_client_address.dart';
import 'sub/set_client_email.dart';
import 'sub/set_client_name.dart';
import 'sub/set_client_phone.dart';

class SettingPageClientInfo extends StatefulWidget {
  const SettingPageClientInfo({Key? key}) : super(key: key);

  @override
  SettingPageClientInfoState createState() => SettingPageClientInfoState();
}

class SettingPageClientInfoState extends State<SettingPageClientInfo> {
  Future? myFuture;
  String? clientNameData;
  String? clientEmailData;
  String? clientPhoneData;
  String? clientNewPostalCodeData;
  String? clientAddressData;
  String? clientAddressDetailData;
  Enum? clientLockScreenData;

  @override
  void initState() {
    myFuture = _fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('회원 정보'),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: $mediumFontSize,
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text('잠금 화면 설정'),
                trailing: FutureBuilder(
                  future: SettingsHandlerV3()
                      .getPreferences(Security.lockScreenType),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    print(snapshot.data);
                    clientLockScreenData = snapshot.data;
                    switch (clientLockScreenData) {
                      case LockScreenType.none:
                        return Text('없음');
                      case LockScreenType.pin:
                        return Text('PIN');
                      case LockScreenType.bio:
                        return Text('생체 인식 및 PIN');
                      default:
                        return Text('없음');
                    }
                  },
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          settings: RouteSettings(name: "set_lock_screen"),
                          builder: (context) => SetLockScreen())).then((_) {
                    setState(() {});
                  });
                },
              ),
              SizedBox(height: 24),
              Container(
                child: Text('일반', style: TextStyle(fontSize: 15)),
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 14),
              ),
              ListTile(
                title: Text('이메일'),
                trailing: FutureBuilder(
                  future: SettingsHandlerV3().getPreferences(Client.email),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      clientEmailData = snapshot.data;
                      return Text(snapshot.data);
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
                onTap: () {
                  (clientEmailData != null)
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SetClientEmail(
                                  initialValue_: clientEmailData))).then((_) {
                          setState(() {});
                        })
                      : () {};
                },
              ),
              Divider(height: 0),
              ListTile(
                title: Text('성명'),
                trailing: FutureBuilder(
                  future: SettingsHandlerV3().getPreferences(Client.name),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      clientNameData = snapshot.data;
                      return Text(snapshot.data);
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
                onTap: () {
                  (clientNameData != null)
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SetClientName(
                                  initialValue_: clientNameData))).then((_) {
                          setState(() {});
                        })
                      : () {};
                },
              ),
              Divider(height: 0),
              ListTile(
                title: Text('전화번호'),
                trailing: FutureBuilder(
                  future: SettingsHandlerV3().getPreferences(Client.phone),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      clientPhoneData = snapshot.data;
                      return Text((clientPhoneData!.length == 10)
                          ? '${clientPhoneData!.substring(0, 3)}-${clientPhoneData!.substring(3, 6)}-${clientPhoneData!.substring(6, 10)}'
                          : '${clientPhoneData!.substring(0, 3)}-${clientPhoneData!.substring(3, 7)}-${clientPhoneData!.substring(7, 11)}');
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
                onTap: () {
                  (clientPhoneData != null)
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SetClientPhone(
                                  initialValue_: clientPhoneData))).then((_) {
                          setState(() {});
                        })
                      : () {};
                },
              ),
              Divider(height: 0),
              ListTile(
                title: Text('주소'),
                trailing: FutureBuilder<List<String>>(
                  future: Future(() async {
                    clientAddressData = await SettingsHandlerV3()
                        .getPreferences(Client.address);
                    clientAddressDetailData = await SettingsHandlerV3()
                        .getPreferences(Client.addressDetail);
                    clientNewPostalCodeData = await SettingsHandlerV3()
                        .getPreferences(Client.newPostalCode);
                    return [
                      clientAddressData ?? '',
                      clientAddressDetailData ?? '',
                      clientNewPostalCodeData ?? ''
                    ];
                  }),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      clientAddressData = snapshot.data[0];
                      clientAddressDetailData = snapshot.data[1];
                      clientNewPostalCodeData = snapshot.data[2];
                      return SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerRight,
                          child: Text(
                            (clientAddressDetailData != '')
                                ? '$clientAddressData \n$clientAddressDetailData ($clientNewPostalCodeData)'
                                : '$clientAddressData ($clientNewPostalCodeData)',
                            textAlign: TextAlign.right,
                            softWrap: true,
                          ),
                        ),
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
                onTap: () {
                  (clientAddressDetailData != null && clientAddressData != null)
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SetClientAddress(
                                  initialValue_newPostalCode:
                                      clientNewPostalCodeData,
                                  initialValue_address: clientAddressData,
                                  initialValue_addressDetail:
                                      clientAddressDetailData))).then((_) {
                          setState(() {});
                        })
                      : () {};
                },
              ),
              Divider(height: 0),
              ListTile(
                title: Text('상호명'),
                trailing: Text('시리즈서로 >'),
                onTap: () {},
              ),
              Divider(height: 0),
              ListTile(
                title: Text('나이'),
                trailing: Text('24 >'),
                onTap: () {},
              ),
              Divider(height: 0),
              ListTile(
                title: Text('사업자 등록번호'),
                trailing: Text('111-11-11111 >'),
                onTap: () {},
              ),
              Divider(height: 0),
              ListTile(
                title: Text('판매자 카테고리'),
                trailing: Text('의류,쇼핑 외 2 >'),
                onTap: () {},
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.centerLeft,
                child: Text(
                    '제공된 개인정보는 개인 식별, 정보 제공 및 맞춤형 솔루션 제공에만 사용되며 '
                    '그 이외의 목적으로는 사용되지 않습니다. ',
                    style: TextStyle(color: Colors.grey)),
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  try {
                    Amplify.Auth.signOut().then((_) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                          (route) => false);
                    });
                  } catch (e) {
                    // error when plugin is not added
                    print(e);
                  }
                },
                child: Text('로그아웃'),
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 4)),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _fetchData() async {
    clientNameData = await SettingsHandlerV3().getPreferences(Client.name);
    clientPhoneData = await SettingsHandlerV3().getPreferences(Client.phone);
    clientAddressData =
        await SettingsHandlerV3().getPreferences(Client.address);
    clientAddressDetailData =
        await SettingsHandlerV3().getPreferences(Client.addressDetail);
    clientNewPostalCodeData =
        await SettingsHandlerV3().getPreferences(Client.newPostalCode);
    clientLockScreenData =
        await SettingsHandlerV3().getPreferences(Security.lockScreenType);
  }
}
