import 'package:flutter/material.dart';
import 'package:servicer/design_standards/colors.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../../../../../../../../MOD_PACKAGES/BH_touchFX/bh_touchfx.dart';
import '../../../../../../../../../../servicer_modules/shopping_mall_master.dart';

class CalendarViewChartV2 extends StatefulWidget {
  const CalendarViewChartV2({super.key});

  @override
  CalendarViewChartV2State createState() => CalendarViewChartV2State();
}

class CalendarViewChartV2State extends State<CalendarViewChartV2> {
  final DataSource _dataSource = DataSource(<Appointment>[]);
  final List<Appointment> _naverSmartStoreAppointments = <Appointment>[];
  final List<Appointment> _zigzagAppointments = <Appointment>[];
  final List<Appointment> _ablyAppointments = <Appointment>[];
  final List<Appointment> _coupangAppointments = <Appointment>[];
  late CalendarController _calendarController;

  @override
  initState() {
    _updateNaverSmartStoreAppointments();
    _dataSource.appointments!.addAll(_naverSmartStoreAppointments);
    _dataSource.notifyListeners(
        CalendarDataSourceAction.reset, _naverSmartStoreAppointments);

    _calendarController = CalendarController();
    _calendarController.selectedDate = DateTime.now();
    _calendarController.displayDate = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 800,
            child: SfCalendar(
              controller: _calendarController,
              timeSlotViewSettings:
                  TimeSlotViewSettings(timeIntervalHeight: -1),
              initialDisplayDate: DateTime.now(),
              view: CalendarView.month,
              // allowedViews: const [
              //   CalendarView.month,
              // ],
              dataSource: _dataSource,
              monthViewSettings: MonthViewSettings(
                  appointmentDisplayCount: 5,
                  appointmentDisplayMode:
                      MonthAppointmentDisplayMode.appointment),
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
                return Row(
                  children: [
                    const SizedBox(
                      width: 5,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color:
                            calendarAppointmentDetails.appointments.first.color,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4)),
                      ),
                      width: 6,
                      height: 6,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Text(
                        calendarAppointmentDetails.appointments.first.subject,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                );
              },
            ),
          )
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
          color: Color(0xFFe8f5e9),
          location: "NaverSmartStore",
          notes: "생각한 사이즈와 달라서 반품 요청합니다."),
      Appointment(
          startTime: DateTime(2023, 1, 1, 9, 0, 0),
          endTime: DateTime(2023, 1, 1, 11, 59, 59),
          subject: '8만원',
          color: Color(0xFF81c784),
          location: "NaverSmartStore",
          notes: "생각한 사이즈와 달라서 반품 요청합니다."),
      Appointment(
          startTime: DateTime.now().add(const Duration(days: -2)),
          endTime: DateTime.now().add(const Duration(days: -2, seconds: 1)),
          subject: '10만원',
          color: Color(0xFF43a047),
          location: "NaverSmartStore",
          notes: "생각한 사이즈와 달라서 반품 요청합니다."),
      Appointment(
          startTime: DateTime.now().add(const Duration(days: -1)),
          endTime: DateTime.now().add(const Duration(days: -1, seconds: 5)),
          subject: '12만원',
          color: Color(0xFF2e7d32),
          location: "NaverSmartStore",
          notes: "생각한 사이즈와 달라서 반품 요청합니다."),
      Appointment(
          startTime: DateTime.now().add(const Duration(days: 3)),
          endTime: DateTime.now().add(const Duration(days: 3, seconds: 1)),
          subject: '10만원',
          color: Color(0xFF66bb6a),
          location: "NaverSmartStore",
          notes: "생각한 사이즈와 달라서 반품 요청합니다."),
      Appointment(
          startTime: DateTime(2023, 2, 11, 9, 0, 0),
          endTime: DateTime(2023, 2, 11, 11, 59, 59),
          subject: '8만원',
          color: Color(0xFF81c784),
          location: "NaverSmartStore",
          notes: "생각한 사이즈와 달라서 반품 요청합니다."),
      Appointment(
          startTime: DateTime(2023, 2, 18, 9, 0, 0),
          endTime: DateTime(2023, 2, 18, 11, 59, 59),
          subject: '8만원',
          color: Color(0xFF81c784),
          location: "NaverSmartStore",
          notes: "생각한 사이즈와 달라서 반품 요청합니다."),
      Appointment(
          startTime: DateTime(2023, 2, 15, 9, 0, 0),
          endTime: DateTime(2023, 2, 15, 11, 59, 59),
          subject: '8만원',
          color: Color(0xFF81c784),
          location: "NaverSmartStore",
          notes: "생각한 사이즈와 달라서 반품 요청합니다."),
      Appointment(
          startTime: DateTime(2023, 2, 18, 9, 0, 0),
          endTime: DateTime(2023, 2, 18, 11, 59, 59),
          subject: '8만원',
          color: Color(0xFf388e3c),
          location: "NaverSmartStore",
          notes: "생각한 사이즈와 달라서 반품 요청합니다.")
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
          notes: "생각한 사이즈와 달라서 반품 요청합니다."),
      Appointment(
          startTime: DateTime(2023, 1, 1, 9, 0, 0),
          endTime: DateTime(2023, 1, 1, 11, 59, 59),
          subject: '8만원',
          color: zigzagColor,
          location: "Zigzag",
          notes: "생각한 사이즈와 달라서 반품 요청합니다."),
      Appointment(
          startTime: DateTime.now().add(const Duration(days: -2)),
          endTime: DateTime.now().add(const Duration(days: -2, seconds: 1)),
          subject: '10만원',
          color: zigzagColor,
          location: "Zigzag",
          notes: "생각한 사이즈와 달라서 반품 요청합니다."),
      Appointment(
          startTime: DateTime.now().add(const Duration(days: -1)),
          endTime: DateTime.now().add(const Duration(days: -1, seconds: 5)),
          subject: '12만원',
          color: zigzagColor,
          location: "Zigzag",
          notes: "생각한 사이즈와 달라서 반품 요청합니다."),
      Appointment(
          startTime: DateTime.now().add(const Duration(days: 3)),
          endTime: DateTime.now().add(const Duration(days: 3, seconds: 1)),
          subject: '10만원',
          color: zigzagColor,
          location: "Zigzag",
          notes: "생각한 사이즈와 달라서 반품 요청합니다.")
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
          notes: "생각한 사이즈와 달라서 반품 요청합니다."),
      Appointment(
          startTime: DateTime(2023, 1, 1, 9, 0, 0),
          endTime: DateTime(2023, 1, 1, 11, 59, 59),
          subject: '8만원',
          color: ablyColor,
          location: ablyLocation,
          notes: "생각한 사이즈와 달라서 반품 요청합니다."),
      Appointment(
          startTime: DateTime.now().add(const Duration(days: -2)),
          endTime: DateTime.now().add(const Duration(days: -2, seconds: 1)),
          subject: '10만원',
          color: ablyColor,
          location: ablyLocation,
          notes: "생각한 사이즈와 달라서 반품 요청합니다."),
      Appointment(
          startTime: DateTime.now().add(const Duration(days: -1)),
          endTime: DateTime.now().add(const Duration(days: -1, seconds: 5)),
          subject: '12만원',
          color: ablyColor,
          location: ablyLocation,
          notes: "생각한 사이즈와 달라서 반품 요청합니다."),
      Appointment(
          startTime: DateTime.now().add(const Duration(days: 3)),
          endTime: DateTime.now().add(const Duration(days: 3, seconds: 1)),
          subject: '10만원',
          color: ablyColor,
          location: ablyLocation,
          notes: "생각한 사이즈와 달라서 반품 요청합니다."),
      Appointment(
          startTime: DateTime(2023, 2, 21, 9, 0, 0),
          endTime: DateTime(2023, 2, 21, 11, 59, 59),
          subject: '8만원',
          color: ablyColor,
          location: ablyLocation,
          notes: "생각한 사이즈와 달라서 반품 요청합니다."),
      Appointment(
          startTime: DateTime.now().add(const Duration(days: 3)),
          endTime: DateTime.now().add(const Duration(days: 3, seconds: 1)),
          subject: '10만원',
          color: ablyColor,
          location: ablyLocation,
          notes: "생각한 사이즈와 달라서 반품 요청합니다.")
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
          notes: "생각한 사이즈와 달라서 반품 요청합니다."),
      Appointment(
          startTime: DateTime.now().add(const Duration(days: -3)),
          endTime: DateTime.now().add(const Duration(days: -3, seconds: 1)),
          subject: '2만원',
          color: coupangColor,
          location: "Coupang",
          notes: "생각한 사이즈와 달라서 반품 요청합니다."),
      Appointment(
          startTime: DateTime.now().add(const Duration(days: -2)),
          endTime: DateTime.now().add(const Duration(days: -2, seconds: 1)),
          subject: '2만원',
          color: coupangColor,
          location: "Coupang",
          notes: "생각한 사이즈와 달라서 반품 요청합니다."),
      Appointment(
          startTime: DateTime.now().add(const Duration(
            days: -1,
          )),
          endTime: DateTime.now().add(const Duration(days: -1, seconds: 1)),
          subject: '2만원',
          color: coupangColor,
          location: "Coupang",
          notes: "생각한 사이즈와 달라서 반품 요청합니다."),
      Appointment(
          startTime: DateTime.now().add(const Duration(days: 3, seconds: 0)),
          endTime: DateTime.now().add(const Duration(days: 3, seconds: 1)),
          subject: '2만원',
          color: coupangColor,
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
