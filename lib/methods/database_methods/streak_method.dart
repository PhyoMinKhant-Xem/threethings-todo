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
        date: new DateTime.now(),
      ),
    );

    if (todayStreak.todoIds.contains(todoId)) {
      todayStreak.todoIds.remove(todoId);
    } else {
      todayStreak.todoIds.add(todoId);
    }

    bool found = false;
    for (Streak s in user.streakList) {
      if (s.streakId == todayStreak.streakId) {
        found = true;
      }
    }

    if (found) {
      user.streakList.map((streak) => {
            if (streak.streakId == todayStreak.streakId) {streak = todayStreak}
          });
    } else {
      user.streakList.add(todayStreak);
    }

    if (user.todoList.length == todayStreak.todoIds.length) {
      user.streak++;
    }

    await updateUser(user);

    response = CustomResponse.fail("Method Not Handled Here!");
  } catch (error) {
    response = CustomResponse.fail(error.toString());
  }

  return response;
}
