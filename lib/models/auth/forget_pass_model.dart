class ForgetPassOtpVerify {
  String? token;

  ForgetPassOtpVerify({
    required this.token,
  });

  factory ForgetPassOtpVerify.fromJson(Map<String, dynamic> json) => ForgetPassOtpVerify(
        token: json["token"],
      );
}
