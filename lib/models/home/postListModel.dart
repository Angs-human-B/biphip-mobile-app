import 'package:bip_hip/models/common/common_user_model.dart';
import 'package:bip_hip/models/menu/profile/common_list_models.dart';

class PostDataModel {
  PostData post;

  PostDataModel({
    required this.post,
  });

  factory PostDataModel.fromJson(Map<String, dynamic> json) => PostDataModel(
        post: PostData.fromJson(json["post"]),
      );
}

// class PostListModel {
//   Posts posts;

//   PostListModel({
//     required this.posts,
//   });

//   factory PostListModel.fromJson(Map<String, dynamic> json) => PostListModel(
//         posts: Posts.fromJson(json["posts"]),
//       );
// }

// class Posts {
//   int? currentPage;
//   List<PostData> data;
//   String? firstPageUrl;
//   int? from;
//   int? lastPage;
//   String? lastPageUrl;
//   List<Link> links;
//   String? nextPageUrl;
//   String? path;
//   int? perPage;
//   dynamic prevPageUrl;
//   int? to;
//   int? total;

//   Posts({
//     required this.currentPage,
//     required this.data,
//     required this.firstPageUrl,
//     required this.from,
//     required this.lastPage,
//     required this.lastPageUrl,
//     required this.links,
//     required this.nextPageUrl,
//     required this.path,
//     required this.perPage,
//     required this.prevPageUrl,
//     required this.to,
//     required this.total,
//   });

//   factory Posts.fromJson(Map<String, dynamic> json) => Posts(
//         currentPage: json["current_page"],
//         data: List<PostData>.from(json["data"].map((x) => PostData.fromJson(x))),
//         firstPageUrl: json["first_page_url"],
//         from: json["from"],
//         lastPage: json["last_page"],
//         lastPageUrl: json["last_page_url"],
//         links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
//         nextPageUrl: json["next_page_url"],
//         path: json["path"],
//         perPage: json["per_page"],
//         prevPageUrl: json["prev_page_url"],
//         to: json["to"],
//         total: json["total"],
//       );
// }

// class PostData {
//   int? id;
//   int? userId;
//   String? content;
//   dynamic location;
//   dynamic sellPostType;
//   dynamic sellPostCategoryId;
//   dynamic sellPostConditionId;
//   dynamic price;
//   dynamic discount;
//   dynamic description;
//   dynamic sellPostAvailabilty;
//   dynamic productTags;
//   dynamic sku;
//   dynamic isHideFnf;
//   dynamic platform;
//   dynamic action;
//   dynamic biddingPostType;
//   dynamic desireAmount;
//   dynamic minBiddingAmount;
//   dynamic biddingDuration;
//   dynamic title;
//   int? postCategoryId;
//   int? isPublic;
//   int? countView;
//   int? countShare;
//   int? countComment;
//   int? countStar;
//   dynamic countReactions;
//   dynamic postSubCategoryId;
//   int? kidId;
//   int? brandId;
//   List<dynamic> taggedFriends;
//   User? user;
//   Brand? kid;
//   Brand? brand;
//   PostCategory? postCategory;
//   dynamic postSubCategory;
//   List<dynamic> postTags;
//   List<ImageElement> images;

//   PostData({
//     required this.id,
//     required this.userId,
//     required this.content,
//     required this.location,
//     required this.sellPostType,
//     required this.sellPostCategoryId,
//     required this.sellPostConditionId,
//     required this.price,
//     required this.discount,
//     required this.description,
//     required this.sellPostAvailabilty,
//     required this.productTags,
//     required this.sku,
//     required this.isHideFnf,
//     required this.platform,
//     required this.action,
//     required this.biddingPostType,
//     required this.desireAmount,
//     required this.minBiddingAmount,
//     required this.biddingDuration,
//     required this.title,
//     required this.postCategoryId,
//     required this.isPublic,
//     required this.countView,
//     required this.countShare,
//     required this.countComment,
//     required this.countStar,
//     required this.countReactions,
//     required this.postSubCategoryId,
//     required this.kidId,
//     required this.brandId,
//     required this.taggedFriends,
//     required this.user,
//     required this.kid,
//     required this.brand,
//     required this.postCategory,
//     required this.postSubCategory,
//     required this.postTags,
//     required this.images,
//   });

