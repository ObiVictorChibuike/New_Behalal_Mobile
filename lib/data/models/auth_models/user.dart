class User {
  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phonenumber,
    required this.cooperativeSocietyName,
    this.photoID,
    this.photoURL,
    this.email,
    required this.tierLevel,
    required this.referalCode,
  });

  int id;
  String firstName;
  String lastName;
  int phonenumber;
  String cooperativeSocietyName;
  String? photoID;
  String? photoURL;
  String? email;
  int tierLevel;
  String? referalCode;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        phonenumber: json["phonenumber"],
        cooperativeSocietyName: json["cooperative_society_name"],
        photoID: json["photo_id"],
        photoURL: json["photo_url"],
        email: json["email"],
        tierLevel: json['user_tier_level'],
        referalCode: json["referral_code"],
      );
}
