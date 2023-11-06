class KidModel {
    int? userId;
    String? name;
    String? image;
    String? age;
    int? id;
    String? kidImage;

    KidModel({
        required this.userId,
        required this.name,
        required this.image,
        required this.age,
        required this.id,
        required this.kidImage,
    });

    factory KidModel.fromJson(Map<String, dynamic> json) => KidModel(
        userId: json["user_id"],
        name: json["name"],
        image: json["image"],
        age: json["age"],
        id: json["id"],
        kidImage: json["kid_image"],
    );
}
