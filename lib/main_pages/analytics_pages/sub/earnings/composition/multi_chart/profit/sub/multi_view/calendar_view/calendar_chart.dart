import 'package:flutter/material.dart';
import 'package:servicer/design_standards/colors.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../../../../../../../../MOD_PACKAGES/BH_touchFX/bh_touchfx.dart';
import '../../../../../../../../../../servicer_modules/shopping_mall_master.dart';

class CalendarViewChart extends StatefulWidget {
  const CalendarViewChart({super.key});

  @override
  CalendarViewChartState createState() => CalendarViewChartState();
}

class CalendarViewChartState extends State<CalendarViewChart> {
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
                activeTrackColor: Color(0xff5985B5).withOpacity(0.5),
                activeColor: Color(0xff5985B5),
              ),
              const Text('수익'),
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
                activeTrackColor: Color(0xFFFCC7A91).withOpacity(0.5),
                activeColor: Color(0xFFFCC7A91),
              ),
              const Text('비용'),
            ],
          ),
          Container(
            height: 600,
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
              // monthCellBuilder:
              //     (BuildContext buildContext, MonthCellDetails details) {
              //   if (details.appointments.isNotEmpty) {
              //     Appointment appointment =
              //         details.appointments[0] as Appointment;
              //     return Row(
              //       children: [
              //         Container(
              //           decoration: BoxDecoration(
              //             color: appointment.color,
              //             borderRadius:
              //                 const BorderRadius.all(Radius.circular(4)),
              //           ),
              //           width: 6,
              //           height: 6,
              //         ),
              //         const SizedBox(
              //           width: 5,
              //         ),
              //         Expanded(
              //           child: Text(
              //             appointment.location!,
              //             overflow: TextOverflow.ellipsis,
              //             style: const TextStyle(
              //                 color: Colors.black,
              //                 fontSize: 8,
              //                 fontWeight: FontWeight.w400),
              //           ),
              //         ),
              //       ],
              //     );
              //   }
              //   return Container(
              //     color: $$lightGrey,
              //     child: Text(details.date.day.toString()),
              //   );
              // },
            ),
          )
        ],
      ),
    );
  }

  void _updateZigzagAppointments() {
    final Color profitColor = Color(0xff5985B5);
    List<Appointment> _zigzagAppointmentsLoad = <Appointment>[
      Appointment(
          startTime: DateTime.now(),
          endTime: DateTime.now().add(const Duration(seconds: 1)),
          subject: '5만원',
          color: profitColor,
          location: "Zigzag",
          notes: "생각한 사이즈와 달라서 반품 요청합니다."),
      Appointment(
          startTime: DateTime(2023, 1, 1, 9, 0, 0),
          endTime: DateTime(2023, 1, 1, 11, 59, 59),
          subject: '8만원',
          color: profitColor,
          location: "Zigzag",
          notes: "생각한 사이즈와 달라서 반품 요청합니다."),
      Appointment(
          startTime: DateTime.now().add(const Duration(days: -2)),
          endTime: DateTime.now().add(const Duration(days: -2, seconds: 1)),
          subject: '10만원',
          color: profitColor,
          location: "Zigzag",
          notes: "생각한 사이즈와 달라서 반품 요청합니다."),
      Appointment(
          startTime: DateTime.now().add(const Duration(days: -1)),
          endTime: DateTime.now().add(const Duration(days: -1, seconds: 5)),
          subject: '12만원',
          color: profitColor,
          location: "Zigzag",
          notes: "생각한 사이즈와 달라서 반품 요청합니다."),
      Appointment(
          startTime: DateTime.now().add(const Duration(days: 3)),
          endTime: DateTime.now().add(const Duration(days: 3, seconds: 1)),
          subject: '10만원',
          color: profitColor,
          location: "Zigzag",
          notes: "생각한 사이즈와 달라서 반품 요청합니다.")
    ];

    _zigzagAppointments.addAll(_zigzagAppointmentsLoad);
  }

  void _updateCoupangAppointments() {
    final Color expenseColor = Color(0xFFFCC7A91);
    List<Appointment> _coupangAppointmentsLoad = <Appointment>[
      Appointment(
          startTime: DateTime.now(),
          endTime: DateTime.now().add(const Duration(seconds: 1)),
          subject: '3만원',
          color: expenseColor,
          location: "Coupang",
          notes: "생각한 사이즈와 달라서 반품 요청합니다."),
      Appointment(
          startTime: DateTime.now().add(const Duration(days: -3)),
          endTime: DateTime.now().add(const Duration(days: -3, seconds: 1)),
          subject: '2만원',
          color: expenseColor,
          location: "Coupang",
          notes: "생각한 사이즈와 달라서 반품 요청합니다."),
      Appointment(
          startTime: DateTime.now().add(const Duration(days: -2)),
          endTime: DateTime.now().add(const Duration(days: -2, seconds: 1)),
          subject: '2만원',
          color: expenseColor,
          location: "Coupang",
          notes: "생각한 사이즈와 달라서 반품 요청합니다."),
      Appointment(
          startTime: DateTime.now().add(const Duration(
            days: -1,
          )),
          endTime: DateTime.now().add(const Duration(days: -1, seconds: 1)),
          subject: '2만원',
          color: expenseColor,
          location: "Coupang",
          notes: "생각한 사이즈와 달라서 반품 요청합니다."),
      Appointment(
          startTime: DateTime.now().add(const Duration(days: 3, seconds: 0)),
          endTime: DateTime.now().add(const Duration(days: 3, seconds: 1)),
          subject: '2만원',
          color: expenseColor,
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
