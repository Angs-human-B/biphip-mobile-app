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

// class PostCategory {
//     int ?id;
//     String ?slug;
//     String ?name;
//     int ?isActive;
//     int? postCategoryId;

//     PostCategory({
//         required this.id,
//         required this.slug,
//         required this.name,
//         required this.isActive,
//         this.postCategoryId,
//     });

//     factory PostCategory.fromJson(Map<String, dynamic> json) => PostCategory(
//         id: json["id"],
//         slug: json["slug"],
//         name: json["name"],
//         isActive: json["is_active"],
//         postCategoryId: json["post_category_id"],
//     );
// }

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
