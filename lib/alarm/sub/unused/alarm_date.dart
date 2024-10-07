import 'package:flutter/material.dart';
import 'package:servicer/MOD_PACKAGES/BH_touchFX/bh_touchfx.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class ADate extends StatefulWidget {
  const ADate({super.key});

  @override
  State<ADate> createState() => _ADateState();
}

class _ADateState extends State<ADate> {
  late CalendarController _calendarController;
  @override
  initState() {
    super.initState();
    _calendarController = CalendarController();
    _calendarController.selectedDate = DateTime.now();
    _calendarController.displayDate = DateTime.now().add(Duration(days: 30));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      width: MediaQuery.of(context).size.width,
      child: SfCalendar(
        allowedViews: const <CalendarView>[
          CalendarView.day,
          CalendarView.workWeek,
          CalendarView.week,
          CalendarView.month,
          CalendarView.timelineDay,
          CalendarView.timelineWeek,
          CalendarView.timelineWorkWeek,
          CalendarView.timelineMonth,
          CalendarView.schedule
        ],
        monthViewSettings: MonthViewSettings(showAgenda: true),
        timeSlotViewSettings:
            TimeSlotViewSettings(timelineAppointmentHeight: 100),
        controller: _calendarController,
        appointmentBuilder: (context, details) {
          return Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: BHTouchFXListTile(
              leading: Icon(Icons.question_answer),
              //make a title with appointment's property subject
              title: Text("${details.date}"),
              subtitle: Column(
                children: [
                  Text("${details.appointments.first.subject}"),
                  Text("${details.appointments.first.startTime}"),
                  Text("b"),
                ],
              ),
              trailing: Icon(Icons.more_vert),
              isThreeLine: true,
              //dense: true,
            ),
          );
        },

        // loadMoreWidgetBuilder: (context, loadMoreAppointments) => Container(
        //   height: 50,
        //   width: 50,
        //   child: Center(
        //     child: CircularProgressIndicator(),
        //   ),
        // ),
        dataSource: DataSource(getEventData()),
        // scheduleViewMonthHeaderBuilder: (context, details) => Container(
        //   height: 50,
        //   width: 50,
        //   child: Center(
        //     child: CircularProgressIndicator(),
        //   ),
        // ),
        minDate: DateTime(2021, 01, 01),
        view: CalendarView.schedule,
        scheduleViewSettings: const ScheduleViewSettings(
            appointmentItemHeight: 90,
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

            // appointmentItemHeight: 70,
            // weekHeaderSettings: WeekHeaderSettings(
            //     startDateFormat: 'dd MMM ',
            //     endDateFormat: 'dd MMM, yy',
            //     height: 20,
            //     textAlign: TextAlign.center,
            //     backgroundColor: Colors.red,
            //     weekTextStyle: TextStyle(
            //       color: Colors.white,
            //       fontWeight: FontWeight.w400,
            //       fontSize: 15,
            //     )),
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
      ),
    );
  }

  List<Appointment> getEventData() {
    // List<Appointment> appointments = <Appointment>[
    //   Appointment(DateTime(2017, 09, 7, 17, 30), DateTime(2018, 09, 7, 17, 30),
    //       "쿠팡1", Colors.red),
    //   Appointment(DateTime(2017, 10, 7, 17, 30), DateTime(2018, 09, 7, 17, 30),
    //       "에이블리2", Colors.red),
    //   Appointment(DateTime(2017, 09, 7, 17, 30), DateTime(2018, 09, 7, 17, 30),
    //       "쿠팡3", Colors.red),
    // ];

    // return DataSource(appointments);
    List<Appointment> meetings = <Appointment>[];
    final DateTime today = DateTime.now();
    final DateTime startTime =
        DateTime(today.year, today.month, today.day, 9, 0, 0);
    final DateTime endTime = startTime.add(const Duration(hours: 2));

    meetings.add(Appointment(startTime, endTime, 'Meeting', Colors.blue));
    meetings.add(Appointment(startTime.add(const Duration(hours: 3)),
        endTime.add(const Duration(hours: 3)), 'Planning', Colors.green));
    meetings.add(Appointment(DateTime(2022, 01, 01, 9, 0, 0),
        endTime.add(const Duration(hours: 4)), 'Support', Colors.red));
    return meetings;
  }
}

class CalendarC extends CalendarController {
  CalendarC() : super();

  @override
  void onLongPress(DateTime date) {
    print("onLongPress");
  }

  @override
  void onTap(DateTime date) {
    print("onTap");
  }

  void addEvent() {
    print("addEvent");
  }
}

class DataSource extends CalendarDataSource {
  // DataSource(List<Appointment> source) {
  //   appointments = source;
  //   Appointment a = source[0];
  //   appointments!.add(source[0]);
  //   appointments!.add(source[1]);
  // }
  //make a Constructor DataSource with List<Appointment> source
  DataSource(List<Appointment> source) {
    //
    appointments = source;
  }
}

class Appointment {
  Appointment(
    this.startTime,
    this.endTime,
    this.subject,
    this.color,
  );
  final DateTime startTime;
  final DateTime endTime;
  final String subject;
  final Color color;
}
