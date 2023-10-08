

class RegistrationRequestModelResponse {
  String? phoneNumber;
  String? deviceId;
  String? referalBy;

  RegistrationRequestModelResponse({
    this.phoneNumber,
    this.deviceId,
    this.referalBy,
  });

  factory RegistrationRequestModelResponse.fromJson(Map<String, dynamic> json) => RegistrationRequestModelResponse(
    phoneNumber: json["phone_number"],
    deviceId: json["device_id"],
    referalBy: json["referal_by"],
  );

  Map<String, dynamic> toJson() => {
    "phone_number": phoneNumber,
    "device_id": deviceId,
    "referal_by": referalBy,
  };
}
