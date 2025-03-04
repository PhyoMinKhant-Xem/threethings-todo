import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:threethings/methods/database_methods/user_methods.dart';
import 'package:threethings/objects/streak.dart';
import 'package:threethings/objects/app_user.dart';
import 'package:threethings/utils/custom_response.dart';

FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;
CollectionReference userReference = firebaseFireStore.collection("users");

Future<CustomResponse<Streak>> tweakStreak(AppUser user, int todoId) async {
  CustomResponse<Streak> response =
  CustomResponse.fail<Streak>("Error Message Not Provided!");

  try {
    DateTime today = DateTime.now();
    print("Today's Date: $today");

    // Check if streak needs to be reset (if lastStreakDay isn't yesterday)
    if (user.lastStreakDay == null || !user.wasStreakYesterday()) {
      print("Streak is being reset because last streak day isn't yesterday.");
      user.streak = 0;
    }

    // Get today's streak or create a new one
    Streak todayStreak = user.streakList.firstWhere(
          (streak) =>
      streak.date?.year == today.year &&
          streak.date?.month == today.month &&
          streak.date?.day == today.day,
      orElse: () => Streak(
        id: (user.streakList.length + 1).toString(),
        todoIds: [],
        userEmail: user.email,
        numberOfTodosUserHasToday: user.todoList.length,
        date: DateTime.now(),
      ),
    );

    print("Today's Streak: ${todayStreak.streakId}");

    // Toggle the todoId in today's streak
    if (todayStreak.todoIds.contains(todoId)) {
      print("TodoId $todoId already exists in today's streak. Removing it.");
      todayStreak.todoIds.remove(todoId);

      // If a todo was removed and the streak was fully completed before, reduce the streak
      if (user.todoList.length > todayStreak.todoIds.length) {
        print("A todo was unmarked. Decreasing the streak.");

        // Ensure the streak never goes below 0
        if (user.streak > 0) {
          user.streak--;
        }

        // If now no todos are completed, reset lastStreakDay
        if (todayStreak.todoIds.isEmpty) {
          print("All todos have been unmarked. Resetting lastStreakDay.");
          user.lastStreakDay = null;
        }
      }

    } else {
      print("TodoId $todoId does not exist in today's streak. Adding it.");
      todayStreak.todoIds.add(todoId);

      // If all todos are completed, increase streak and set lastStreakDay
      if (user.todoList.length == todayStreak.todoIds.length) {
        print("All todos are completed for today. Incrementing streak.");
        user.streak++;
        user.lastStreakDay = today;
      }
    }

    // Update or add today's streak to the user's streak list
    bool found = false;
    for (Streak s in user.streakList) {
      if (s.streakId == todayStreak.streakId) {
        found = true;
      }
    }

    if (found) {
      print("Found existing streak. Updating it.");
      user.streakList = user.streakList.map((streak) {
        if (streak.streakId == todayStreak.streakId) {
          return todayStreak;
        }
        return streak;
      }).toList();
    } else {
      print("New streak. Adding it to the streak list.");
      user.streakList.add(todayStreak);
    }

    await updateUser(user); // Update the user data in Firestore

    print("Updated user streak: ${user.streak}");
    response =
        CustomResponse.success(todayStreak, "Noted Dear!"); // Return the updated streak
  } catch (error) {
    print("Error occurred: $error");
    response = CustomResponse.fail(error.toString());
  }

  return response;
}
