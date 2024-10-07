import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../../../../../../../../MOD_PACKAGES/BH_touchFX/bh_touchfx.dart';
import '../../../../../../../../../../servicer_modules/shopping_mall_master.dart';

class ScheduleViewChart extends StatefulWidget {
  const ScheduleViewChart({super.key});

  @override
  ScheduleViewChartState createState() => ScheduleViewChartState();
}

class ScheduleViewChartState extends State<ScheduleViewChart> {
  bool _isNaverSmartStore = false;
  bool _isZigzag = false;
  bool _isAbly = false;
  bool _isCoupang = false;
  final DataSource _dataSource = DataSource(<Appointment>[]);
  final List<Appointment> _naverSmartStoreAppointments = <Appointment>[];
  final List<Appointment> _zigzagAppointments = <Appointment>[];
  final List<Appointment> _ablyAppointments = <Appointment>[];
  final List<Appointment> _coupangAppointments = <Appointment>[];
  late CalendarController _calendarController;

  @override
  initState() {
    super.initState();
    _calendarController = CalendarController();
    _calendarController.selectedDate = DateTime.now();
    _calendarController.displayDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Switch(
                value: _isNaverSmartStore,
                onChanged: (value) {
                  setState(() {
                    if (value) {
                      _updateNaverSmartStoreAppointments();
                      _dataSource.appointments!
                          .addAll(_naverSmartStoreAppointments);
                      _dataSource.notifyListeners(
                          CalendarDataSourceAction.reset,
                          _naverSmartStoreAppointments);
                    } else {
                      for (int i = 0;
                          i < _naverSmartStoreAppointments.length;
                          i++) {
                        _dataSource.appointments!
                            .remove(_naverSmartStoreAppointments[i]);
                      }
                      _naverSmartStoreAppointments.clear();
                      _dataSource.notifyListeners(
                          CalendarDataSourceAction.reset,
                          _naverSmartStoreAppointments);
                    }
                    _isNaverSmartStore = value;
                  });
                },
                activeTrackColor: mallMaster
                    .themeColorOf(Mall.NaverSmartStore)
                    .withOpacity(0.5),
                activeColor: mallMaster.themeColorOf(Mall.NaverSmartStore),
              ),
              const Text('스마트스토어'),
            ],
          ),
          Row(
            children: <Widget>[
              Switch(
                value: _isZigzag,
                onChanged: (value) {
                  setState(() {
                    if (value) {
                      _updateZigzagAppointments();
                      _dataSource.appointments!.addAll(_zigzagAppointments);
                      _dataSource.notifyListeners(
                          CalendarDataSourceAction.reset, _zigzagAppointments);
                    } else {
                      for (int i = 0; i < _zigzagAppointments.length; i++) {
                        _dataSource.appointments!
                            .remove(_zigzagAppointments[i]);
                      }
                      _zigzagAppointments.clear();
                      _dataSource.notifyListeners(
                          CalendarDataSourceAction.reset, _zigzagAppointments);
                    }
                    _isZigzag = value;
                  });
                },
                activeTrackColor:
                    mallMaster.themeColorOf(Mall.Zigzag).withOpacity(0.5),
                activeColor: mallMaster.themeColorOf(Mall.Zigzag),
              ),
              const Text('지그재그'),
            ],
          ),
          Row(
            children: <Widget>[
              Switch(
                value: _isAbly,
                onChanged: (value) {
                  setState(() {
                    if (value) {
                      _updateAblyAppointments();
                      _dataSource.appointments!.addAll(_ablyAppointments);
                      _dataSource.notifyListeners(
                          CalendarDataSourceAction.reset, _ablyAppointments);
                    } else {
                      for (int i = 0; i < _ablyAppointments.length; i++) {
                        _dataSource.appointments!.remove(_ablyAppointments[i]);
                      }
                      _ablyAppointments.clear();
                      _dataSource.notifyListeners(
                          CalendarDataSourceAction.reset, _ablyAppointments);
                    }
                    _isAbly = value;
                  });
                },
                activeTrackColor:
                    mallMaster.themeColorOf(Mall.Ably).withOpacity(0.5),
                activeColor: mallMaster.themeColorOf(Mall.Ably),
              ),
              const Text('에이블리'),
            ],
          ),
          Row(
            children: <Widget>[
              Switch(
                value: _isCoupang,
                onChanged: (value) {
                  setState(() {
                    if (value) {
                      _updateCoupangAppointments();
                      _dataSource.appointments!.addAll(_coupangAppointments);
                      _dataSource.notifyListeners(
                          CalendarDataSourceAction.reset, _coupangAppointments);
                    } else {
                      for (int i = 0; i < _coupangAppointments.length; i++) {
                        _dataSource.appointments!
                            .remove(_coupangAppointments[i]);
                      }
                      _coupangAppointments.clear();
                      _dataSource.notifyListeners(
                          CalendarDataSourceAction.reset, _coupangAppointments);
                    }
                    _isCoupang = value;
                  });
                },
                activeTrackColor:
                    mallMaster.themeColorOf(Mall.Coupang).withOpacity(0.5),
                activeColor: mallMaster.themeColorOf(Mall.Coupang),
              ),
              const Text('쿠팡'),
            ],
          ),
          Expanded(
              child: SfCalendar(
                  controller: _calendarController,
                  timeSlotViewSettings:
                      TimeSlotViewSettings(timeIntervalHeight: -1),
                  initialDisplayDate: DateTime.now(),
                  view: CalendarView.schedule,
                  dataSource: _dataSource,
                  monthViewSettings: const MonthViewSettings(
                      appointmentDisplayMode:
                          MonthAppointmentDisplayMode.indicator),
                  scheduleViewSettings: const ScheduleViewSettings(
                      appointmentItemHeight: 100,
                      hideEmptyScheduleWeek: true,
                      appointmentTextStyle: TextStyle(
                        fontFamily: "IBM Plex Sans",
                      ),
                      dayHeaderSettings: DayHeaderSettings(
                          dayFormat: 'EEE',
                          dayTextStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          )),

                      //how to represent the month header
                      monthHeaderSettings: MonthHeaderSettings(
                          monthFormat: 'MMMM, yyyy',
                          //not going to show the month header
                          height: 0,
                          textAlign: TextAlign.left,
                          backgroundColor: Colors.green,
                          monthTextStyle: TextStyle(
                              color: Colors.red,
                              fontSize: 25,
                              fontWeight: FontWeight.w400))),
                  allowAppointmentResize: true,
                  appointmentBuilder: (context, calendarAppointmentDetails) {
                    final Mall mallName = mallMaster.mallOf(
                        calendarAppointmentDetails
                            .appointments.first.location!);
                    return BHTouchFXListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: SizedBox(
                          width: 40,
                          height: 40,
                          child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              child: mallMaster.smallImgOf(mallName)),
                        ),
                      ),
                      //make a title with appointment's property subject
                      title: Text(
                        "${calendarAppointmentDetails.appointments.first.subject}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                          "${calendarAppointmentDetails.appointments.first.notes}"),
                      //trailing: Icon(Icons.more_vert),
                      //isThreeLine: true,
                      //dense: true,
                    );
                  }))
        ],
      ),
    );
  }

  void _updateNaverSmartStoreAppointments() {
    final Color smartStoreColor = mallMaster.themeColorOf(Mall.NaverSmartStore);
    List<Appointment> _naverSmartStoreAppointmentsLoad = <Appointment>[
      Appointment(
          startTime: DateTime.now(),
          endTime: DateTime.now().add(const Duration(seconds: 1)),
          subject: '5만원',
          color: smartStoreColor,
          location: "NaverSmartStore",
          notes: "오리털 덕 패딩조끼"),
      Appointment(
          startTime: DateTime(2023, 1, 1, 9, 0, 0),
          endTime: DateTime(2023, 1, 1, 11, 59, 59),
          subject: '8만원',
          color: smartStoreColor,
          location: "NaverSmartStore",
          notes: "겨울 울 수트 셋업"),
      Appointment(
          startTime: DateTime.now().add(const Duration(days: -2)),
          endTime: DateTime.now().add(const Duration(days: -2, seconds: 1)),
          subject: '10만원',
          color: smartStoreColor,
          location: "NaverSmartStore",
          notes: "코딩 단가라 울 니트 외 1"),
      Appointment(
          startTime: DateTime.now().add(const Duration(days: -1)),
          endTime: DateTime.now().add(const Duration(days: -1, seconds: 5)),
          subject: '12만원',
          color: smartStoreColor,
          location: "NaverSmartStore",
          notes: "포근한 베베 울 니트 외 1"),
      Appointment(
          startTime: DateTime.now().add(const Duration(days: 3)),
          endTime: DateTime.now().add(const Duration(days: 3, seconds: 1)),
          subject: '10만원',
          color: smartStoreColor,
          location: "NaverSmartStore",
          notes: "오버핏 니트 후드 티셔츠 외 1")
    ];

    _naverSmartStoreAppointments.addAll(_naverSmartStoreAppointmentsLoad);
  }

  void _updateZigzagAppointments() {
    final Color zigzagColor = mallMaster.themeColorOf(Mall.Zigzag);
    List<Appointment> _zigzagAppointmentsLoad = <Appointment>[
      Appointment(
          startTime: DateTime.now(),
          endTime: DateTime.now().add(const Duration(seconds: 1)),
          subject: '5만원',
          color: zigzagColor,
          location: "Zigzag",
          notes: "셔링 레더 크롭 자켓"),
      Appointment(
          startTime: DateTime(2023, 1, 1, 9, 0, 0),
          endTime: DateTime(2023, 1, 1, 11, 59, 59),
          subject: '8만원',
          color: zigzagColor,
          location: "Zigzag",
          notes: "포인트 레더 자켓 외 1"),
      Appointment(
          startTime: DateTime.now().add(const Duration(days: -2)),
          endTime: DateTime.now().add(const Duration(days: -2, seconds: 1)),
          subject: '10만원',
          color: zigzagColor,
          location: "Zigzag",
          notes: "오버핏 니트 후드 티셔츠 외 1"),
      Appointment(
          startTime: DateTime.now().add(const Duration(days: -1)),
          endTime: DateTime.now().add(const Duration(days: -1, seconds: 5)),
          subject: '12만원',
          color: zigzagColor,
          location: "Zigzag",
          notes: "포근한 베베 울 니트 외 2"),
      Appointment(
          startTime: DateTime.now().add(const Duration(days: 3)),
          endTime: DateTime.now().add(const Duration(days: 3, seconds: 1)),
          subject: '10만원',
          color: zigzagColor,
          location: "Zigzag",
          notes: "오버핏 니트 후드 티셔츠 외 1")
    ];

    _zigzagAppointments.addAll(_zigzagAppointmentsLoad);
  }

  void _updateAblyAppointments() {
    final Color ablyColor = mallMaster.themeColorOf(Mall.Ably);
    final String ablyLocation = 'Ably';
    List<Appointment> _ablyAppointmentsLoad = <Appointment>[
      Appointment(
          startTime: DateTime.now(),
          endTime: DateTime.now().add(const Duration(seconds: 1)),
          subject: '5만원',
          color: ablyColor,
          location: ablyLocation,
          notes: "오리털 덕 패딩조끼"),
      Appointment(
          startTime: DateTime(2023, 1, 1, 9, 0, 0),
          endTime: DateTime(2023, 1, 1, 11, 59, 59),
          subject: '8만원',
          color: ablyColor,
          location: ablyLocation,
          notes: "포인트 레더 자켓 외 1"),
      Appointment(
          startTime: DateTime.now().add(const Duration(days: -2)),
          endTime: DateTime.now().add(const Duration(days: -2, seconds: 1)),
          subject: '10만원',
          color: ablyColor,
          location: ablyLocation,
          notes: "오버핏 니트 후드 티셔츠 외 1"),
      Appointment(
          startTime: DateTime.now().add(const Duration(days: -1)),
          endTime: DateTime.now().add(const Duration(days: -1, seconds: 5)),
          subject: '12만원',
          color: ablyColor,
          location: ablyLocation,
          notes: "포근한 베베 울 니트 외 2"),
      Appointment(
          startTime: DateTime.now().add(const Duration(days: 3)),
          endTime: DateTime.now().add(const Duration(days: 3, seconds: 1)),
          subject: '10만원',
          color: ablyColor,
          location: ablyLocation,
          notes: "오버핏 니트 후드 티셔츠 외 1")
    ];

    _ablyAppointments.addAll(_ablyAppointmentsLoad);
  }

  void _updateCoupangAppointments() {
    final Color coupangColor = mallMaster.themeColorOf(Mall.Coupang);
    List<Appointment> _coupangAppointmentsLoad = <Appointment>[
      Appointment(
          startTime: DateTime.now(),
          endTime: DateTime.now().add(const Duration(seconds: 1)),
          subject: '3만원',
          color: coupangColor,
          location: "Coupang",
          notes: "오버핏 니트 후드 티셔츠"),
      Appointment(
          startTime: DateTime.now().add(const Duration(days: -3)),
          endTime: DateTime.now().add(const Duration(days: -3, seconds: 1)),
          subject: '2만원',
          color: coupangColor,
          location: "Coupang",
          notes: "브이넥 니트 후드 티셔츠"),
      Appointment(
          startTime: DateTime.now().add(const Duration(days: -2)),
          endTime: DateTime.now().add(const Duration(days: -2, seconds: 1)),
          subject: '2만원',
          color: coupangColor,
          location: "Coupang",
          notes: "진청 밴딩 9부 일자 데님 팬츠"),
      Appointment(
          startTime: DateTime.now().add(const Duration(
            days: -1,
          )),
          endTime: DateTime.now().add(const Duration(days: -1, seconds: 1)),
          subject: '2만원',
          color: coupangColor,
          location: "Coupang",
          notes: "포인트 레더 자켓"),
      Appointment(
          startTime: DateTime.now().add(const Duration(days: 3, seconds: 0)),
          endTime: DateTime.now().add(const Duration(days: 3, seconds: 1)),
          subject: '2만원',
          color: coupangColor,
          location: "Coupang",
          notes: "오버핏 니트 후드 티셔츠")
    ];

    _coupangAppointments.addAll(_coupangAppointmentsLoad);
  }
}

class DataSource extends CalendarDataSource {
  DataSource(List<Appointment> source) {
    appointments = source;
  }
}
