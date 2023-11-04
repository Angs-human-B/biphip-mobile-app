import 'package:bip_hip/models/common/common_link_model.dart';

class PostListModel {
  Posts posts;

  PostListModel({
    required this.posts,
  });

  factory PostListModel.fromJson(Map<String, dynamic> json) => PostListModel(
        posts: Posts.fromJson(json["posts"]),
      );
}

class Posts {
  int? currentPage;
  List<PostData> data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<CommonLink> links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  Posts({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
  });

  factory Posts.fromJson(Map<String, dynamic> json) => Posts(
        currentPage: json["current_page"],
        data: List<PostData>.from(json["data"].map((x) => PostData.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: List<CommonLink>.from(json["links"].map((x) => CommonLink.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );
}

class PostData {
  int? id;
  int? userId;
  int? type;
  String? content;
  String? images;
  int? postCategoryId;
  int? isPublic;
  int? countView;
  int? countShare;
  int? countComment;
  int? countStar;
  dynamic reactions;
  dynamic postSubCategoryId;
  dynamic kidId;
  int? brandId;
  List<dynamic> taggedFriends;
  List<ImageUrl> imageUrls;
  Kid? kid;
  Brand? brand;
  PostCategory? postCategory;
  dynamic postSubCategory;
  List<dynamic> postTags;

  PostData({
    required this.id,
    required this.userId,
    required this.type,
    required this.content,
    required this.images,
    required this.postCategoryId,
    required this.isPublic,
    required this.countView,
    required this.countShare,
    required this.countComment,
    required this.countStar,
    required this.reactions,
    required this.postSubCategoryId,
    required this.kidId,
    required this.brandId,
    required this.taggedFriends,
    required this.imageUrls,
    required this.kid,
    required this.brand,
    required this.postCategory,
    required this.postSubCategory,
    required this.postTags,
  });

  factory PostData.fromJson(Map<String, dynamic> json) => PostData(
        id: json["id"],
        userId: json["user_id"],
        type: json["type"],
        content: json["content"],
        images: json["images"],
        postCategoryId: json["post_category_id"],
        isPublic: json["is_public"],
        countView: json["count_view"],
        countShare: json["count_share"],
        countComment: json["count_comment"],
        countStar: json["count_star"],
        reactions: json["reactions"],
        postSubCategoryId: json["post_sub_category_id"],
        kidId: json["kid_id"],
        brandId: json["brand_id"],
        taggedFriends: List<dynamic>.from(json["tagged_friends"].map((x) => x)),
        imageUrls: List<ImageUrl>.from(json["image_urls"].map((x) => ImageUrl.fromJson(x))),
        kid: json["kid"] == null ? null : Kid.fromJson(json["kid"]),
        brand: json["brand"] == null ? null : Brand.fromJson(json["brand"]),
        postCategory: PostCategory.fromJson(json["post_category"]),
        postSubCategory: json["post_sub_category"],
        postTags: List<dynamic>.from(json["post_tags"].map((x) => x)),
      );
}

class Brand {
  int? id;
  int? userId;
  String? name;
  String? image;
  String? socialLinks;
  String? brandImage;

  Brand({
    required this.id,
    required this.userId,
    required this.name,
    required this.image,
    required this.socialLinks,
    required this.brandImage,
  });

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
        id: json["id"],
        userId: json["user_id"],
        name: json["name"],
        image: json["image"],
        socialLinks: json["social_links"],
        brandImage: json["brand_image"],
      );
}

class ImageUrl {
  int? id;
  String? path;
  String? fullPath;

  ImageUrl({
    required this.id,
    required this.path,
    required this.fullPath,
  });

  factory ImageUrl.fromJson(Map<String, dynamic> json) => ImageUrl(
        id: json["id"],
        path: json["path"],
        fullPath: json["full_path"],
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

class Kid {
  int? id;
  int? userId;
  String? name;
  String? image;
  int? age;
  String? kidImage;

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

class PostDataModel {
    PostData post;

    PostDataModel({
        required this.post,
    });

    factory PostDataModel.fromJson(Map<String, dynamic> json) => PostDataModel(
        post: PostData.fromJson(json["post"]),
    );

}
