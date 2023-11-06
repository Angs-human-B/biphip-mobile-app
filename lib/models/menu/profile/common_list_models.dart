import 'package:bip_hip/models/common/common_user_model.dart';

class CommonUserDataModel {
  User? user;

  CommonUserDataModel({
    required this.user,
  });

  factory CommonUserDataModel.fromJson(Map<String, dynamic> json) => CommonUserDataModel(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );
}

class ProfessionListModel {
  List<String> professions;

  ProfessionListModel({
    required this.professions,
  });

  factory ProfessionListModel.fromJson(Map<String, dynamic> json) => ProfessionListModel(
        professions: List<String>.from(json["professions"].map((x) => x)),
      );
}

class InterestListModel {
  List<String> interests;

  InterestListModel({
    required this.interests,
  });

  factory InterestListModel.fromJson(Map<String, dynamic> json) => InterestListModel(
        interests: List<String>.from(json["interests"].map((x) => x)),
      );
}

class RelationshipListModel {
  List<String> relationships;

  RelationshipListModel({
    required this.relationships,
  });

  factory RelationshipListModel.fromJson(Map<String, dynamic> json) => RelationshipListModel(
        relationships: List<String>.from(json["relationships"].map((x) => x)),
      );
}

class GenderListModel {
  List<String> genders;

  GenderListModel({
    required this.genders,
  });

  factory GenderListModel.fromJson(Map<String, dynamic> json) => GenderListModel(
        genders: List<String>.from(json["genders"].map((x) => x)),
      );
}

class PositionListModel {
  List<String> positions;

  PositionListModel({
    required this.positions,
  });

  factory PositionListModel.fromJson(Map<String, dynamic> json) => PositionListModel(
        positions: List<String>.from(json["positions"].map((x) => x)),
      );
}

class LinkListModel {
  List<String> linkTypes;

  LinkListModel({
    required this.linkTypes,
  });

  factory LinkListModel.fromJson(Map<String, dynamic> json) => LinkListModel(
        linkTypes: List<String>.from(json["linkTypes"].map((x) => x)),
      );
}

class CityListModel {
  List<String> cities;

  CityListModel({
    required this.cities,
  });

  factory CityListModel.fromJson(Map<String, dynamic> json) => CityListModel(
        cities: List<String>.from(json["cities"].map((x) => x)),
      );
}

class CompanyListModel {
  List<String> companies;

  CompanyListModel({
    required this.companies,
  });

  factory CompanyListModel.fromJson(Map<String, dynamic> json) => CompanyListModel(
        companies: List<String>.from(json["companies"].map((x) => x)),
      );
}

class SchoolListModel {
  List<String> schools;

  SchoolListModel({
    required this.schools,
  });

  factory SchoolListModel.fromJson(Map<String, dynamic> json) => SchoolListModel(
        schools: List<String>.from(json["schools"].map((x) => x)),
      );
}

class PostCategoryListModel {
  List<PostCategory> postCategories;

  PostCategoryListModel({
    required this.postCategories,
  });

  factory PostCategoryListModel.fromJson(Map<String, dynamic> json) => PostCategoryListModel(
        postCategories: List<PostCategory>.from(json["postCategories"].map((x) => PostCategory.fromJson(x))),
      );
}

class PostCategory {
  int? id;
  String? name;
  int? isActive;

  PostCategory({
    required this.id,
    required this.name,
    required this.isActive,
  });

  factory PostCategory.fromJson(Map<String, dynamic> json) => PostCategory(
        id: json["id"],
        name: json["name"],
        isActive: json["is_active"],
      );
}

class KidListModel {
  List<Kid> kids;

  KidListModel({
    required this.kids,
  });

  factory KidListModel.fromJson(Map<String, dynamic> json) => KidListModel(
        kids: List<Kid>.from(json["kids"].map((x) => Kid.fromJson(x))),
      );
}

class Kid {
  int? id;
  int? userId;
  String? name;
  String? image;
  int? age;
  String kidImage;

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
