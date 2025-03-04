import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:threethings/objects/app_user.dart';
import 'package:threethings/objects/streak.dart';

class CalendarWithProgressBar extends StatefulWidget {
  AppUser user;

  CalendarWithProgressBar({required this.user});

  @override
  _CalendarWithProgressBarState createState() =>
      _CalendarWithProgressBarState();
}

class _CalendarWithProgressBarState extends State<CalendarWithProgressBar> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  late Map<DateTime, double> _progressMap;

  @override
  void initState() {
    super.initState();
    _progressMap = _generateProgressMap(widget.user.streakList);
  }

  Map<DateTime, double> _generateProgressMap(List<Streak> streakList) {
    Map<DateTime, double> progressMap = {};

    for (Streak streak in streakList) {
      if (streak.date != null && streak.numberOfTodosUserHasToday > 0) {
        double progress =
            streak.todoIds.length / streak.numberOfTodosUserHasToday;
        progressMap[DateTime.utc(
                streak.date!.year, streak.date!.month, streak.date!.day)] =
            progress;
      }
    }

    return progressMap;
  }

  double _getProgressForDate(DateTime date) {
    return _progressMap[DateTime.utc(date.year, date.month, date.day)] ?? 0.0;
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return TableCalendar(
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2030, 3, 14),
      focusedDay: _focusedDay,
      calendarFormat: CalendarFormat.month,
      // Force week view
      availableCalendarFormats: const {CalendarFormat.month: 'Month'},
      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDay = selectedDay;
          _focusedDay = focusedDay;
        });
      },
      onFormatChanged: (format) {},
      onPageChanged: (focusedDay) {
        setState(() => _focusedDay = focusedDay);
      },

      headerStyle: HeaderStyle(
        formatButtonVisible: false, // Remove format change button
        titleCentered: false,
        // leftChevronVisible: false,
        // rightChevronVisible: false,
        titleTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      calendarBuilders: CalendarBuilders(
        defaultBuilder: (context, date, _) {
          final progress = _getProgressForDate(date);
          final textColor = isDarkMode ? Colors.white : Colors.black;
          final bgColor = isDarkMode ? Colors.grey[800]! : Colors.grey[300]!;

          return Container(
            width: 48,
            height: 48,
            margin: EdgeInsets.symmetric(vertical: 4),
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (progress > 0)
                  SizedBox(
                    height: 45,
                    width: 45,
                    child: CircularPercentIndicator(
                      radius: 20,
                      lineWidth: 4,
                      percent: progress,
                      progressColor: Colors.green,
                      backgroundColor: bgColor,
                      circularStrokeCap: CircularStrokeCap.round,
                    ),
                  ),
                Text(
                  date.day.toString(),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
              ],
            ),
          );
        },
        selectedBuilder: (context, date, _) {
          final progress = _getProgressForDate(date);
          final textColor =
              Colors.blue[200]; // Change text color for selected date
          final bgColor = isDarkMode ? Colors.grey[800]! : Colors.grey[300]!;

          return Container(
            width: 48,
            height: 48,
            margin: EdgeInsets.all(4),
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (progress > 0)
                  SizedBox(
                    height: 45,
                    width: 45,
                    child: CircularPercentIndicator(
                      radius: 20,
                      lineWidth: 4,
                      percent: progress,
                      progressColor: Colors.green,
                      backgroundColor: bgColor,
                      circularStrokeCap: CircularStrokeCap.round,
                    ),
                  ),
                Text(
                  date.day.toString(),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: textColor, // Apply selected text color
                  ),
                ),
              ],
            ),
          );
        },
        todayBuilder: (context, date, _) {
          final progress = _getProgressForDate(date);
          final textColor =
              Colors.blue[600]; // Change text color for today's date
          final bgColor = isDarkMode ? Colors.grey[800]! : Colors.grey[300]!;

          return Container(
            width: 48,
            height: 48,
            margin: EdgeInsets.all(4),
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (progress > 0)
                  SizedBox(
                    height: 45,
                    width: 45,
                    child: CircularPercentIndicator(
                      radius: 20,
                      lineWidth: 4,
                      percent: progress,
                      progressColor: Colors.green,
                      backgroundColor: bgColor,
                      circularStrokeCap: CircularStrokeCap.round,
                    ),
                  ),
                Text(
                  date.day.toString(),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: textColor, // Apply today's text color
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
