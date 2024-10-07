import 'package:async/async.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:servicer/design_standards/colors.dart';
import 'package:servicer/design_standards/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:servicer/main_pages/settings_pages/notification/sub/logics/report_preferences_text_generator.dart';
import 'package:servicer/main_pages/settings_pages/notification/sub/returnRefundCancelExchange_report_notification.dart';
import 'package:servicer/main_pages/settings_pages/notification/sub/sales_report_notification.dart';
import 'package:servicer/main_pages/settings_pages/logics/settings_definitions.dart';
//import 'package:servicer/main_pages/settings_pages/settings_handler.dart';
import 'package:servicer/main_pages/settings_pages/logics/settings_handler_v3.dart';

import 'sub/inquiry_report_notification.dart';

class NotificationSettingsPage extends StatefulWidget {
  const NotificationSettingsPage({Key? key}) : super(key: key);

  @override
  NotificationSettingsPageState createState() => NotificationSettingsPageState();
}

class NotificationSettingsPageState extends State<NotificationSettingsPage> {
  Future? _myFuture;
  bool? _receiveServicerOfficialNotification;
  bool? _receiveServicerUsefulInformation;
  bool? _receiveServicerPersonalizedInformation;
  bool? _receiveServicerEventInformation;

  Enum? _salesReportFreq;
  String? _salesReportDayInBinary;
  String? _salesReportTimeHour;
  String? _salesReportTimeMinute;

  Enum? _returnReportFreq;
  String? _returnReportDayInBinary;
  String? _returnReportTimeHour;
  String? _returnReportTimeMinute;

  Enum? _inquiryReportFreq;
  String? _inquiryReportDayInBinary;
  String? _inquiryReportTimeHour;
  String? _inquiryReportTimeMinute;

  bool? _notifyWhileAppIsRunning;

