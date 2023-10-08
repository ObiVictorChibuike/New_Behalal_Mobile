
class DataBundleProvidersByIdResponseModel {
  Data? data;
  String? message;

  DataBundleProvidersByIdResponseModel({
    this.data,
    this.message,
  });

  factory DataBundleProvidersByIdResponseModel.fromJson(Map<String, dynamic> json) => DataBundleProvidersByIdResponseModel(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
    "message": message,
  };
}

class Data {
  List<BillerItem>? billerItems;

  Data({
    this.billerItems,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    billerItems: json["biller_items"] == null ? [] : List<BillerItem>.from(json["biller_items"]!.map((x) => BillerItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "biller_items": billerItems == null ? [] : List<dynamic>.from(billerItems!.map((x) => x.toJson())),
  };
}

class BillerItem {
  String? categoryid;
  String? billerid;
  bool? isAmountFixed;
  String? paymentitemid;
  String? paymentitemname;
  String? amount;
  String? code;
  String? currencyCode;
  String? currencySymbol;
  String? itemCurrencySymbol;
  String? sortOrder;
  String? pictureId;
  String? paymentCode;
  String? itemFee;
  String? paydirectItemCode;

  BillerItem({
    this.categoryid,
    this.billerid,
    this.isAmountFixed,
    this.paymentitemid,
    this.paymentitemname,
    this.amount,
    this.code,
    this.currencyCode,
    this.currencySymbol,
    this.itemCurrencySymbol,
    this.sortOrder,
    this.pictureId,
    this.paymentCode,
    this.itemFee,
    this.paydirectItemCode,
  });

  factory BillerItem.fromJson(Map<String, dynamic> json) => BillerItem(
    categoryid: json["categoryid"],
    billerid: json["billerid"],
    isAmountFixed: json["isAmountFixed"],
    paymentitemid: json["paymentitemid"],
    paymentitemname: json["paymentitemname"],
    amount: json["amount"],
    code: json["code"],
    currencyCode: json["currencyCode"],
    currencySymbol: json["currencySymbol"],
    itemCurrencySymbol: json["itemCurrencySymbol"],
    sortOrder: json["sortOrder"],
    pictureId: json["pictureId"],
    paymentCode: json["paymentCode"],
    itemFee: json["itemFee"],
    paydirectItemCode: json["paydirectItemCode"],
  );

  Map<String, dynamic> toJson() => {
    "categoryid": categoryid,
    "billerid": billerid,
    "isAmountFixed": isAmountFixed,
    "paymentitemid": paymentitemid,
    "paymentitemname": paymentitemname,
    "amount": amount,
    "code": code,
    "currencyCode": currencyCode,
    "currencySymbol": currencySymbol,
    "itemCurrencySymbol": itemCurrencySymbol,
    "sortOrder": sortOrder,
    "pictureId": pictureId,
    "paymentCode": paymentCode,
    "itemFee": itemFee,
    "paydirectItemCode": paydirectItemCode,
  };
}
