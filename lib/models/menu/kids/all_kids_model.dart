class AllKidsModel {
  List<Kid> kids;

  AllKidsModel({
    required this.kids,
  });

  factory AllKidsModel.fromJson(Map<String, dynamic> json) => AllKidsModel(
        kids: List<Kid>.from(json["kids"].map((x) => Kid.fromJson(x))),
      );
}

class Kid {
  int? id;
  int? userId;
  String? name;
  dynamic bio;
  int? age;
  String? image;
  dynamic cover;
  dynamic gender;
  String? profilePicture;
  String? coverPhoto;

  Kid({
    required this.id,
    required this.userId,
    required this.name,
    required this.bio,
    required this.age,
    required this.image,
    required this.cover,
    required this.gender,
    required this.profilePicture,
    required this.coverPhoto,
  });

  factory Kid.fromJson(Map<String, dynamic> json) => Kid(
        id: json["id"],
        userId: json["user_id"],
        name: json["name"],
        bio: json["bio"],
        age: json["age"],
        image: json["image"],
        cover: json["cover"],
        gender: json["gender"],
        profilePicture: json["profile_picture"],
        coverPhoto: json["cover_photo"],
      );
}
