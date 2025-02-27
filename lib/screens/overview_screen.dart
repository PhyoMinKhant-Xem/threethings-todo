import 'package:flutter/material.dart';

import 'package:threethings/components/calendar_progress.dart';
import 'package:threethings/components/daily_streak.dart';

class OverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DailyStreakScreen(), // Direct call without SizedBox
              SizedBox(height: 30),
              SizedBox(
                child: CalendarWithProgressBar(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
