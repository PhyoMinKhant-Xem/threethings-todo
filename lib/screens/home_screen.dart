import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:threethings/components/Task/task_list_screen.dart';
import 'package:threethings/components/calendar_week_progress.dart';
import 'package:threethings/methods/database_methods/user_methods.dart';
import 'package:threethings/objects/app_user.dart';

class HomeScreen extends StatefulWidget {

  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _id = FirebaseAuth.instance.currentUser!.uid;

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
          body: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  child: CalendarWeekWithProgressBar(),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: TaskListScreen(user: user), // Pass updated user
                ),
              ],
            ),
          ),
        );
      },
    );

  }
}