//   factory PostData.fromJson(Map<String, dynamic> json) => PostData(
//         id: json["id"],
//         userId: json["user_id"],
//         content: json["content"],
//         location: json["location"],
//         sellPostType: json["sell_post_type"],
//         sellPostCategoryId: json["sell_post_category_id"],
//         sellPostConditionId: json["sell_post_condition_id"],
//         price: json["price"],
//         discount: json["discount"],
//         description: json["description"],
//         sellPostAvailabilty: json["sell_post_availabilty"],
//         productTags: json["product_tags"],
//         sku: json["sku"],
//         isHideFnf: json["is_hide_fnf"],
//         platform: json["platform"],
//         action: json["action"],
//         biddingPostType: json["bidding_post_type"],
//         desireAmount: json["desire_amount"],
//         minBiddingAmount: json["min_bidding_amount"],
//         biddingDuration: json["bidding_duration"],
//         title: json["title"],
//         postCategoryId: json["post_category_id"],
//         isPublic: json["is_public"],
//         countView: json["count_view"],
//         countShare: json["count_share"],
//         countComment: json["count_comment"],
//         countStar: json["count_star"],
//         countReactions: json["count_reactions"],
//         postSubCategoryId: json["post_sub_category_id"],
//         kidId: json["kid_id"],
//         brandId: json["brand_id"],
//         taggedFriends: List<dynamic>.from(json["tagged_friends"].map((x) => x)),
//         user: User.fromJson(json["user"]),
//         kid: json["kid"] == null ? null : Brand.fromJson(json["kid"]),
//         brand: json["brand"] == null ? null : Brand.fromJson(json["brand"]),
//         postCategory: PostCategory.fromJson(json["post_category"]),
//         postSubCategory: json["post_sub_category"],
//         postTags: List<dynamic>.from(json["post_tags"].map((x) => x)),
//         images: List<ImageElement>.from(json["images"].map((x) => ImageElement.fromJson(x))),
//       );
// }

// class Brand {
//   int? id;
//   int? userId;
//   String? name;
//   String? image;
//   String? socialLinks;
//   String? brandImage;
//   int? age;
//   String? kidImage;

//   Brand({
//     required this.id,
//     required this.userId,
//     required this.name,
//     required this.image,
//     this.socialLinks,
//     this.brandImage,
//     this.age,
//     this.kidImage,
//   });

//   factory Brand.fromJson(Map<String, dynamic> json) => Brand(
//         id: json["id"],
//         userId: json["user_id"],
//         name: json["name"],
//         image: json["image"],
//         socialLinks: json["social_links"],
//         brandImage: json["brand_image"],
//         age: json["age"],
//         kidImage: json["kid_image"],
//       );
// }

// class ImageElement {
//   int? id;
//   int? userId;
//   int? postId;
//   int? imageAlbumId;
//   dynamic imageType;
//   dynamic mimeType;
//   String? title;
//   String? storagePath;
//   String? path;
//   int? filesize;
//   dynamic description;
//   dynamic imageTakenTime;
//   dynamic imageTakenLocation;
//   String? fullPath;
//   List<TaggedFriend> taggedFriends;

//   ImageElement({
//     required this.id,
//     required this.userId,
//     required this.postId,
//     required this.imageAlbumId,
//     required this.imageType,
//     required this.mimeType,
//     required this.title,
//     required this.storagePath,
//     required this.path,
//     required this.filesize,
//     required this.description,
//     required this.imageTakenTime,
//     required this.imageTakenLocation,
//     required this.fullPath,
//     required this.taggedFriends,
//   });

//   factory ImageElement.fromJson(Map<String, dynamic> json) => ImageElement(
//         id: json["id"],
//         userId: json["user_id"],
//         postId: json["post_id"],
//         imageAlbumId: json["image_album_id"],
//         imageType: json["image_type"],
//         mimeType: json["mime_type"],
//         title: json["title"],
//         storagePath: json["storage_path"],
//         path: json["path"],
//         filesize: json["filesize"],
//         description: json["description"],
//         imageTakenTime: json["image_taken_time"],
//         imageTakenLocation: json["image_taken_location"],
//         fullPath: json["full_path"],
//         taggedFriends: List<TaggedFriend>.from(json["tagged_friends"].map((x) => TaggedFriend.fromJson(x))),
//       );
// }

