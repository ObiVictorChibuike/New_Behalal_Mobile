// To parse this JSON data, do
//
//     final userDetailsRequestResponseModel = userDetailsRequestResponseModelFromJson(jsonString);

import 'dart:convert';

UserDetailsRequestResponseModel userDetailsRequestResponseModelFromJson(String str) => UserDetailsRequestResponseModel.fromJson(json.decode(str));

String userDetailsRequestResponseModelToJson(UserDetailsRequestResponseModel data) => json.encode(data.toJson());

class UserDetailsRequestResponseModel {
  String? identifier;
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? passwordConfirmation;
  String? passcode;
  String? confirmPasscode;

  UserDetailsRequestResponseModel({
    this.identifier,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.passwordConfirmation,
    this.passcode,
    this.confirmPasscode,
  });

  factory UserDetailsRequestResponseModel.fromJson(Map<String, dynamic> json) => UserDetailsRequestResponseModel(
    identifier: json["identifier"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    password: json["password"],
    passwordConfirmation: json["password_confirmation"],
    passcode: json["passcode"],
    confirmPasscode: json["confirm_passcode"],
  );

  Map<String, dynamic> toJson() => {
    "identifier": identifier,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "password": password,
    "password_confirmation": passwordConfirmation,
    "passcode": passcode,
    "confirm_passcode": confirmPasscode,
  };
}