  @override
  void initState() {
    _myFuture = _fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        title: Text('알림 설정'),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: $mediumFontSize,
        ),
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
      ),
      body: FutureBuilder(
          //stream: _fetchDataL(),
          future: _myFuture,
          builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              //print(snapshot.data);
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 12),
                    ListView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: ListTile.divideTiles(context: context, tiles: [
                        Column(
                          children: [
                            Container(
                              child: Text('일반', style: TextStyle(fontSize: 15)),
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.symmetric(horizontal: 14),
                            ),
                            SwitchListTile(
                              title: Text('서비서 공지사항 알림'),
                              subtitle: Text('서비서의 새 기능과 서비스에 대한 알림을 받습니다. '),
                              value: _receiveServicerOfficialNotification ?? false,
                              onChanged: (value) {
                                setState(() {
                                  _receiveServicerOfficialNotification = value;
                                  SettingsHandlerV3().setPreferences(Notifications.receiveServicerOfficialNotice, value);
                                });
                              },
                              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            ),
                          ],
                        ),
                        SwitchListTile(
                          title: Text('서비서 유용한 정보 알림'),
                          subtitle: Text('모든 셀러들에게 유용한 정보에 대한 알림을 받습니다. '),
                          value: _receiveServicerUsefulInformation ?? false,
                          onChanged: (value) {
                            setState(() {
                              _receiveServicerUsefulInformation = value;
                              SettingsHandlerV3().setPreferences(Notifications.receiveServicerUsefulInformation, value);
                            });
                          },
                          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        ),
                        SwitchListTile(
                          title: Text('서비서 개인 맞춤형 정보 알림'),
                          subtitle: Text('사용자만을 위한 맞춤형 정보에 대한 알림을 받습니다. '),
                          value: _receiveServicerPersonalizedInformation ?? false,
                          onChanged: (value) {
                            setState(() {
                              _receiveServicerPersonalizedInformation = value;
                              SettingsHandlerV3().setPreferences(Notifications.receiveServicerPersonalizedInformation, value);
                            });
                          },
                          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        ),
                        Column(
                          children: [
                            SwitchListTile(
                              title: Text('서비서 마케팅 및 이벤트 관련 알림'),
                              subtitle: Text('서비서가 준비한 이벤트들에 대한 알림을 받으며, 한정 이벤트에 참여할 수 있습니다. '),
                              value: _receiveServicerEventInformation ?? false,
                              onChanged: (value) {
                                setState(() {
                                  _receiveServicerEventInformation = value;
                                  SettingsHandlerV3().setPreferences(Notifications.receiveServicerEventInformation, value);
                                });
                              },
                              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            ),
                            SizedBox(height: 20),
                            Container(
                              child: Text('리포트', style: TextStyle(fontSize: 15)),
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.symmetric(horizontal: 14),
                            ),
                            ListTile(
                              title: Text('판매 리포트'),
                              subtitle: StreamBuilder(
                                stream: _fetchDataL(),
                                builder: (BuildContext context, AsyncSnapshot snapshot) {
                                  return Text(ReportPreferencesTextGenerator.generateWithTopicAndFrequency(
                                      _salesReportFreq!,
                                      _salesReportDayInBinary!,
                                      _salesReportTimeHour!,
                                      _salesReportTimeMinute!,
                                      '판매 리포트를 종합하여'));
                                },
                              ),
                              isThreeLine: false,
                              trailing: InkWell(child: Icon(CupertinoIcons.forward)),
                              onTap: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => SalesReportNotification()),
                                ).then((value) => setState(() {
                                      _fetchData();
                                    }));
                              },
                              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            ),
                          ],
                        ),
                        ListTile(
                          title: Text('반품, 환불, 취소 및 교환 리포트'),
                          subtitle: StreamBuilder(
                            stream: _fetchDataL(),
                            builder: (BuildContext context, AsyncSnapshot snapshot) {
                              return Text(ReportPreferencesTextGenerator.generateWithTopicAndFrequency(_returnReportFreq!,
                                  _returnReportDayInBinary!, _returnReportTimeHour!, _returnReportTimeMinute!, '리포트를 종합하여'));
                            },
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => returnReportNotification()),
                            ).then((value) => setState(() {
                                  _fetchData();
                                }));
                          },
                          trailing: InkWell(child: Icon(CupertinoIcons.forward)),
                        ),
                        ListTile(
                          title: Text('문의 및 리뷰 리포트'),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: StreamBuilder(
                                stream: _fetchDataL(),
                                builder: (BuildContext context, AsyncSnapshot snapshot) {
                                  return Text(ReportPreferencesTextGenerator.generateWithTopicAndFrequency(
                                      _inquiryReportFreq!,
                                      _inquiryReportDayInBinary!,
                                      _inquiryReportTimeHour!,
                                      _inquiryReportTimeMinute!,
                                      '문의 및 리뷰 리포트를 종합하여'));
                                }),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => inquiryReportNotification()),
                            ).then((value) => setState(() {
                                  _fetchData();
                                }));
                          },
                          trailing: InkWell(child: Icon(CupertinoIcons.forward)),
                        ),
                        CheckboxListTile(
                          title: Text('앱 실행 중에도 알림'),
                          value: _notifyWhileAppIsRunning ?? false,
                          onChanged: (value) {
                            setState(() {
                              SettingsHandlerV3().setPreferences(Notifications.receiveWhileUsingApp, value);
                              _notifyWhileAppIsRunning = value;
                            });
                          },
                        ),
                        // ElevatedButton(
                        //     onPressed: () {
                        //       Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPageAlarmDetailSettings()));
                        //     },
                        //     child: Text('asdf'))
                      ]).toList(),
                    ),
                  ],
                ),
              );
            }
            return Center(child: CircularProgressIndicator(color: Colors.red));
          }),
    );
  }

  Stream<List> _fetchDataL() async* {
    _receiveServicerOfficialNotification =
        await SettingsHandlerV3().getPreferences(Notifications.receiveServicerOfficialNotice);
    _receiveServicerUsefulInformation =
        await SettingsHandlerV3().getPreferences(Notifications.receiveServicerUsefulInformation);
    _receiveServicerPersonalizedInformation =
        await SettingsHandlerV3().getPreferences(Notifications.receiveServicerPersonalizedInformation);
    _receiveServicerEventInformation = await SettingsHandlerV3().getPreferences(Notifications.receiveServicerEventInformation);
    _salesReportFreq = await SettingsHandlerV3().getPreferences(Notifications.salesReport_frequency);
    _salesReportDayInBinary = await SettingsHandlerV3().getPreferences(Notifications.salesReport_days_list_inBinary);
    _salesReportTimeHour = await SettingsHandlerV3().getPreferences(Notifications.salesReport_time_hour);
    _salesReportTimeMinute = await SettingsHandlerV3().getPreferences(Notifications.salesReport_time_minute);
    _returnReportFreq = await SettingsHandlerV3().getPreferences(Notifications.returnReport_frequency);
    _returnReportDayInBinary = await SettingsHandlerV3().getPreferences(Notifications.returnReport_days_list_inBinary);
    _returnReportTimeHour = await SettingsHandlerV3().getPreferences(Notifications.returnReport_time_hour);
    _returnReportTimeMinute = await SettingsHandlerV3().getPreferences(Notifications.returnReport_time_minute);
    _inquiryReportFreq = await SettingsHandlerV3().getPreferences(Notifications.inquiryReport_frequency);
    _inquiryReportDayInBinary = await SettingsHandlerV3().getPreferences(Notifications.inquiryReport_days_list_inBinary);
    _inquiryReportTimeHour = await SettingsHandlerV3().getPreferences(Notifications.inquiryReport_time_hour);
    _inquiryReportTimeMinute = await SettingsHandlerV3().getPreferences(Notifications.inquiryReport_time_minute);
    _notifyWhileAppIsRunning = await SettingsHandlerV3().getPreferences(Notifications.receiveWhileUsingApp);
    yield [
      _receiveServicerOfficialNotification,
      _receiveServicerUsefulInformation,
      _receiveServicerPersonalizedInformation,
      _receiveServicerEventInformation,
      _salesReportFreq,
      _salesReportDayInBinary,
      _salesReportTimeHour,
      _salesReportTimeMinute,
      _returnReportFreq,
      _returnReportDayInBinary,
      _returnReportTimeHour,
      _returnReportTimeMinute,
      _inquiryReportFreq,
      _inquiryReportDayInBinary,
      _inquiryReportTimeHour,
      _inquiryReportTimeMinute,
      _notifyWhileAppIsRunning
    ];
  }

  Future<List> _fetchData() async {
    _receiveServicerOfficialNotification =
        await SettingsHandlerV3().getPreferences(Notifications.receiveServicerOfficialNotice);
    _receiveServicerUsefulInformation =
        await SettingsHandlerV3().getPreferences(Notifications.receiveServicerUsefulInformation);
    _receiveServicerPersonalizedInformation =
        await SettingsHandlerV3().getPreferences(Notifications.receiveServicerPersonalizedInformation);
    _receiveServicerEventInformation = await SettingsHandlerV3().getPreferences(Notifications.receiveServicerEventInformation);
    _salesReportFreq = await SettingsHandlerV3().getPreferences(Notifications.salesReport_frequency);
    _salesReportDayInBinary = await SettingsHandlerV3().getPreferences(Notifications.salesReport_days_list_inBinary);
    _salesReportTimeHour = await SettingsHandlerV3().getPreferences(Notifications.salesReport_time_hour);
    _salesReportTimeMinute = await SettingsHandlerV3().getPreferences(Notifications.salesReport_time_minute);
    _returnReportFreq = await SettingsHandlerV3().getPreferences(Notifications.returnReport_frequency);
    _returnReportDayInBinary = await SettingsHandlerV3().getPreferences(Notifications.returnReport_days_list_inBinary);
    _returnReportTimeHour = await SettingsHandlerV3().getPreferences(Notifications.returnReport_time_hour);
    _returnReportTimeMinute = await SettingsHandlerV3().getPreferences(Notifications.returnReport_time_minute);
    _inquiryReportFreq = await SettingsHandlerV3().getPreferences(Notifications.inquiryReport_frequency);
    _inquiryReportDayInBinary = await SettingsHandlerV3().getPreferences(Notifications.inquiryReport_days_list_inBinary);
    _inquiryReportTimeHour = await SettingsHandlerV3().getPreferences(Notifications.inquiryReport_time_hour);
    _inquiryReportTimeMinute = await SettingsHandlerV3().getPreferences(Notifications.inquiryReport_time_minute);
    _notifyWhileAppIsRunning = await SettingsHandlerV3().getPreferences(Notifications.receiveWhileUsingApp);
    return [
      _receiveServicerOfficialNotification,
      _receiveServicerUsefulInformation,
      _receiveServicerPersonalizedInformation,
      _receiveServicerEventInformation,
      _salesReportFreq,
      _salesReportDayInBinary,
      _salesReportTimeHour,
      _salesReportTimeMinute,
      _returnReportFreq,
      _returnReportDayInBinary,
      _returnReportTimeHour,
      _returnReportTimeMinute,
      _inquiryReportFreq,
      _inquiryReportDayInBinary,
      _inquiryReportTimeHour,
      _inquiryReportTimeMinute,
      _notifyWhileAppIsRunning
    ];
  }
}
