class BanksListResponse {
  final List<BanksList>? banksList;

  const BanksListResponse({this.banksList});

  factory BanksListResponse.fromJson(Map<String, dynamic> json) => BanksListResponse(
        banksList: json["data"] != null
            ? List<BanksList>.from(
                json["data"].map((i) => BanksList.fromJson(i)),
              )
            : null,
      );
}

class BanksList {
  BanksList({
    required this.id,
    required this.code,
    required this.name,
  });

  final int? id;
  final String? code;
  final String? name;

  factory BanksList.fromJson(Map<String, dynamic> json) => BanksList(
        id: json["id"],
        code: json["code"],
        name: json["name"],
      );
}
