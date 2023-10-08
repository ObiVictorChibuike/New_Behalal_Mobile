
class AirtimeBillProviderResponseModel {
  Data? data;
  String? message;

  AirtimeBillProviderResponseModel({
    this.data,
    this.message,
  });

  factory AirtimeBillProviderResponseModel.fromJson(Map<String, dynamic> json) => AirtimeBillProviderResponseModel(
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
  String? billtype;

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
    billtype: json["billtype"],
  );

  Map<String, dynamic> toJson() => {
    "categoryid": categoryid,
    "billerid": billerid,
    "billername": billername,
    "billtype": billtype,
  };
}
