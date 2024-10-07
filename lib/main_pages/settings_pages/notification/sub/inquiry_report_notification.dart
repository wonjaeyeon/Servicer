import 'package:async/async.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:servicer/main_pages/settings_pages/notification/notification_settings.dart';
import 'package:servicer/main_pages/settings_pages/logics/settings_handler_v3.dart';
//import 'package:servicer/main_pages/settings_pages/settings_handler.dart';
import 'package:servicer/main_pages/settings_pages/logics/settings_handler_v3.dart';

import '../../../../design_standards/text_styles.dart';
import '../../logics/settings_definitions.dart';

class inquiryReportNotification extends StatefulWidget {
  @override
  _inquiryReportNotificationState createState() => _inquiryReportNotificationState();
}

class _inquiryReportNotificationState extends State<inquiryReportNotification> with SingleTickerProviderStateMixin {
  Future? _myFuture;

  /// settings values
  Enum? _inquiryReportNotificationFrequency;
  String? _inquiryReportNotificationHour;
  String? _inquiryReportNotificationMinute;
  String? _inquiryReportNotificationDayInBinary;
  bool _silentNotification = false;
  String? AMPM;

  Duration _animationDuration = Duration(milliseconds: 250);
  Curve _animationCurve = Curves.easeOutCirc;

  TimeOfDay _time = TimeOfDay.now();
  List<Text> __hourPickerItems = [];
  List<Text> __minutePickerItems = [];
  List<Text> __dayPickerItems = [];

  void __addHourPickerItems() {
    for (int i = 1; i <= 12; i++) {
      __hourPickerItems.add(Text(i.toString(), style: TextStyle(fontSize: 35)));
    }
  }

  void __addMinutePickerItems() {
    for (int i = 0; i < 60; i++) {
      __minutePickerItems.add(Text(
        (i < 10) ? '0$i' : '$i',
        style: TextStyle(fontSize: 35),
      ));
    }
  }

