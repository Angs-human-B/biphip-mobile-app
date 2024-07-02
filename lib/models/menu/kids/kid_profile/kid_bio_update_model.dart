import 'package:bip_hip/models/menu/kids/kid_profile/kid_overview_model.dart';
class KidBioUpdateModel {
    Kids ?kids;

    KidBioUpdateModel({
        required this.kids,
    });

    factory KidBioUpdateModel.fromJson(Map<String, dynamic> json) => KidBioUpdateModel(
        kids: Kids.fromJson(json["kid"]),
    );
}
