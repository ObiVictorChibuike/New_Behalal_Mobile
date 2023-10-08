
class GetAllBeneficiariesResponseModel {
  Data? data;
  String? message;

  GetAllBeneficiariesResponseModel({
    this.data,
    this.message,
  });

  factory GetAllBeneficiariesResponseModel.fromJson(Map<String, dynamic> json) => GetAllBeneficiariesResponseModel(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
    "message": message,
  };
}

class Data {
  List<Beneficiary>? beneficiary;

  Data({
    this.beneficiary,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    beneficiary: json["beneficiary"] == null ? [] : List<Beneficiary>.from(json["beneficiary"]!.map((x) => Beneficiary.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "beneficiary": beneficiary == null ? [] : List<dynamic>.from(beneficiary!.map((x) => x.toJson())),
  };
}

class Beneficiary {
  String? id;
  String? type;
  String? name;
  String? provider;
  String? userId;
  String? phoneNumber;

  Beneficiary({
    this.id,
    this.type,
    this.name,
    this.provider,
    this.userId,
    this.phoneNumber,
  });

  factory Beneficiary.fromJson(Map<String, dynamic> json) => Beneficiary(
    id: json["id"],
    type: json["type"],
    name: json["name"],
    provider: json["provider"],
    userId: json["user_id"],
    phoneNumber: json["phone_number"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "name": name,
    "provider": provider,
    "user_id": userId,
    "phone_number": phoneNumber,
  };
}
