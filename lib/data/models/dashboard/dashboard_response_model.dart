
class DashBoardResponseModel {
  Data? data;
  String? message;

  DashBoardResponseModel({
    this.data,
    this.message,
  });

  factory DashBoardResponseModel.fromJson(Map<String, dynamic> json) => DashBoardResponseModel(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
    "message": message,
  };
}

class Data {
  Userdetail? userdetail;

  Data({
    this.userdetail,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userdetail: json["userdetail"] == null ? null : Userdetail.fromJson(json["userdetail"]),
  );

  Map<String, dynamic> toJson() => {
    "userdetail": userdetail?.toJson(),
  };
}

class Userdetail {
  String? id;
  String? firstName;
  String? middleName;
  String? lastName;
  String? email;
  String? gender;
  String? phoneNumber;
  DateTime? dateOfBirth;
  DateTime? phoneVerifiedAt;
  int? bvnVerified;
  dynamic identifier;
  String? bvnId;
  int? kycVerified;
  dynamic emailVerifiedAt;
  String? referalCode;
  String? referalBy;
  int? recoveryMode;
  int? loginAttempt;
  String? deviceId;
  dynamic ipaddress;
  String? accountTier;
  String? accountDailyLimit;
  int? isRestricted;
  String? isDissabled;
  DateTime? lastLogin;
  int? hasGovernmentIdentity;
  int? accountType;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic balanceDisplayMode;

  Userdetail({
    this.id,
    this.firstName,
    this.middleName,
    this.lastName,
    this.email,
    this.gender,
    this.phoneNumber,
    this.dateOfBirth,
    this.phoneVerifiedAt,
    this.bvnVerified,
    this.identifier,
    this.bvnId,
    this.kycVerified,
    this.emailVerifiedAt,
    this.referalCode,
    this.referalBy,
    this.recoveryMode,
    this.loginAttempt,
    this.deviceId,
    this.ipaddress,
    this.accountTier,
    this.accountDailyLimit,
    this.isRestricted,
    this.isDissabled,
    this.lastLogin,
    this.hasGovernmentIdentity,
    this.accountType,
    this.createdAt,
    this.updatedAt,
    this.balanceDisplayMode,
  });

  factory Userdetail.fromJson(Map<String, dynamic> json) => Userdetail(
    id: json["id"],
    firstName: json["first_name"],
    middleName: json["middle_name"],
    lastName: json["last_name"],
    email: json["email"],
    gender: json["gender"],
    phoneNumber: json["phone_number"],
    dateOfBirth: json["date_of_birth"] == null ? null : DateTime.parse(json["date_of_birth"]),
    phoneVerifiedAt: json["phone_verified_at"] == null ? null : DateTime.parse(json["phone_verified_at"]),
    bvnVerified: json["bvn_verified"],
    identifier: json["identifier"],
    bvnId: json["bvn_id"],
    kycVerified: json["kyc_verified"],
    emailVerifiedAt: json["email_verified_at"],
    referalCode: json["referal_code"],
    referalBy: json["referal_by"],
    recoveryMode: json["recovery_mode"],
    loginAttempt: json["login_attempt"],
    deviceId: json["device_id"],
    ipaddress: json["ipaddress"],
    accountTier: json["account_tier"],
    accountDailyLimit: json["account_daily_limit"],
    isRestricted: json["is_restricted"],
    isDissabled: json["is_dissabled"],
    lastLogin: json["last_login"] == null ? null : DateTime.parse(json["last_login"]),
    hasGovernmentIdentity: json["has_government_identity"],
    accountType: json["account_type"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    balanceDisplayMode: json["balance_display_mode"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "middle_name": middleName,
    "last_name": lastName,
    "email": email,
    "gender": gender,
    "phone_number": phoneNumber,
    "date_of_birth": "${dateOfBirth!.year.toString().padLeft(4, '0')}-${dateOfBirth!.month.toString().padLeft(2, '0')}-${dateOfBirth!.day.toString().padLeft(2, '0')}",
    "phone_verified_at": phoneVerifiedAt?.toIso8601String(),
    "bvn_verified": bvnVerified,
    "identifier": identifier,
    "bvn_id": bvnId,
    "kyc_verified": kycVerified,
    "email_verified_at": emailVerifiedAt,
    "referal_code": referalCode,
    "referal_by": referalBy,
    "recovery_mode": recoveryMode,
    "login_attempt": loginAttempt,
    "device_id": deviceId,
    "ipaddress": ipaddress,
    "account_tier": accountTier,
    "account_daily_limit": accountDailyLimit,
    "is_restricted": isRestricted,
    "is_dissabled": isDissabled,
    "last_login": lastLogin?.toIso8601String(),
    "has_government_identity": hasGovernmentIdentity,
    "account_type": accountType,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "balance_display_mode": balanceDisplayMode,
  };
}
