

import 'package:bip_hip/models/common/common_user_model.dart';

class TwoFactorAuthenticationModel {
  bool two_factor_enabled;
  String two_factor_type;

  TwoFactorAuthenticationModel({
    required this.two_factor_enabled,
    required this.two_factor_type,
  });

  factory TwoFactorAuthenticationModel.fromJson(Map<String, dynamic> json) => TwoFactorAuthenticationModel(
    two_factor_enabled: json["two_factor_enabled"],
    two_factor_type: json["two_factor_type"].toString(),
  );
}