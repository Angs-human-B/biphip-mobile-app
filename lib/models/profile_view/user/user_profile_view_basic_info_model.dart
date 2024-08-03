class UserProfileViewBasicInfoModel {
    List<Contact>? contacts;
    List<Link>? links;
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
        links: json["links"] == null ? [] : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
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

class Link {
    int? id;
    int? userId;
    String? type;
    String? userName;
    String? link;
    DateTime? createdAt;
    DateTime? updatedAt;

    Link({
        this.id,
        this.userId,
        this.type,
        this.userName,
        this.link,
        this.createdAt,
        this.updatedAt,
    });

    factory Link.fromJson(Map<String, dynamic> json) => Link(
        id: json["id"],
        userId: json["user_id"],
        type: json["type"],
        userName: json["user_name"],
        link: json["link"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );
}

