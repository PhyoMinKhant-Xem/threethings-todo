import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:threethings/objects/app_user.dart';
import 'package:threethings/objects/streak.dart';

class CalendarWeekWithProgressBar extends StatefulWidget {
  AppUser user;

  CalendarWeekWithProgressBar({required this.user});
  @override
  _CalendarWeekWithProgressBarState createState() =>
      _CalendarWeekWithProgressBarState();
}

class _CalendarWeekWithProgressBarState
    extends State<CalendarWeekWithProgressBar> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  final Map<DateTime, double> _progressMap = {
    DateTime.utc(2025, 2, 16): 0.3,
    DateTime.utc(2025, 2, 17): 0.7,
    DateTime.utc(2025, 2, 18): 1.0,
  };

  double _getProgressForDate(DateTime date) {
    Streak? streak = widget.user.streakList.firstWhere(
          (s) => s.date!.year == date.year && s.date!.month == date.month && s.date!.day == date.day,
      orElse: () => Streak(todoIds: [], numberOfTodosUserHasToday: widget.user.todoList.length, id: '', userEmail: widget.user.email),
    );

    if (streak.numberOfTodosUserHasToday == 0) return 0.0;
    return streak.todoIds.length / streak.numberOfTodosUserHasToday;
  }


  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[900] : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
      ),
      child: TableCalendar(
        firstDay: DateTime.utc(2010, 10, 16),
        lastDay: DateTime.utc(2030, 3, 14),
        focusedDay: _focusedDay,
        calendarFormat: CalendarFormat.week, // Force week view
        availableCalendarFormats: const {
          CalendarFormat.week: 'Week'
        }, // Remove other format options
        headerStyle: HeaderStyle(
          formatButtonVisible: false, // Remove format change button
          titleCentered: false,
          leftChevronVisible: true, // Remove left arrow
          rightChevronVisible: true, // Remove right arrow
          titleTextStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
        },
        onPageChanged: (focusedDay) {
          setState(() => _focusedDay = focusedDay);
        },
        calendarBuilders: CalendarBuilders(
          defaultBuilder: (context, date, _) {
            final progress = _getProgressForDate(date);
            final textColor = isDarkMode ? Colors.white : Colors.black;
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
      ),
    );
  }
}
