import 'package:bip_hip/models/menu/profile/common_list_models.dart';

class GetCreatePostModel {
  List<PostCategory> postCategories;
  List<PostCategory> postSubCategories;
  List<Privacy> privacy;
  List<Privacy> sellPostCondition;
  List<Privacy> sellPostCategories;

  GetCreatePostModel({
    required this.postCategories,
    required this.postSubCategories,
    required this.privacy,
    required this.sellPostCondition,
    required this.sellPostCategories,
  });

  factory GetCreatePostModel.fromJson(Map<String, dynamic> json) => GetCreatePostModel(
        postCategories: List<PostCategory>.from(json["postCategories"].map((x) => PostCategory.fromJson(x))),
        postSubCategories: List<PostCategory>.from(json["postSubCategories"].map((x) => PostCategory.fromJson(x))),
        privacy: List<Privacy>.from(json["privacy"].map((x) => Privacy.fromJson(x))),
        sellPostCondition: List<Privacy>.from(json["sell_post_condition"].map((x) => Privacy.fromJson(x))),
        sellPostCategories: List<Privacy>.from(json["sell_post_categories"].map((x) => Privacy.fromJson(x))),
      );
}

class Privacy {
  int? id;
  String? name;

  Privacy({
    required this.id,
    required this.name,
  });

  factory Privacy.fromJson(Map<String, dynamic> json) => Privacy(
        id: json["id"],
        name: json["name"],
      );
}
