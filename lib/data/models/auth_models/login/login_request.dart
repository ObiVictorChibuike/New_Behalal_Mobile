
class LoginRequestModelResponse {
  String? phoneNumber;
  String? deviceId;
  String? password;

  LoginRequestModelResponse({
    this.phoneNumber,
    this.deviceId,
    this.password,
  });

  factory LoginRequestModelResponse.fromJson(Map<String, dynamic> json) => LoginRequestModelResponse(
    phoneNumber: json["phone_number"],
    deviceId: json["device_id"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "phone_number": phoneNumber,
    "device_id": deviceId,
    "password": password,
  };
}
