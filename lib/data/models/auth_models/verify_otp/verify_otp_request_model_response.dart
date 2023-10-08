
class VerifyOtpRequestModelResponse {
  String? identifier;
  String? otp;

  VerifyOtpRequestModelResponse({
    this.identifier,
    this.otp,
  });

  factory VerifyOtpRequestModelResponse.fromJson(Map<String, dynamic> json) => VerifyOtpRequestModelResponse(
    identifier: json["identifier"],
    otp: json["otp"],
  );

  Map<String, dynamic> toJson() => {
    "identifier": identifier,
    "otp": otp,
  };
}
