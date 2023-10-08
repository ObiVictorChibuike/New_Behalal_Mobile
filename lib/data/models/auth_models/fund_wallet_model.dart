// // To parse this JSON data, do
// //
// //     final fundWalleModel = fundWalleModelFromJson(jsonString);

// import 'package:meta/meta.dart';
// import 'dart:convert';

// FundWalleModel fundWalleModelFromJson(String str) => FundWalleModel.fromJson(json.decode(str));

// String fundWalleModelToJson(FundWalleModel data) => json.encode(data.toJson());

// class FundWalleModel {
//   FundWalleModel({
//     required this.status,
//     required this.message,
//     required this.data,
//   });

//   final bool status;
//   final String message;
//   final Data data;

//   factory FundWalleModel.fromJson(Map<String, dynamic> json) => FundWalleModel(
//         status: json["status"],
//         message: json["message"],
//         data: Data.fromJson(json["data"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "message": message,
//         "data": data.toJson(),
//       };
// }

// class Data {
//   Data({
//     required this.authorizationUrl,
//     required this.accessCode,
//     required this.reference,
//   });

//   final String authorizationUrl;
//   final String accessCode;
//   final String reference;

//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//         authorizationUrl: json["authorization_url"],
//         accessCode: json["access_code"],
//         reference: json["reference"],
//       );

//   Map<String, dynamic> toJson() => {
//         "authorization_url": authorizationUrl,
//         "access_code": accessCode,
//         "reference": reference,
//       };
// }