  void __addDayPickerItems() {
    ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'].forEach((day) {
      __dayPickerItems.add(Text(day, style: TextStyle(fontSize: 35)));
    });
  }

  @override
  void initState() {
    _myFuture = _fetchData();
    __addHourPickerItems();
    __addMinutePickerItems();
    __addDayPickerItems();
    super.initState();
  }

  Text _inquiryReportNotificationFrequencyText() {
    switch (_inquiryReportNotificationFrequency) {
      case NotificationFrequency.daily:
        return Text('매일 알림을 받습니다.');
      case NotificationFrequency.weekly:
        return Text('매주 알림을 받습니다.');
      case NotificationFrequency.off:
        return Text('알림을 받지 않습니다.');
      default:
        return Text('오류입니다.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('문의 및 리뷰 리포트 알림'),
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
      body: FutureBuilder(
          future: _myFuture,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Padding(
                padding: EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListView(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        children: [
                          ListTile(title: _inquiryReportNotificationFrequencyText()),
                          // make three blank sqare chip buttons in a row
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              FittedBox(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(width: 10),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: ChoiceChip(
                                        selectedColor: Color.fromARGB(255, 135, 149, 224),
                                        backgroundColor: Colors.black12,
                                        side: (_inquiryReportNotificationFrequency == NotificationFrequency.off)
                                            ? BorderSide(color: Colors.black, width: 1)
                                            : null,
                                        label: Column(
                                          children: [
                                            Icon(
                                              Icons.cancel,
                                              size: 45,
                                            ),
                                            Text('끔')
                                          ],
                                        ),
                                        selected: _inquiryReportNotificationFrequency == NotificationFrequency.off,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                        onSelected: (value) {
                                          setState(() {
                                            _inquiryReportNotificationFrequency = NotificationFrequency.off;
                                            SettingsHandlerV3().setPreferences(
                                                Notifications.inquiryReport_frequency, NotificationFrequency.off);
                                          });
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: ChoiceChip(
                                        selectedColor: Color.fromARGB(255, 135, 149, 224),
                                        backgroundColor: Colors.black12,
                                        side: (_inquiryReportNotificationFrequency == NotificationFrequency.weekly)
                                            ? BorderSide(color: Colors.black, width: 1)
                                            : null,
                                        label: Column(
                                          children: [
                                            Icon(
                                              Icons.calendar_month_rounded,
                                              size: 45,
                                            ),
                                            Text('매주')
                                          ],
                                        ),
                                        selected: _inquiryReportNotificationFrequency == NotificationFrequency.weekly,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                        onSelected: (value) {
                                          setState(() {
                                            _inquiryReportNotificationFrequency = NotificationFrequency.weekly;
                                            SettingsHandlerV3().setPreferences(
                                                Notifications.inquiryReport_frequency, NotificationFrequency.weekly);
                                          });
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: ChoiceChip(
                                        selectedColor: Color.fromARGB(255, 135, 149, 224),
                                        backgroundColor: Colors.black12,
                                        side: (_inquiryReportNotificationFrequency == NotificationFrequency.daily)
                                            ? BorderSide(color: Colors.black, width: 1)
                                            : null,
                                        label: Column(
                                          children: [
                                            Icon(
                                              Icons.calendar_today_rounded,
                                              size: 45,
                                            ),
                                            Text('매일')
                                          ],
                                        ),
                                        selected: _inquiryReportNotificationFrequency == NotificationFrequency.daily,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                        onSelected: (value) {
                                          setState(() {
                                            _inquiryReportNotificationFrequency = NotificationFrequency.daily;
                                            SettingsHandlerV3().setPreferences(
                                                Notifications.inquiryReport_frequency, NotificationFrequency.daily);
                                          });
                                        },
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                  ],
                                ),
                              ),
                              options(),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  Widget options() {
    Widget daysFilterChip({String label = '', int day = 0}) {
      return (_inquiryReportNotificationDayInBinary != null)
          ? FilterChip(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
              padding: EdgeInsets.all(4),
              labelPadding: EdgeInsets.all(4),
              label: Text(label,
                  style: TextStyle(
                    color: (_inquiryReportNotificationDayInBinary ?? '0000000')[day] == '1' ? Colors.white : Colors.black,
                    fontSize: 25,
                  )),
              onSelected: (value) {
                setState(() {
                  // exchange values of the day in binary
                  _inquiryReportNotificationDayInBinary = _inquiryReportNotificationDayInBinary!.substring(0, day) +
                      (_inquiryReportNotificationDayInBinary![day] == '1' ? '0' : '1') +
                      _inquiryReportNotificationDayInBinary!.substring(day + 1);
                  SettingsHandlerV3()
                      .setPreferences(Notifications.inquiryReport_days_list_inBinary, _inquiryReportNotificationDayInBinary);
                });
              },
              showCheckmark: false,
              selected: _inquiryReportNotificationDayInBinary![day] == '1',
              selectedColor: Color.fromARGB(255, 86, 112, 255),
            )
          : Container();
    }

    return Column(
      children: [
        /* weekly */
        AnimatedOpacity(
          duration: _animationDuration,
          curve: _animationCurve,
          opacity: _inquiryReportNotificationFrequency == NotificationFrequency.weekly ? 1 : 0,
          child: AnimatedContainer(
            height: _inquiryReportNotificationFrequency == NotificationFrequency.weekly ? 124 : 0,
            duration: _animationDuration,
            curve: _animationCurve,
            transform: _inquiryReportNotificationFrequency == NotificationFrequency.weekly
                ? Matrix4.translationValues(0, 0, 0)
                : Matrix4.translationValues(0, -15, 0),
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  ListTile(title: Text('알림 받을 요일')),
                  FittedBox(
                    child: Row(
                      children: [
                        daysFilterChip(label: '월', day: 0),
                        daysFilterChip(label: '화', day: 1),
                        daysFilterChip(label: '수', day: 2),
                        daysFilterChip(label: '목', day: 3),
                        daysFilterChip(label: '금', day: 4),
                        daysFilterChip(label: '토', day: 5),
                        daysFilterChip(label: '일', day: 6),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),

        /* daily */
        AnimatedOpacity(
          duration: _animationDuration,
          curve: _animationCurve,
          opacity: _inquiryReportNotificationFrequency != NotificationFrequency.off ? 1 : 0,
          child: AnimatedContainer(
            height: _inquiryReportNotificationFrequency != NotificationFrequency.off ? 242 : 0,
            duration: _animationDuration,
            curve: _animationCurve,
            transform: _inquiryReportNotificationFrequency != NotificationFrequency.off
                ? Matrix4.translationValues(0, 0, 0)
                : Matrix4.translationValues(0, -15, 0),
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  ListTile(title: Text('알림 받을 시간')),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 100,
                        width: 100,
                        // NOTE 오전 오후 선택
                        child: CupertinoPicker(
                          // initial value is first item using scrollcontroller
                          scrollController: FixedExtentScrollController(
                              initialItem: (int.parse(_inquiryReportNotificationHour ?? '0') < 12) ? 0 : 1),

                          useMagnifier: true,
                          magnification: 1.1,
                          itemExtent: 51.7,
                          diameterRatio: 1,
                          onSelectedItemChanged: (ampm) {
                            setState(() {
                              int hour = int.parse(_inquiryReportNotificationHour!);
                              if (ampm == 0) {
                                AMPM = 'AM';
                                _inquiryReportNotificationHour = (hour - 12).toString();
                                SettingsHandlerV3()
                                    .setPreferences(Notifications.inquiryReport_time_hour, _inquiryReportNotificationHour);
                              } else if (ampm == 1) {
                                AMPM = 'PM';
                                _inquiryReportNotificationHour = (hour + 12).toString();
                                SettingsHandlerV3()
                                    .setPreferences(Notifications.inquiryReport_time_hour, _inquiryReportNotificationHour);
                              }
                              print(AMPM);
                              print(_inquiryReportNotificationHour);
                            });
                          },
                          // add paddings to all text
                          children: [Text('오전', style: TextStyle(fontSize: 35)), Text('오후', style: TextStyle(fontSize: 35))]
                              .map((e) => Padding(padding: EdgeInsets.symmetric(vertical: 4), child: e))
                              .toList(),
                        ),
                      ),
                      SizedBox(
                        height: 100,
                        width: 60,
                        //* NOTE 시 선택
                        child: CupertinoPicker(
                          looping: true,
                          scrollController: FixedExtentScrollController(
                            initialItem: (int.parse(_inquiryReportNotificationHour!) <= 12)
                                ? int.parse(_inquiryReportNotificationHour!) - 1
                                : int.parse(_inquiryReportNotificationHour!) - 12 - 1,
                          ),

                          useMagnifier: true,
                          magnification: 1.1,
                          itemExtent: 51.7,
                          diameterRatio: 1,
                          onSelectedItemChanged: (hour) {
                            hour = hour + 1;
                            setState(() {
                              if (hour == 12) {
                                if (AMPM == 'AM') {
                                  _inquiryReportNotificationHour = '0';
                                } else if (AMPM == 'PM') {
                                  _inquiryReportNotificationHour = '12';
                                }
                              } else {
                                if (AMPM == 'PM') {
                                  _inquiryReportNotificationHour = (hour + 12).toString();
                                } else if (AMPM == 'AM') {
                                  _inquiryReportNotificationHour = hour.toString();
                                }
                                SettingsHandlerV3()
                                    .setPreferences(Notifications.inquiryReport_time_hour, _inquiryReportNotificationHour);
                              }
                              print(_inquiryReportNotificationHour);
                            });
                          },
                          // add paddings to all text
                          children: __hourPickerItems
                              .map((e) => Padding(padding: EdgeInsets.symmetric(vertical: 4), child: e))
                              .toList(),
                        ),
                      ),
                      Text('시', style: TextStyle(fontSize: 28)),
                      SizedBox(
                        height: 100,
                        width: 90,
                        child: CupertinoPicker(
                          scrollController:
                              FixedExtentScrollController(initialItem: int.parse(_inquiryReportNotificationMinute!)),
                          useMagnifier: true,
                          magnification: 1.1,
                          itemExtent: 51.7,
                          diameterRatio: 1,
                          onSelectedItemChanged: (minute) {
                            setState(() {
                              _inquiryReportNotificationMinute = minute.toString();
                              SettingsHandlerV3().setPreferences(Notifications.inquiryReport_time_minute, minute.toString());
                            });
                          },
                          looping: true,
                          // add paddings to all text
                          children: __minutePickerItems
                              .map((e) => Padding(padding: EdgeInsets.symmetric(vertical: 4), child: e))
                              .toList(),
                        ),
                      ),
                      Text('분', style: TextStyle(fontSize: 28)),
                    ],
                  ),
                  SizedBox(height: 10),
                  CheckboxListTile(
                    value: _silentNotification,
                    onChanged: (_) {
                      setState(() {
                        _silentNotification = !_silentNotification;
                        SettingsHandlerV3().setPreferences(Notifications.inquiryReport_silentMode, _silentNotification);
                      });
                    },
                    title: Text('조용한 알림'),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          alignment: Alignment.centerLeft,
          child: Text(
              '문의 및 리뷰 리포트 알림은 주기적으로 문의 및 리뷰 현황에 대한 종합적인 정보를 준비하여 보여 드리는 기능입니다. '
              '알림을 받을 시간을 설정하고, 알림을 받을 요일을 선택하면 알림을 받을 수 있습니다.',
              style: TextStyle(color: Colors.grey)),
        )
      ],
    );
  }

  Future<void> _fetchData() async {
    _inquiryReportNotificationFrequency = await SettingsHandlerV3().getPreferences(Notifications.inquiryReport_frequency);
    _inquiryReportNotificationHour = await SettingsHandlerV3().getPreferences(Notifications.inquiryReport_time_hour);
    int.parse(_inquiryReportNotificationHour!) < 12 ? AMPM = 'AM' : AMPM = 'PM';
    _inquiryReportNotificationMinute = await SettingsHandlerV3().getPreferences(Notifications.inquiryReport_time_minute);
    _inquiryReportNotificationDayInBinary =
        await SettingsHandlerV3().getPreferences(Notifications.inquiryReport_days_list_inBinary);
    _silentNotification = await SettingsHandlerV3().getPreferences(Notifications.inquiryReport_silentMode);
  }
}
