import 'dart:math';

import 'package:flutter/material.dart';
import 'package:slark_v2/components/customAppBar.dart';
import 'package:slark_v2/constraints.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class GanttChart extends StatefulWidget {
  const GanttChart({Key? key}) : super(key: key);

  @override
  _GanttChartState createState() => _GanttChartState();
}

class _GanttChartState extends State<GanttChart> {
  late MeetingDataSource _events;
  late List<Appointment> _shiftCollection;

  late List<CalendarResource> _employeeCalendarResource;
  late List<TimeRegion> _specialTimeRegions;

  @override
  void initState() {
    addResourceDetails();
    addAppointments();
    addSpecialRegions();
    _events = MeetingDataSource(_shiftCollection, _employeeCalendarResource);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SfCalendar(
          view: CalendarView.timelineMonth,
          firstDayOfWeek: 1,
          timeSlotViewSettings: TimeSlotViewSettings(startHour: 9, endHour: 18),
          dataSource: _events,
          specialRegions: _specialTimeRegions,
          headerHeight: 100,
          appointmentTextStyle: TextStyle(fontSize: 25),
          //  appointmentTextStyle = const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w500, fontFamily: 'Roboto')
        ),
      ),
    );
  }

  void addAppointments() {
    var tasksCollection = [
      'General Meeting',
      'Plan Execution',
      'Project Plan',
      'Consulting',
      'Support',
      'Development Meeting',
      'Scrum',
      'Project Completion',
      'Release updates',
      'Performance Check'
    ];

    var colorCollection = [
      const Color(0xFF0F8644),
      const Color(0xFF1E88E5),
      const Color(0xFF8B1FA9),
      const Color(0xFFD20100),
      const Color(0xFFFC571D),
      const Color(0xFF85461E),
      const Color(0xFF36B37B),
      const Color(0xFF3D4FB5),
      const Color(0xFFE47C73),
      const Color(0xFF636363)
    ];

    _shiftCollection = <Appointment>[];
    for (var calendarResource in _employeeCalendarResource) {
      var employeeIds = [calendarResource.id];

      for (int j = 0; j < 365; j++) {
        for (int k = 0; k < 2; k++) {
          final DateTime date = DateTime.now().add(Duration(days: j + k));
          int startHour = 9 + Random().nextInt(6);
          startHour =
              startHour >= 13 && startHour <= 14 ? startHour + 1 : startHour;
          final DateTime _shiftStartTime =
              DateTime(date.year, date.month, date.day, startHour, 0, 0);
          _shiftCollection.add(Appointment(
              startTime: _shiftStartTime,
              endTime: _shiftStartTime.add(Duration(days: 2)),
              subject: tasksCollection[Random().nextInt(10)],
              color: colorCollection[Random().nextInt(9)],
              startTimeZone: '',
              endTimeZone: '',
              resourceIds: employeeIds));
        }
      }
    }
  }

  void addResourceDetails() {
    var nameCollection = [
      'John',
      'Bryan',
      'Robert',
      'Kenny',
      'Tia',
      'Theresa',
      'Edith',
      'Brooklyn',
      // 'James William',
      // 'Sophia',
      // 'Elena',
      // 'Stephen',
      // 'Zoey Addison',
      // 'Daniel',
      // 'Emilia',
      // 'Kinsley Elena',
      // 'Danieals',
      // 'William',
      // 'Addison',
      // 'Ruby'
    ];

    var userImages = [
      // 'assets/images/u1.jpg',
      'assets/images/People_Circle8.png',
      'assets/images/People_Circle18.png',
      'assets/images/People_Circle23.png',
      'assets/images/People_Circle25.png',
      'assets/images/People_Circle20.png',
      'assets/images/People_Circle13.png',
      'assets/images/People_Circle11.png',
      'assets/images/People_Circle27.png',
      'assets/images/People_Circle26.png',
      // 'assets/images/People_Circle24.png',
      // 'assets/images/People_Circle15.png',
    ];

    _employeeCalendarResource = <CalendarResource>[];
    for (var i = 0; i < nameCollection.length; i++) {
      _employeeCalendarResource.add(CalendarResource(
          id: '000' + i.toString(),
          displayName: nameCollection[i],
          color: Color.fromRGBO(Random().nextInt(255), Random().nextInt(255),
              Random().nextInt(255), 1),
          image:
              i < userImages.length ? ExactAssetImage(userImages[i]) : null));
    }
  }

  void addSpecialRegions() {
    final DateTime date = DateTime.now();
    _specialTimeRegions = [
      TimeRegion(
          startTime: DateTime(date.year, date.month, date.day, 13, 0, 0),
          endTime: DateTime(date.year, date.month, date.day, 14, 0, 0),
          text: 'Lunch',
          resourceIds: _employeeCalendarResource.map((e) => e.id).toList(),
          recurrenceRule: 'FREQ=DAILY;INTERVAL=1',
          enablePointerInteraction: false)
    ];
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> shiftCollection,
      List<CalendarResource> employeeCalendarResource) {
    appointments = shiftCollection;
    resources = employeeCalendarResource;
  }
}
