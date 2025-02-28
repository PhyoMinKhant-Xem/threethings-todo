import 'package:firebase_auth/firebase_auth.dart';
import 'package:threethings/methods/database_methods/user_methods.dart';
import 'package:threethings/objects/app_user.dart';
import 'package:threethings/utils/auth_response.dart';
import 'package:threethings/utils/custom_response.dart';

class Auth {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<AuthResponse> signUpUser(
      String email, String password, AppUser user) async {
    AuthResponse response = AuthResponse.fail("Error Message Not Provided!");

    try {
      final credential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final userId = credential.user?.uid;
      if (userId != null) {
        response = AuthResponse.success("Sign Up Success!");

        // Creating User Object in the cloud!
        user = AppUser(userId,
            name: user.name,
            email: email,
            profilePic:
                "https://img.freepik.com/free-vector/ai-technology-robot-cyborg-illustrations_24640-134419.jpg",
            streakList: [],
            todoList: []);
        var newUserR = await createUser(userId, user);
        if (newUserR.status != OperationStatus.success) {
          response = AuthResponse.fail("Auth Failed On User Creation!");
        }
      } else {
        response = AuthResponse.fail("User Sign Up Failed!");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        response = AuthResponse.weakPass("Weak Password!");
      } else if (e.code == 'email-already-in-use') {
        response = AuthResponse.usedEmail("Email Already In Use!");
      } else if (e.code == 'invalid-email') {
        response = AuthResponse.invalidEmail("Invalid Email!");
      }
    }
    return response;
  }

  Future<AuthResponse> loginUser(
      String email, String password, User user) async {
    AuthResponse response = AuthResponse.fail("Error Message Not Provided!");

    try {
      final credential = await auth.signInWithEmailAndPassword(
          email: email, password: password);

      if (credential.user != null) {
        response = AuthResponse.success("Login Success!");
      } else {
        response = AuthResponse.fail("User Login Failed!");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password' || e.code == "user-not-found") {
        response = AuthResponse.invalidEmail(
            "Wrong Email or Password. Please Try Signing Up!");
      }
    }
    return response;
  }
}
