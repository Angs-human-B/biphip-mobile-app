import 'package:bip_hip/models/common/common_user_model.dart';

class CommonUserDataModel {
    User? user;

    CommonUserDataModel({
        required this.user,
    });

    factory CommonUserDataModel.fromJson(Map<String, dynamic> json) => CommonUserDataModel(
        user: json["user"]==null?null:User.fromJson(json["user"]),
    );
}
