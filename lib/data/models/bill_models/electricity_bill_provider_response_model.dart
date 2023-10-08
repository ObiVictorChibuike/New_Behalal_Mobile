
class ElectricityBillProviderResponseModel {
  Data? data;
  String? message;

  ElectricityBillProviderResponseModel({
    this.data,
    this.message,
  });

  factory ElectricityBillProviderResponseModel.fromJson(Map<String, dynamic> json) => ElectricityBillProviderResponseModel(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
    "message": message,
  };
}

class Data {
  List<Biller>? billers;

  Data({
    this.billers,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    billers: json["billers"] == null ? [] : List<Biller>.from(json["billers"]!.map((x) => Biller.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "billers": billers == null ? [] : List<dynamic>.from(billers!.map((x) => x.toJson())),
  };
}

class Biller {
  String? categoryid;
  String? billerid;
  String? billername;
  Billtype? billtype;

  Biller({
    this.categoryid,
    this.billerid,
    this.billername,
    this.billtype,
  });

  factory Biller.fromJson(Map<String, dynamic> json) => Biller(
    categoryid: json["categoryid"],
    billerid: json["billerid"],
    billername: json["billername"],
    billtype: billtypeValues.map[json["billtype"]]!,
  );

  Map<String, dynamic> toJson() => {
    "categoryid": categoryid,
    "billerid": billerid,
    "billername": billername,
    "billtype": billtypeValues.reverse[billtype],
  };
}

enum Billtype {
  ELECTRICITY
}

final billtypeValues = EnumValues({
  "electricity": Billtype.ELECTRICITY
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
