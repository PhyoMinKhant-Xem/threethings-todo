import 'package:flutter/material.dart';
import 'package:threethings/methods/database_methods/user_methods.dart';
import 'package:threethings/objects/app_user.dart';

class UserProvider with ChangeNotifier {
  AppUser? _user;
  Stream<AppUser>? _userStream;

  AppUser? get getUser => _user;

  void fetchUser(String id) {
    _userStream = getUserDetail(id);

    _userStream!.listen((userData) {
      _user = userData;
      notifyListeners();
    }, onError: (error) {
      print("Error fetching user: $error");
    });
  }
}
