

class LoginResponseModel {
  String? token;
  String? tokenType;
  String? message;

  LoginResponseModel({
    this.token,
    this.tokenType,
    this.message,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
    token: json["token"],
    tokenType: json["token_type"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "token_type": tokenType,
    "message": message,
  };
}
