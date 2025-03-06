import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:threethings/components/calendar_progress.dart';
import 'package:threethings/components/daily_streak.dart';
import 'package:threethings/methods/database_methods/user_methods.dart';
import 'package:threethings/objects/app_user.dart';

class OverviewScreen extends StatelessWidget {
  final String _id = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AppUser?>(
      stream: getUserDetail(_id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data == null) {
          print("DEBUG: No user data received!");
          return Center(child: Text("User not found!"));
        }

        AppUser user = snapshot.data!;
        print("DEBUG: User data updated -> ${user.todoList.length} tasks");

        return Scaffold(
          body: Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DailyStreakScreen(streakCount: user.streak,), // Direct call without SizedBox
                  SizedBox(height: 30),
                  SizedBox(
                    child: CalendarWithProgressBar(user: user,),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
