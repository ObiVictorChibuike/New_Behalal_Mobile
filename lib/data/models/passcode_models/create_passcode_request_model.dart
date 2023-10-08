

class CreatePasscodeRequestModel {
  String? passcode;
  String? confirmPasscode;
  String? identifier;

  CreatePasscodeRequestModel({
    this.passcode,
    this.confirmPasscode,
    this.identifier,
  });

  factory CreatePasscodeRequestModel.fromJson(Map<String, dynamic> json) => CreatePasscodeRequestModel(
    passcode: json["passcode"],
    confirmPasscode: json["confirm_passcode"],
    identifier: json["identifier"],
  );

  Map<String, dynamic> toJson() => {
    "passcode": passcode,
    "confirm_passcode": confirmPasscode,
    "identifier": identifier,
  };
}
