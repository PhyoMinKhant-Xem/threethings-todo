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

Future<CustomResponse<bool>> login(String email, String password) async {
  CustomResponse<bool> response =
      CustomResponse.fail<bool>("Error Message Not Provided!");

  try {
    //TODO: make login method here
    response = CustomResponse.fail("Method Not Handled Here!");
  } catch (error) {
    response = CustomResponse.fail(error.toString());
  }

  return response;
}

Future<CustomResponse<bool>> updateUser(User user) async {
  CustomResponse<bool> response =
      CustomResponse.fail<bool>("Error Message Not Provided!");

  try {
    await userReference
        .doc(user.getEmail)
        .update(User.toMap(user))
        .then((u) => {
              //TODO: handle the appropriate value here
              print(user)
            });

    response = CustomResponse.fail("Method Not Handled Here!");
  } catch (error) {
    response = CustomResponse.fail(error.toString());
  }

  return response;
}

Future<CustomResponse<User>> signOutUser(User newUser) async {
  CustomResponse<User> response =
      CustomResponse.fail<User>("Error Message Not Provided!");

  try {
    //TODO: handle sign out here

    response = CustomResponse.fail("Method Not Handled Here!");
  } catch (error) {
    response = CustomResponse.fail(error.toString());
  }

  return response;
}
