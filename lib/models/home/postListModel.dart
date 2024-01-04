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
  dynamic nextPageUrl;
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
  // int? type;
  String? content;
  dynamic location;
  dynamic sellPostType;
  dynamic sellPostCategoryId;
  dynamic sellPostConditionId;
  dynamic price;
  dynamic discount;
  dynamic description;
  dynamic sellPostAvailabilty;
  dynamic productTags;
  dynamic sku;
  dynamic isHideFnf;
  dynamic platform;
  dynamic action;
  dynamic biddingPostType;
  dynamic desireAmount;
  dynamic minBiddingAmount;
  dynamic biddingDuration;
  dynamic title;
  // String? images;
  int? postCategoryId;
  int? isPublic;
  int? countView;
  int? countShare;
  int? countComment;
  int? countStar;
  dynamic reactions;
  dynamic postSubCategoryId;
  int? kidId;
  int? brandId;
  List<dynamic> taggedFriends;
  // List<ImageUrl> imageUrls;
  User? user;
  Brand? kid;
  Brand? brand;
  PostCategory? postCategory;
  dynamic postSubCategory;
  List<dynamic> postTags;
  List<dynamic> images;
  PostData({
    required this.id,
    required this.userId,
    // required this.type,
    required this.content,
    required this.location,
    required this.sellPostType,
    required this.sellPostCategoryId,
    required this.sellPostConditionId,
    required this.price,
    required this.discount,
    required this.description,
    required this.sellPostAvailabilty,
    required this.productTags,
    required this.sku,
    required this.isHideFnf,
    required this.platform,
    required this.action,
    required this.biddingPostType,
    required this.desireAmount,
    required this.minBiddingAmount,
    required this.biddingDuration,
    required this.title,
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
    // required this.imageUrls,
    required this.user,
    required this.kid,
    required this.brand,
    required this.postCategory,
    required this.postSubCategory,
    required this.postTags,
    required this.images,
  });

  factory PostData.fromJson(Map<String, dynamic> json) => PostData(
        id: json["id"],
        userId: json["user_id"],
        // type: json["type"],
        content: json["content"],
        // images: json["images"],
        location: json["location"],
        sellPostType: json["sell_post_type"],
        sellPostCategoryId: json["sell_post_category_id"],
        sellPostConditionId: json["sell_post_condition_id"],
        price: json["price"],
        discount: json["discount"],
        description: json["description"],
        sellPostAvailabilty: json["sell_post_availabilty"],
        productTags: json["product_tags"],
        sku: json["sku"],
        isHideFnf: json["is_hide_fnf"],
        platform: json["platform"],
        action: json["action"],
        biddingPostType: json["bidding_post_type"],
        desireAmount: json["desire_amount"],
        minBiddingAmount: json["min_bidding_amount"],
        biddingDuration: json["bidding_duration"],
        title: json["title"],
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
        // imageUrls: List<ImageUrl>.from(json["image_urls"].map((x) => ImageUrl.fromJson(x))),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        kid: json["kid"] == null ? null : Brand.fromJson(json["kid"]),
        brand: json["brand"] == null ? null : Brand.fromJson(json["brand"]),
        postCategory: PostCategory.fromJson(json["post_category"]),
        postSubCategory: json["post_sub_category"],
        postTags: List<dynamic>.from(json["post_tags"].map((x) => x)),
        images: List<dynamic>.from(json["images"].map((x) => x)),
      );
}

class Brand {
  int? id;
  int? userId;
  String? name;
  String? image;
  String? socialLinks;
  String? brandImage;
  int? age;
  String? kidImage;

  Brand({
    required this.id,
    required this.userId,
    required this.name,
    required this.image,
    required this.socialLinks,
    required this.brandImage,
    required this.age,
    required this.kidImage,
  });

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
        id: json["id"],
        userId: json["user_id"],
        name: json["name"],
        image: json["image"],
        socialLinks: json["social_links"],
        brandImage: json["brand_image"],
        age: json["age"],
        kidImage: json["kid_image"],
      );
}

// class ImageUrl {
//   int? id;
//   String? path;
//   String? fullPath;

//   ImageUrl({
//     required this.id,
//     required this.path,
//     required this.fullPath,
//   });