// class TaggedFriend {
//   int? id;
//   String? firstName;
//   String? lastName;
//   String? image;
//   String? referralUrl;
//   String? fullName;
//   String? profilePicture;
//   dynamic coverPhoto;
//   String? currentBadge;
//   int? friendStatus;
//   int? followStatus;
//   dynamic familyRelationStatus;
//   int? mutualFriend;

//   TaggedFriend({
//     required this.id,
//     required this.firstName,
//     required this.lastName,
//     required this.image,
//     required this.referralUrl,
//     required this.fullName,
//     required this.profilePicture,
//     required this.coverPhoto,
//     required this.currentBadge,
//     required this.friendStatus,
//     required this.followStatus,
//     required this.familyRelationStatus,
//     required this.mutualFriend,
//   });

//   factory TaggedFriend.fromJson(Map<String, dynamic> json) => TaggedFriend(
//         id: json["id"],
//         firstName: json["first_name"],
//         lastName: json["last_name"],
//         image: json["image"],
//         referralUrl: json["referral_url"],
//         fullName: json["full_name"],
//         profilePicture: json["profile_picture"],
//         coverPhoto: json["cover_photo"],
//         currentBadge: json["current_badge"],
//         friendStatus: json["friend_status"],
//         followStatus: json["follow_status"],
//         familyRelationStatus: json["family_relation_status"],
//         mutualFriend: json["mutual_friend"],
//       );
// }

// class Link {
//   String? url;
//   String? label;
//   bool? active;

//   Link({
//     required this.url,
//     required this.label,
//     required this.active,
//   });

