import 'package:flutter/material.dart';
import 'package:payflow/shared/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  UserModel? _user;

  get user => _user!;

  void setUser(BuildContext context, UserModel? user) {
    if (user != null) {
      _user = user;
      saveUser(user);
      Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false, arguments: user);
    } else {
      Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
    }
  }

  Future<void> saveUser(UserModel user) async {
    final instance = await SharedPreferences.getInstance();
    await instance.setString("user", user.toJson());
  }

  Future<void> currentUser(BuildContext context, bool delayed) async {
    final instance = await SharedPreferences.getInstance();
    if (delayed) {
      await Future.delayed(Duration(seconds: 2));
    }
    if (instance.containsKey("user")) {
      final json = instance.get("user") as String;
      setUser(context, UserModel.fromJson(json));
    } else {
      setUser(context, null);
    }
  }
}
