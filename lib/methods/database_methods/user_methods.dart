import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:threethings/objects/app_user.dart';
import 'package:threethings/utils/custom_response.dart';

FirebaseFirestore _firebaseFireStore = FirebaseFirestore.instance;
CollectionReference _userReference = _firebaseFireStore.collection("users");

Stream<AppUser> getUserDetail(String uId) {
  return _userReference.doc(uId).snapshots().map((snapshot) {
    if (!snapshot.exists || snapshot.data() == null) {
      print("DEBUG: No user data found for ID: $uId");
      throw Exception("User not found!");
    }

    final userData = snapshot.data() as Map<String, dynamic>;
    print("DEBUG: Firestore data updated -> ${userData}");

    return AppUser.toObject(userData);
  });
}


Future<CustomResponse<AppUser>> createUser(String uId, AppUser newUser) async {
  CustomResponse<AppUser> response =
      CustomResponse.fail<AppUser>("Error Message Not Provided!");

  try {
    await _userReference.doc(uId).set(AppUser.toMap(newUser)).then(
          (_) => {
            response = CustomResponse.success(newUser, "User Creation Success!")
          },
        );
  } catch (error) {
    response = CustomResponse.fail(error.toString());
  }

  return response;
}

Future<CustomResponse<bool>> updateUser(AppUser user) async {
  CustomResponse<bool> response =
      CustomResponse.fail<bool>("Error Message Not Provided!");

  try {
    await _userReference
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