//   factory Link.fromJson(Map<String, dynamic> json) => Link(
//         url: json["url"],
//         label: json["label"],
//         active: json["active"],
//       );
// }
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
  List<Link> links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
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
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
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
  int? isSharePost;
  dynamic sharePostId;
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
  DateTime createdAt;
  DateTime updatedAt;
  int? postCategoryId;
  int? isPublic;
  int? countView;
  int? countShare;
  int? countComment;
  int? countStar;
  dynamic countReactions;
  dynamic postSubCategoryId;
  int? kidId;
  int? brandId;
  dynamic timelineId;
  dynamic type;
  List<TaggedFriend> taggedFriends;
  User? user;
  Brand? kid;
  Brand? brand;
  PostCategory? postCategory;
  dynamic postSubCategory;
  List<dynamic> postTags;
  List<ImageElement> images;
  List<dynamic> comments;

  PostData({
    required this.id,
    required this.userId,
    required this.isSharePost,
    required this.sharePostId,
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
    required this.createdAt,
    required this.updatedAt,
    required this.postCategoryId,
    required this.isPublic,
    required this.countView,
    required this.countShare,
    required this.countComment,
    required this.countStar,
    required this.countReactions,
    required this.postSubCategoryId,
    required this.kidId,
    required this.brandId,
    required this.timelineId,
    required this.type,
    required this.taggedFriends,
    required this.user,
    required this.kid,
    required this.brand,
    required this.postCategory,
    required this.postSubCategory,
    required this.postTags,
    required this.images,
    required this.comments,
  });

  factory PostData.fromJson(Map<String, dynamic> json) => PostData(
        id: json["id"],
        userId: json["user_id"],
        isSharePost: json["is_share_post"],
        sharePostId: json["share_post_id"],
        content: json["content"],
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
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        postCategoryId: json["post_category_id"],
        isPublic: json["is_public"],
        countView: json["count_view"],
        countShare: json["count_share"],
        countComment: json["count_comment"],
        countStar: json["count_star"],
        countReactions: json["count_reactions"],
        postSubCategoryId: json["post_sub_category_id"],
        kidId: json["kid_id"],
        brandId: json["brand_id"],
        timelineId: json["timeline_id"],
        type: json["type"],
        taggedFriends: List<TaggedFriend>.from(json["tagged_friends"].map((x) => TaggedFriend.fromJson(x))),
        user: User.fromJson(json["user"]),
        kid: json["kid"] == null ? null : Brand.fromJson(json["kid"]),
        brand: json["brand"] == null ? null : Brand.fromJson(json["brand"]),
        postCategory: json["post_category"] == null ? null : PostCategory.fromJson(json["post_category"]),
        postSubCategory: json["post_sub_category"],
        postTags: List<dynamic>.from(json["post_tags"].map((x) => x)),
        images: List<ImageElement>.from(json["images"].map((x) => ImageElement.fromJson(x))),
        comments: List<dynamic>.from(json["comments"].map((x) => x)),
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
    this.socialLinks,
    this.brandImage,
    this.age,
    this.kidImage,
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

class ImageElement {
  int? id;
  int? userId;
  int? postId;
  int? imageAlbumId;
  dynamic imageType;
  dynamic mimeType;
  String? title;
  String? storagePath;
  String? path;
  int? filesize;
  dynamic description;
  dynamic imageTakenTime;
  dynamic imageTakenLocation;
  int? countView;
  int? countShare;
  int? countComment;
  int? countStar;
  dynamic countReactions;
  String? fullPath;
  List<TaggedFriend> taggedFriends;
  int? totalViewCount;

  ImageElement({
    required this.id,
    required this.userId,
    required this.postId,
    required this.imageAlbumId,
    required this.imageType,
    required this.mimeType,
    required this.title,
    required this.storagePath,
    required this.path,
    required this.filesize,
    required this.description,
    required this.imageTakenTime,
    required this.imageTakenLocation,
    required this.countView,
    required this.countShare,
    required this.countComment,
    required this.countStar,
    required this.countReactions,
    required this.fullPath,
    required this.taggedFriends,
    required this.totalViewCount,
  });

  factory ImageElement.fromJson(Map<String, dynamic> json) => ImageElement(
        id: json["id"],
        userId: json["user_id"],
        postId: json["post_id"],
        imageAlbumId: json["image_album_id"],
        imageType: json["image_type"],
        mimeType: json["mime_type"],
        title: json["title"],
        storagePath: json["storage_path"],
        path: json["path"],
        filesize: json["filesize"],
        description: json["description"],
        imageTakenTime: json["image_taken_time"],
        imageTakenLocation: json["image_taken_location"],
        countView: json["count_view"],
        countShare: json["count_share"],
        countComment: json["count_comment"],
        countStar: json["count_star"],
        countReactions: json["count_reactions"],
        fullPath: json["full_path"],
        taggedFriends: List<TaggedFriend>.from(json["tagged_friends"].map((x) => TaggedFriend.fromJson(x))),
        totalViewCount: json["total_view_count"],
      );
}

class TaggedFriend {
  int? id;
  String? firstName;
  String? lastName;
  String? image;
  String? referralUrl;
  String? fullName;
  String? profilePicture;
  dynamic coverPhoto;
  String? currentBadge;
  int? friendStatus;
  int? followStatus;
  dynamic familyRelationStatus;
  int? mutualFriend;
  dynamic yearsOld;

  TaggedFriend({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.image,
    required this.referralUrl,
    required this.fullName,
    required this.profilePicture,
    required this.coverPhoto,
    required this.currentBadge,
    required this.friendStatus,
    required this.followStatus,
    required this.familyRelationStatus,
    required this.mutualFriend,
    required this.yearsOld,
  });

  factory TaggedFriend.fromJson(Map<String, dynamic> json) => TaggedFriend(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        image: json["image"],
        referralUrl: json["referral_url"],
        fullName: json["full_name"],
        profilePicture: json["profile_picture"],
        coverPhoto: json["cover_photo"],
        currentBadge: json["current_badge"],
        friendStatus: json["friend_status"],
        followStatus: json["follow_status"],
        familyRelationStatus: json["family_relation_status"],
        mutualFriend: json["mutual_friend"],
        yearsOld: json["years_old"],
      );
}

class Link {
  String? url;
  String? label;
  bool? active;

  Link({
    required this.url,
    required this.label,
    required this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );
}
