import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:threethings/objects/app_user.dart';
import 'package:threethings/utils/custom_response.dart';

FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;
CollectionReference userReference = firebaseFireStore.collection("users");

Future<CustomResponse<AppUser>> createUser(String uId, AppUser newUser) async {
  CustomResponse<AppUser> response =
      CustomResponse.fail<AppUser>("Error Message Not Provided!");

  try {
    final newUserRef = await userReference
        .doc(uId)
        .set(AppUser.toMap(newUser))
        .then((_) => {
              response =
                  CustomResponse.success(newUser, "User Creation Success!")
            })
        .onError(throw Exception("Error Creating User!"));
  } catch (error) {
    response = CustomResponse.fail(error.toString());
  }

  return response;
}

Future<CustomResponse<bool>> updateUser(AppUser user) async {
  CustomResponse<bool> response =
      CustomResponse.fail<bool>("Error Message Not Provided!");

  try {
    final newUserRef = await userReference
        .doc(user.getId)
        .set(AppUser.toMap(user))
        .then((_) => {
              response = CustomResponse.success(
                  true, "User Information Update Success!")
            })
        .onError(throw Exception("Error Updating User!"));
  } catch (error) {
    response = CustomResponse.fail(error.toString());
  }

  return response;
}