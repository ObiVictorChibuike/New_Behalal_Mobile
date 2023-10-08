class Token {
  Token(this.value);

  final String value;

  factory Token.fromJson(Map<String, dynamic> json) => Token(json["access_token"]);
}
