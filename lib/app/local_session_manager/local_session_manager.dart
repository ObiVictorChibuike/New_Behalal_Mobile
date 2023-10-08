import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class LocalSessionManager {
  static final LocalSessionManager _sessionManager = LocalSessionManager.internal();

  factory LocalSessionManager() => _sessionManager;
  LocalSessionManager.internal();
  late SharedPreferences sharedPreferences;

  Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }
  static const String authToken = "auth_token";
  static const String authLoginStatus = "auth_status";
  static const String authEmail = "email";
  static const String identifier = "identifier";
  static const String password = "password";
  static const String userName = "userName";
  static const String passwordStatus = "rememberPasswordStatus";
  static const String avatarPath = "avatarPath";

  ///Cache Auth Bearer Token
  set authTokenVal(String value) => sharedPreferences.setString(authToken, value);
  String get token => sharedPreferences.getString(authToken) ?? "";

  ///Cache Auth Status
  set authStatusVal(bool value) => sharedPreferences.setBool(authLoginStatus, value);
  bool get authStatus => sharedPreferences.getBool(authLoginStatus) ?? false;

  ///Cache Auth User Email
  set authUserEmail(String value) => sharedPreferences.setString(authEmail, value);
  String get userEmail => sharedPreferences.getString(authEmail) ?? "";

  ///Cache Auth User Identifier
  set authUserIdentifier(String value) => sharedPreferences.setString(identifier, value);
  String get userIdentifier => sharedPreferences.getString(identifier) ?? "";

  ///Cache Auth User avatar
  set authUserAvatar(String value) => sharedPreferences.setString(avatarPath, value);
  String get userAvatar => sharedPreferences.getString(avatarPath) ?? "";

  ///Cache Auth User Password
  set authUserPassword(String value) => sharedPreferences.setString(password, value);
  String get userPassword => sharedPreferences.getString(password) ?? "";

  ///Cache Auth User Name
  set authUserName(String value) => sharedPreferences.setString(userName, value);
  String get getUserName => sharedPreferences.getString(userName) ?? "";

  ///Cache Show Password Status
  set rememberPasswordStatus(bool value) => sharedPreferences.setBool(passwordStatus, value);
  bool get userPasswordStatus => sharedPreferences.getBool(passwordStatus) ?? false;

}
