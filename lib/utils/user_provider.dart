import 'package:flutter/material.dart';
import 'package:threethings/methods/auth_methods/auth.dart';
import 'package:threethings/objects/app_user.dart';

class UserProviders with ChangeNotifier {
  AppUser? _user;
  final Auth _authMethods = Auth();

  AppUser? get getUser => _user; // No force unwrapping (!)

  Future<void> refreshUser() async {
    try {
      AppUser user = await _authMethods.getUserDetails();
      _user = user;
      notifyListeners();
    } catch (e) {
      print("Error fetching user: $e");
    }
  }
}
