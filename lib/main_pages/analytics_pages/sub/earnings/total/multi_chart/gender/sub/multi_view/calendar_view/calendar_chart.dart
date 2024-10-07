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
  bool _isMale = true;
  bool _isFemale = true;
  final DataSource _dataSource = DataSource(<Appointment>[]);
  final List<Appointment> _maleAppointments = <Appointment>[];
  final List<Appointment> _femaleAppointments = <Appointment>[];
  late CalendarController _calendarController;

  @override
  initState() {
    _updateMaleAppointments();
    _dataSource.appointments!.addAll(_maleAppointments);
    _dataSource.notifyListeners(
        CalendarDataSourceAction.reset, _maleAppointments);
    _updateFemaleAppointments();
    _dataSource.appointments!.addAll(_femaleAppointments);
    _dataSource.notifyListeners(
        CalendarDataSourceAction.reset, _femaleAppointments);
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
          Row(
            children: <Widget>[
              Switch(
                value: _isMale,
                onChanged: (value) {
                  setState(() {
                    if (value) {
                      _updateMaleAppointments();
                      _dataSource.appointments!.addAll(_maleAppointments);
                      _dataSource.notifyListeners(
                          CalendarDataSourceAction.reset, _maleAppointments);
                    } else {
                      for (int i = 0; i < _maleAppointments.length; i++) {
                        _dataSource.appointments!.remove(_maleAppointments[i]);
                      }
                      _maleAppointments.clear();
                      _dataSource.notifyListeners(
                          CalendarDataSourceAction.reset, _maleAppointments);
                    }
                    _isMale = value;
                  });
                },
                activeTrackColor: Colors.blueAccent.withOpacity(0.5),
                activeColor: Colors.blueAccent,
              ),
              const Text('남자'),
            ],
          ),
          Row(
            children: <Widget>[
              Switch(
                value: _isFemale,
                onChanged: (value) {
                  setState(() {
                    if (value) {
                      _updateFemaleAppointments();
                      _dataSource.appointments!.addAll(_femaleAppointments);
                      _dataSource.notifyListeners(
                          CalendarDataSourceAction.reset, _femaleAppointments);
                    } else {
                      for (int i = 0; i < _femaleAppointments.length; i++) {
                        _dataSource.appointments!
                            .remove(_femaleAppointments[i]);
                      }
                      _femaleAppointments.clear();
                      _dataSource.notifyListeners(
                          CalendarDataSourceAction.reset, _femaleAppointments);
                    }
                    _isFemale = value;
                  });
                },
                activeTrackColor:
                    Color.fromARGB(255, 255, 114, 161).withOpacity(0.5),
                activeColor: Color.fromARGB(255, 255, 114, 161),
              ),
              const Text('여성'),
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

  void _updateMaleAppointments() {
    final Color profitColor = Colors.blueAccent;
    List<Appointment> _maleAppointmentsLoad = <Appointment>[
      Appointment(
          startTime: DateTime.now(),
          endTime: DateTime.now().add(const Duration(seconds: 1)),
          subject: '5만원',
          color: profitColor,
          location: "male",
          notes: "생각한 사이즈와 달라서 반품 요청합니다."),
      Appointment(
          startTime: DateTime(2023, 1, 1, 9, 0, 0),
          endTime: DateTime(2023, 1, 1, 11, 59, 59),
          subject: '8만원',
          color: profitColor,
          location: "male",
          notes: "생각한 사이즈와 달라서 반품 요청합니다."),
      Appointment(
          startTime: DateTime.now().add(const Duration(days: -2)),
          endTime: DateTime.now().add(const Duration(days: -2, seconds: 1)),
          subject: '10만원',
          color: profitColor,
          location: "male",
          notes: "생각한 사이즈와 달라서 반품 요청합니다."),
      Appointment(
          startTime: DateTime.now().add(const Duration(days: -1)),
          endTime: DateTime.now().add(const Duration(days: -1, seconds: 5)),
          subject: '12만원',
          color: profitColor,
          location: "male",
          notes: "생각한 사이즈와 달라서 반품 요청합니다."),
      Appointment(
          startTime: DateTime.now().add(const Duration(days: 3)),
          endTime: DateTime.now().add(const Duration(days: 3, seconds: 1)),
          subject: '10만원',
          color: profitColor,
          location: "male",
          notes: "생각한 사이즈와 달라서 반품 요청합니다.")
    ];

    _maleAppointments.addAll(_maleAppointmentsLoad);
  }

  void _updateFemaleAppointments() {
    final Color expenseColor = Color.fromARGB(255, 255, 114, 161);
    List<Appointment> _FemaleAppointmentsLoad = <Appointment>[
      Appointment(
          startTime: DateTime.now(),
          endTime: DateTime.now().add(const Duration(seconds: 1)),
          subject: '3만원',
          color: expenseColor,
          location: "Female",
          notes: "생각한 사이즈와 달라서 반품 요청합니다."),
      Appointment(
          startTime: DateTime.now().add(const Duration(days: -3)),
          endTime: DateTime.now().add(const Duration(days: -3, seconds: 1)),
          subject: '2만원',
          color: expenseColor,
          location: "Female",
          notes: "생각한 사이즈와 달라서 반품 요청합니다."),
      Appointment(
          startTime: DateTime.now().add(const Duration(days: -2)),
          endTime: DateTime.now().add(const Duration(days: -2, seconds: 1)),
          subject: '2만원',
          color: expenseColor,
          location: "Female",
          notes: "생각한 사이즈와 달라서 반품 요청합니다."),
      Appointment(
          startTime: DateTime.now().add(const Duration(
            days: -1,
          )),
          endTime: DateTime.now().add(const Duration(days: -1, seconds: 1)),
          subject: '2만원',
          color: expenseColor,
          location: "Female",
          notes: "생각한 사이즈와 달라서 반품 요청합니다."),
      Appointment(
          startTime: DateTime.now().add(const Duration(days: 3, seconds: 0)),
          endTime: DateTime.now().add(const Duration(days: 3, seconds: 1)),
          subject: '2만원',
          color: expenseColor,
          location: "Female",
          notes: "생각한 사이즈와 달라서 반품 요청합니다.")
    ];

    _femaleAppointments.addAll(_FemaleAppointmentsLoad);
  }
}

class DataSource extends CalendarDataSource {
  DataSource(List<Appointment> source) {
    appointments = source;
  }
}
