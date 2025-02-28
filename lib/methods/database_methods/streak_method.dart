import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:threethings/methods/database_methods/user_methods.dart';
import 'package:threethings/objects/streak.dart';
import 'package:threethings/objects/app_user.dart';
import 'package:threethings/utils/custom_response.dart';

FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;
CollectionReference userReference = firebaseFireStore.collection("users");

Future<CustomResponse<Streak>> addStreak(AppUser user, Streak newStreak) async {
  CustomResponse<Streak> response =
      CustomResponse.fail<Streak>("Error Message Not Provided!");

  try {
    user.streak++;
    user.streakList.add(newStreak);
    await updateUser(user);

    response = CustomResponse.fail("Method Not Handled Here!");
  } catch (error) {
    response = CustomResponse.fail(error.toString());
  }

  return response;
}
