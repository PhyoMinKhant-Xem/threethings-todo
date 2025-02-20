import 'package:flutter/material.dart';
import 'package:threethings/components/Task/task_list_screen.dart';
import 'package:threethings/components/calendar_week_progress.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              // Adjust based on your design
              child: CalendarWeekWithProgressBar(),
            ),
            SizedBox(height: 20),
            Expanded(
              // Ensures TaskListScreen takes available space
              child: TaskListScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