//   factory ImageUrl.fromJson(Map<String, dynamic> json) => ImageUrl(
//         id: json["id"],
//         path: json["path"],
//         fullPath: json["full_path"],
//       );
// }

class User {
    int? id;
    String? image;
    String? userName;
    String? referralCode;
    String? firstName;
    String? lastName;
    String? email;
    dynamic phone;
    dynamic phoneVerifiedAt;
    String? gender;
    DateTime? dob;
    List<String> profession;
    List<String> interest;
    String? bio;
    List<String> languages;
    String? status;
    dynamic blockTill;
    String? otp;
    dynamic refId;
    String? relation;
    dynamic relationWithName;
    dynamic relationWithId;
    String? cover;
    dynamic badge;
    dynamic socialProvider;
    String? referralUrl;
    String? fullName;
    String? profilePicture;
    String? coverPhoto;
    String? currentBadge;
    int? friendStatus;
    int? followStatus;
    String? familyRelationStatus;
    int? mutualFriend;

    User({
        required this.id,
        required this.image,
        required this.userName,
        required this.referralCode,
        required this.firstName,
        required this.lastName,
        required this.email,
        required this.phone,
        required this.phoneVerifiedAt,
        required this.gender,
        required this.dob,
        required this.profession,
        required this.interest,
        required this.bio,
        required this.languages,
        required this.status,
        required this.blockTill,
        required this.otp,
        required this.refId,
        required this.relation,
        required this.relationWithName,
        required this.relationWithId,
        required this.cover,
        required this.badge,
        required this.socialProvider,
        required this.referralUrl,
        required this.fullName,
        required this.profilePicture,
        required this.coverPhoto,
        required this.currentBadge,
        required this.friendStatus,
        required this.followStatus,
        required this.familyRelationStatus,
        required this.mutualFriend,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        image: json["image"],
        userName: json["user_name"],
        referralCode: json["referral_code"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        phone: json["phone"],
        phoneVerifiedAt: json["phone_verified_at"],
        gender: json["gender"],
        dob: DateTime.parse(json["dob"]),
        profession: List<String>.from(json["profession"].map((x) => x)),
        interest: List<String>.from(json["interest"].map((x) => x)),
        bio: json["bio"],
        languages: List<String>.from(json["languages"].map((x) => x)),
        status: json["status"],
        blockTill: json["block_till"],
        otp: json["otp"],
        refId: json["ref_id"],
        relation: json["relation"],
        relationWithName: json["relation_with_name"],
        relationWithId: json["relation_with_id"],
        cover: json["cover"],
        badge: json["badge"],
        socialProvider: json["social_provider"],
        referralUrl: json["referral_url"],
        fullName: json["full_name"],
        profilePicture: json["profile_picture"],
        coverPhoto: json["cover_photo"],
        currentBadge: json["current_badge"],
        friendStatus: json["friend_status"],
        followStatus: json["follow_status"],
        familyRelationStatus: json["family_relation_status"],
        mutualFriend: json["mutual_friend"],
    );
}

class PostCategory {
  int? id;
  String? slug;
  String? name;
  int? isActive;

  PostCategory({
    required this.id,
    required this.slug,
    required this.name,
    required this.isActive,
  });

  factory PostCategory.fromJson(Map<String, dynamic> json) => PostCategory(
        id: json["id"],
        slug: json["slug"],
        name: json["name"],
        isActive: json["is_active"],
      );
}

// class Kid {
//   int? id;
//   int? userId;
//   String? name;
//   String? image;
//   int? age;
//   String? kidImage;

//   Kid({
//     required this.id,
//     required this.userId,
//     required this.name,
//     required this.image,
//     required this.age,
//     required this.kidImage,
//   });

//   factory Kid.fromJson(Map<String, dynamic> json) => Kid(
//         id: json["id"],
//         userId: json["user_id"],
//         name: json["name"],
//         image: json["image"],
//         age: json["age"],
//         kidImage: json["kid_image"],
//       );
// }

class PostDataModel {
  PostData post;

  PostDataModel({
    required this.post,
  });

  factory PostDataModel.fromJson(Map<String, dynamic> json) => PostDataModel(
        post: PostData.fromJson(json["post"]),
      );
}
