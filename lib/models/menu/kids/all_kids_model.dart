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
    int ? id;
    int ? userId;
    String ? name;
    String ? image;
    int ? age;
    String ? kidImage;

    Kid({
        required this.id,
        required this.userId,
        required this.name,
        required this.image,
        required this.age,
        required this.kidImage,
    });

    factory Kid.fromJson(Map<String, dynamic> json) => Kid(
        id: json["id"],
        userId: json["user_id"],
        name: json["name"],
        image: json["image"],
        age: json["age"],
        kidImage: json["kid_image"],
    );
}