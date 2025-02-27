import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:threethings/objects/user.dart';
import 'package:threethings/utils/custom_response.dart';

FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;
CollectionReference userReference = firebaseFireStore.collection("users");

// SIGN UP
Future<CustomResponse<User>> createUser(User newUser) async {
  CustomResponse<User> response = CustomResponse.fail<User>("Error Message Not Provided!");

  try{
    //TODO: move the below line to the client side
    newUser.profilePic = "https://img.freepik.com/free-vector/ai-technology-robot-cyborg-illustrations_24640-134419.jpg";
    //TODO: hash the password here
    await userReference.add(User.toMap(newUser)).then((user)=>{
      //TODO: handle the appropriate value here
      print(user)
    });

    response = CustomResponse.fail("Method Not Handled Here!");
  }catch(error){
    response = CustomResponse.fail(error.toString());
  }

  return response;
}

Future<CustomResponse<bool>> login(String email, String password) async {
  CustomResponse<bool> response = CustomResponse.fail<bool>("Error Message Not Provided!");

  try{
    //TODO: make login method here
    response = CustomResponse.fail("Method Not Handled Here!");
  }catch(error){
    response = CustomResponse.fail(error.toString());
  }

  return response;
}

Future<CustomResponse<bool>> updateUser(User user) async {
  CustomResponse<bool> response = CustomResponse.fail<bool>("Error Message Not Provided!");

  try{
    await userReference.doc(user.getEmail).update(User.toMap(user)).then((u)=>{
      //TODO: handle the appropriate value here
      print(user)
    });

    response = CustomResponse.fail("Method Not Handled Here!");
  }catch(error){
    response = CustomResponse.fail(error.toString());
  }

  return response;
}

Future<CustomResponse<User>> signOutUser(User newUser) async {
  CustomResponse<User> response = CustomResponse.fail<User>("Error Message Not Provided!");

  try{
    //TODO: handle sign out here

    response = CustomResponse.fail("Method Not Handled Here!");
  }catch(error){
    response = CustomResponse.fail(error.toString());
  }

  return response;
}