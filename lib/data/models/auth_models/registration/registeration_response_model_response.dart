
class RegistrationResponseModelResponse {
  Data? data;
  String? message;

  RegistrationResponseModelResponse({
    this.data,
    this.message,
  });

  factory RegistrationResponseModelResponse.fromJson(Map<String, dynamic> json) => RegistrationResponseModelResponse(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
    "message": message,
  };
}

class Data {
  String? identifier;

  Data({
    this.identifier,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    identifier: json["identifier"],
  );

  Map<String, dynamic> toJson() => {
    "identifier": identifier,
  };
}
