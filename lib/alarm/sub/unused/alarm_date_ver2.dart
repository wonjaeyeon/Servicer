// ignore_for_file: void_checks

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:http/http.dart' as http;

import '../../../MOD_PACKAGES/BH_touchFX/bh_touchfx.dart';

class ADateV2 extends StatefulWidget {
  const ADateV2({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ADateV2State();
}

class _ADateV2State extends State<ADateV2> {
  final MeetingDataSource _events = MeetingDataSource(<_Meeting>[]);
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
        controller: _calendarController,
        timeSlotViewSettings: TimeSlotViewSettings(timeIntervalHeight: -1),
        initialDisplayDate: DateTime(2017, 05, 01),
        view: CalendarView.month,
        allowedViews: const [
          CalendarView.day,
          CalendarView.week,
          CalendarView.workWeek,
          CalendarView.month,
          CalendarView.timelineDay,
          CalendarView.timelineWeek,
          CalendarView.timelineWorkWeek,
          CalendarView.timelineMonth,
          CalendarView.schedule,
        ],
        dataSource: _events,
        loadMoreWidgetBuilder: loadMoreWidget,
        monthViewSettings: const MonthViewSettings(
            appointmentDisplayMode: MonthAppointmentDisplayMode.indicator),
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
        allowAppointmentResize: true,
        appointmentBuilder: (context, calendarAppointmentDetails) => Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: BHTouchFXListTile(
            leading: Icon(Icons.question_answer),
            //make a title with appointment's property subject
            title: Text("${calendarAppointmentDetails.date}"),
            subtitle: Column(
              children: [
                Text(
                    "${calendarAppointmentDetails.appointments.first.eventName}"),
                Text("${calendarAppointmentDetails.appointments.first.from}"),
                Text("b"),
              ],
            ),
            trailing: Icon(Icons.more_vert),
            isThreeLine: true,
            //dense: true,
          ),
        ),
      ),
    );
  }

  Widget loadMoreWidget(
      BuildContext context, LoadMoreCallback loadMoreAppointments) {
    return FutureBuilder<void>(
      initialData: 'loading',
      future: loadMoreAppointments(),
      builder: (context, snapShot) {
        return Container(
            alignment: Alignment.center,
            child: const CircularProgressIndicator());
      },
    );
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(this.source);

  List<_Meeting> source;

  @override
  List<dynamic> get appointments => source;

  @override
  DateTime getStartTime(int index) {
    return source[index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return source[index].to;
  }

  @override
  bool isAllDay(int index) {
    return source[index].isAllDay;
  }

  @override
  String getSubject(int index) {
    return source[index].eventName;
  }

  @override
  Color getColor(int index) {
    return source[index].background;
  }

  //테스트를 위한 임시 코드
  List<_Meeting> getEvents() {
    List<_Meeting> appointments = <_Meeting>[
      _Meeting("쿠팡알림", DateTime(2023, 1, 6, 10, 10),
          DateTime(2023, 1, 6, 23, 59), Colors.red, false),
      _Meeting(
          "지그알림",
          DateTime(2022, 09, 10, 10, 10),
          DateTime(2022, 09, 11, 10, 10),
          Color.fromARGB(255, 40, 37, 37),
          false),
    ];

    return appointments;
  }

  //실제로 사용할 함수
  // @override
  // Future<void> handleLoadMore(DateTime startDate, DateTime endDate) async {
  //   await Future<void>.delayed(const Duration(seconds: 1));
  //   http.Response data = await http.get(Uri.parse(
  //       "https://js.syncfusion.com/demos/ejservices/api/Schedule/LoadData"));
  //   dynamic jsonData = json.decode(data.body);

  //   final List<_Meeting> appointmentData = [];
  //   for (dynamic data in jsonData) {
  //     _Meeting meetingData = _Meeting(
  //         data['Subject'],
  //         _convertDateFromString(
  //           data['StartTime'],
  //         ),
  //         _convertDateFromString(data['EndTime']),
  //         Colors.red,
  //         data['AllDay']);
  //     appointmentData.add(meetingData);
  //   }

  //   appointments.addAll(appointmentData);
  //   notifyListeners(CalendarDataSourceAction.add, appointmentData);
  // }

  //테스트로 사용할 함수
  @override
  Future<void> handleLoadMore(DateTime startDate, DateTime endDate) async {
    //await Future<void>.delayed(const Duration(seconds: 1));
    List<_Meeting> listData = getEvents();
    final List<_Meeting> appointmentData = getEvents();
    // for (dynamic data in listData) {
    //   _Meeting meetingData = _Meeting(
    //       data['eventName'],
    //       _convertDateFromString(
    //         data['from'],
    //       ),
    //       _convertDateFromString(data['to']),
    //       Colors.red,
    //       data['AllDay']);
    //   appointmentData.add(meetingData);
    // }
    //check if appointments contains the appointment data
    //get the current appointments in SfCalendar

    print(appointments);
    if (source.contains(appointmentData) == true) {
      return;
    }
    appointments.addAll(appointmentData);
    notifyListeners(CalendarDataSourceAction.add, appointmentData);
  }

  DateTime _convertDateFromString(String date) {
    return DateTime.parse(date);
  }
}

class _Meeting {
  _Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}
