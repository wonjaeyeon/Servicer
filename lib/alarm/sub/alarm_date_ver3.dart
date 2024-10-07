import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../MOD_PACKAGES/BH_touchFX/bh_touchfx.dart';
import '../../servicer_modules/shopping_mall_master.dart';

class ADateV3 extends StatefulWidget {
  const ADateV3({super.key});

  @override
  ADateV3State createState() => ADateV3State();
}

class ADateV3State extends State<ADateV3> {
  bool _isZigzag = false;
  bool _isCoupang = false;
  final DataSource _dataSource = DataSource(<Appointment>[]);
  final List<Appointment> _zigzagAppointments = <Appointment>[];
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
              const Text('지그재그 알림'),
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
              const Text('쿠팡 알림'),
            ],
          ),
          Expanded(
              child: SfCalendar(
                  controller: _calendarController,
                  timeSlotViewSettings:
                      TimeSlotViewSettings(timeIntervalHeight: -1),
                  initialDisplayDate: DateTime.now(),
                  view: CalendarView.schedule,
                  allowedViews: const [
                    //CalendarView.day,
                    //CalendarView.week,
                    //CalendarView.workWeek,
                    CalendarView.month,
                    //CalendarView.timelineDay,
                    //CalendarView.timelineWeek,
                    //CalendarView.timelineWorkWeek,
                    //CalendarView.timelineMonth,
                    CalendarView.schedule,
                  ],
                  dataSource: _dataSource,
                  monthViewSettings: const MonthViewSettings(
                      appointmentDisplayMode:
                          MonthAppointmentDisplayMode.indicator),
                  scheduleViewSettings: const ScheduleViewSettings(
                      appointmentItemHeight: 120,
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
                    return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: BHTouchFXListTile(
                        leading: SizedBox(
                            width: 40,
                            height: 40,
                            child: mallMaster.smallImgOf(mallName)),
                        //make a title with appointment's property subject
                        title: Text(
                            "${calendarAppointmentDetails.appointments.first.subject}"),
                        subtitle: Column(
                          children: [
                            Text(
                                "${calendarAppointmentDetails.appointments.first.notes}"),
                          ],
                        ),
                        trailing: Icon(Icons.more_vert),
                        isThreeLine: true,
                        //dense: true,
                      ),
                    );
                  }))
        ],
      ),
    );
  }

  void _updateZigzagAppointments() {
    List<Appointment> _zigzagAppointmentsLoad = <Appointment>[
      Appointment(
          startTime: DateTime.now(),
          endTime: DateTime.now().add(const Duration(hours: 1)),
          subject: 'Zigzag 반품 요청이 들어왔습니다.',
          color: mallMaster.themeColorOf(Mall.Zigzag),
          location: "Zigzag",
          notes: "생각한 사이즈와 달라서 반품 요청합니다."),
      Appointment(
          startTime: DateTime(2023, 1, 1, 9, 0, 0),
          endTime: DateTime(2023, 1, 1, 11, 59, 59),
          subject: 'Zigzag 상품 문의가 들어왔습니다.',
          color: mallMaster.themeColorOf(Mall.Zigzag),
          location: "Zigzag",
          notes: "생각한 사이즈와 달라서 반품 요청합니다."),
      Appointment(
          startTime: DateTime.now().add(const Duration(days: -2, hours: 5)),
          endTime: DateTime.now().add(const Duration(days: -2, hours: 6)),
          subject: 'Zigzag 상품 문의가 들어왔습니다.',
          color: mallMaster.themeColorOf(Mall.Zigzag),
          location: "Zigzag",
          notes: "생각한 사이즈와 달라서 반품 요청합니다."),
      Appointment(
          startTime: DateTime.now().add(const Duration(days: -1, hours: 4)),
          endTime: DateTime.now().add(const Duration(days: -1, hours: 5)),
          subject: 'Zigzag 상품 문의가 들어왔습니다.',
          color: mallMaster.themeColorOf(Mall.Zigzag),
          location: "Zigzag",
          notes: "생각한 사이즈와 달라서 반품 요청합니다."),
      Appointment(
          startTime: DateTime.now().add(const Duration(days: 3, hours: 8)),
          endTime: DateTime.now().add(const Duration(days: 3, hours: 9)),
          subject: 'Zigzag 반품 요청이 들어왔습니다.',
          color: mallMaster.themeColorOf(Mall.Zigzag),
          location: "Zigzag",
          notes: "생각한 사이즈와 달라서 반품 요청합니다.")
    ];

    _zigzagAppointments.addAll(_zigzagAppointmentsLoad);
  }

  void _updateCoupangAppointments() {
    List<Appointment> _coupangAppointmentsLoad = <Appointment>[
      Appointment(
          startTime: DateTime.now(),
          endTime: DateTime.now().add(const Duration(hours: 1)),
          subject: 'Coupang 반품 문의가 들어왔습니다.',
          color: mallMaster.themeColorOf(Mall.Coupang),
          location: "Coupang",
          notes: "생각한 사이즈와 달라서 반품 요청합니다."),
      Appointment(
          startTime: DateTime.now().add(const Duration(days: -3, hours: 6)),
          endTime: DateTime.now().add(const Duration(days: -3, hours: 7)),
          subject: 'Coupang 상품 후기가 올라왔습니다.',
          color: mallMaster.themeColorOf(Mall.Coupang),
          location: "Coupang",
          notes: "생각한 사이즈와 달라서 반품 요청합니다."),
      Appointment(
          startTime: DateTime.now().add(const Duration(days: -2, hours: 5)),
          endTime: DateTime.now().add(const Duration(days: -2, hours: 6)),
          subject: 'Coupang 반품 문의가 들어왔습니다.',
          color: mallMaster.themeColorOf(Mall.Coupang),
          location: "Coupang",
          notes: "생각한 사이즈와 달라서 반품 요청합니다."),
      Appointment(
          startTime: DateTime.now().add(const Duration(days: -1, hours: 4)),
          endTime: DateTime.now().add(const Duration(days: -1, hours: 5)),
          subject: 'Coupang 반품 문의가 들어왔습니다.',
          color: mallMaster.themeColorOf(Mall.Coupang),
          location: "Coupang",
          notes: "생각한 사이즈와 달라서 반품 요청합니다."),
      Appointment(
          startTime: DateTime.now().add(const Duration(days: 3, hours: 8)),
          endTime: DateTime.now().add(const Duration(days: 3, hours: 9)),
          subject: 'Coupang 반품 문의가 들어왔습니다.',
          color: mallMaster.themeColorOf(Mall.Coupang),
          location: "Coupang",
          notes: "생각한 사이즈와 달라서 반품 요청합니다.")
    ];

    _coupangAppointments.addAll(_coupangAppointmentsLoad);
  }
}

class DataSource extends CalendarDataSource {
  DataSource(List<Appointment> source) {
    appointments = source;
  }
}
