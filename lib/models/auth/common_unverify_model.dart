class CommonUnVerifyModel {
  int? otp;
  String? token;

  CommonUnVerifyModel({
    required this.otp,
    required this.token,
  });

  factory CommonUnVerifyModel.fromJson(Map<String, dynamic> json) => CommonUnVerifyModel(
        otp: json["otp"],
        token: json["token"],
      );
}
