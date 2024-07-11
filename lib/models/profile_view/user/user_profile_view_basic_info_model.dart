import 'package:bip_hip/models/common/common_link_model.dart';

class UserProfileViewBasicInfoModel {
    List<Contact>? contacts;
    List<CommonLink>? links;
    String? gender;
    DateTime? dateOfBirth;
    List<String>? languages;

    UserProfileViewBasicInfoModel({
        this.contacts,
        this.links,
        this.gender,
        this.dateOfBirth,
        this.languages,
    });

    factory UserProfileViewBasicInfoModel.fromJson(Map<String, dynamic> json) => UserProfileViewBasicInfoModel(
        contacts: json["contacts"] == null ? [] : List<Contact>.from(json["contacts"]!.map((x) => Contact.fromJson(x))),
        links: json["links"] == null ? [] : List<CommonLink>.from(json["links"]!.map((x) => CommonLink.fromJson(x))),
        gender: json["gender"],
        dateOfBirth: json["date_of_birth"] == null ? null : DateTime.parse(json["date_of_birth"]),
        languages: json["languages"] == null ? [] : List<String>.from(json["languages"]!.map((x) => x)),
    );
}

class Contact {
    int? id;
    int? userId;
    String? type;
    String? value;

    Contact({
        this.id,
        this.userId,
        this.type,
        this.value,
    });

    factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        id: json["id"],
        userId: json["user_id"],
        type: json["type"],
        value: json["value"],
    );
}
