import 'package:bip_hip/models/common/common_friend_family_user_model.dart';
import 'package:bip_hip/models/common/common_link_model.dart';
import 'package:bip_hip/models/common/common_user_model.dart';
import 'package:bip_hip/models/menu/profile/common_list_models.dart';
import 'package:bip_hip/models/post/new_post_comment.dart';
import 'package:get/get.dart';

class PostDataModel {
  PostDataRx post;

  PostDataModel({
    required this.post,
  });

  factory PostDataModel.fromJson(Map<String, dynamic> json) => PostDataModel(
        post: PostDataRx.fromJson(json["post"]),
      );
}

class PostListModel {
  Posts? posts;

  PostListModel({
    required this.posts,
  });

  factory PostListModel.fromJson(Map<String, dynamic> json) => PostListModel(
        posts: json["posts"] == null ? null : Posts.fromJson(json["posts"]),
      );
}

class Posts {
  int? currentPage;
  List<PostDataRx> data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<CommonLink> links;
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
        data: List<PostDataRx>.from(json["data"].map((x) => PostDataRx.fromJson(x))),
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

class PostDataRx {
  int? id;
  int? userId;
  int? isSharePost;
  dynamic sharePostId;
  String? content;
  dynamic location;
  int? sellPostType;
  int? sellPostCategoryId;
  int? sellPostConditionId;
  int? price;
  int? discount;
  int? isBidding;
  String? description;
  int? sellPostAvailabilty;
  String? productTags;
  String? sku;
  int? isHideFnf;
  String? platform;
  dynamic action;
  dynamic biddingPostType;
  dynamic desireAmount;
  dynamic minBiddingAmount;
  dynamic biddingDuration;
  dynamic title;
  DateTime? dateTime;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? postCategoryId;
  int? isPublic;
  RxInt? countView;
  RxInt? countShare;
  RxInt? countComment;
  RxInt? countStar;
  Rx<CountReactions>? countReactions;
  dynamic postSubCategoryId;
  int? kidId;
  int? storeId;
  dynamic timelineId;
  dynamic type;
  dynamic reviewRating;
  List<FriendFamilyUserData> taggedFriends;
  RxInt? countBids;
  User? user;
  Brand? kid;
  Brand? store;
  PostCategory? postCategory;
  dynamic postSubCategory;
  List<dynamic> postTags;
  RxList<ImageElement> images;
  RxList<CommentDataRx> comments;
  RxString? myReaction;
  SharePosts? sharePosts;
  bool? isNotifaction;
  bool? hasReport;

  PostDataRx({
    required this.id,
    required this.userId,
    required this.isSharePost,
    required this.sharePostId,
    required this.content,
    required this.location,
    required this.reviewRating,
    required this.countBids,
    required this.sellPostType,
    required this.sellPostCategoryId,
    required this.sellPostConditionId,
    required this.price,
    this.isBidding,
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
    required this.dateTime,
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
    required this.storeId,
    required this.timelineId,
    required this.type,
    required this.taggedFriends,
    required this.user,
    required this.kid,
    required this.store,
    required this.postCategory,
    required this.postSubCategory,
    required this.postTags,
    required this.images,
    required this.comments,
    required this.myReaction,
    this.sharePosts,
    required this.isNotifaction,
    required this.hasReport,
  });

  factory PostDataRx.fromJson(Map<String, dynamic> json) => PostDataRx(
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
        isBidding: json["is_bidding"],
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
        dateTime: json["date_time"] == null ? null : DateTime.parse(json["date_time"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        postCategoryId: json["post_category_id"],
        isPublic: json["is_public"],
        countView: RxInt(json["count_view"]),
        countShare: RxInt(json["count_share"]),
        countComment: RxInt(json["count_comment"]),
        countStar: RxInt(json["count_star"]),
        countReactions:
            json["count_reactions"] == null || json["count_reactions"] == 0 ? null : Rx<CountReactions>(CountReactions.fromJson(json["count_reactions"])),
        postSubCategoryId: json["post_sub_category_id"],
        kidId: json["kid_id"],
        storeId: json["store_id"],
        reviewRating: json["review_rating"],
        timelineId: json["timeline_id"],
        countBids: RxInt(json["count_bids"]),
        type: json["type"],
        taggedFriends:
            json["tagged_friends"] == null ? [] : List<FriendFamilyUserData>.from(json["tagged_friends"].map((x) => FriendFamilyUserData.fromJson(x))),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        kid: json["kid"] == null ? null : Brand.fromJson(json["kid"]),
        store: json["store"] == null ? null : Brand.fromJson(json["store"]),
        postCategory: json["post_category"] == null ? null : PostCategory.fromJson(json["post_category"]),
        postSubCategory: json["post_sub_category"],
        postTags: json["post_tags"] == null ? [] : List<dynamic>.from(json["post_tags"].map((x) => x)),
        images: json["images"] == null ? RxList<ImageElement>([]) : RxList<ImageElement>.from(json["images"].map((x) => ImageElement.fromJson(x))),
        comments: json["comments"] == null ? RxList<CommentDataRx>([]) : RxList<CommentDataRx>.from(json["comments"].map((x) => CommentDataRx.fromJson(x))),
        myReaction: json["my_reaction"] == null ? null : RxString(json["my_reaction"]),
        sharePosts: json["share_posts"] == null ? null : SharePosts.fromJson(json["share_posts"]),
        isNotifaction: json["is_notifaction"],
        hasReport: json["has_report"],
      );
}

class SharePosts {
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
  int? isHideFnf;
  dynamic platform;
  dynamic action;
  int? isBidding;
  dynamic biddingPostType;
  dynamic desireAmount;
  dynamic minBiddingAmount;
  dynamic biddingDuration;
  dynamic title;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? postCategoryId;
  int? isPublic;
  RxInt? countView;
  RxInt? countShare;
  RxInt? countComment;
  RxInt? countStar;
  Rx<CountReactions>? countReactions;
  int? postSubCategoryId;
  dynamic timelineId;
  dynamic type;
  int? kidId;
  dynamic storeId;
  dynamic reviewRating;
  dynamic imageAlbumId;
  List<FriendFamilyUserData> taggedFriends;
  int? countBids;
  RxString? myReaction;
  List<String> viewers;
  bool? hasReport;
  bool? isNotifaction;
  bool? isVisibleToMe;
  int? countReaction;
  User? user;
  Brand? kid;
  Brand? store;
  PostCategory? postCategory;
  PostCategory? postSubCategory;
  List<dynamic> postTags;
  RxList<ImageElement> images;

  SharePosts({
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
    required this.isBidding,
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
    required this.timelineId,
    required this.type,
    required this.kidId,
    required this.storeId,
    required this.reviewRating,
    required this.imageAlbumId,
    required this.taggedFriends,
    required this.countBids,
    required this.myReaction,
    required this.viewers,
    required this.hasReport,
    required this.isNotifaction,
    required this.isVisibleToMe,
    required this.countReaction,
    required this.user,
    required this.kid,
    required this.store,
    required this.postCategory,
    required this.postSubCategory,
    required this.postTags,
    required this.images,
  });

  factory SharePosts.fromJson(Map<String, dynamic> json) => SharePosts(
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
        isBidding: json["is_bidding"],
        biddingPostType: json["bidding_post_type"],
        desireAmount: json["desire_amount"],
        minBiddingAmount: json["min_bidding_amount"],
        biddingDuration: json["bidding_duration"],
        title: json["title"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        postCategoryId: json["post_category_id"],
        isPublic: json["is_public"],
        countView: RxInt(json["count_view"]),
        countShare: RxInt(json["count_share"]),
        countComment: RxInt(json["count_comment"]),
        countStar: RxInt(json["count_star"]),
        countReactions:
            json["count_reactions"] == null || json["count_reactions"] == 0 ? null : Rx<CountReactions>(CountReactions.fromJson(json["count_reactions"])),
        postSubCategoryId: json["post_sub_category_id"],
        timelineId: json["timeline_id"],
        type: json["type"],
        kidId: json["kid_id"],
        storeId: json["store_id"],
        reviewRating: json["review_rating"],
        imageAlbumId: json["image_album_id"],
        taggedFriends: List<FriendFamilyUserData>.from(json["tagged_friends"].map((x) => x)),
        countBids: json["count_bids"],
        myReaction: json["my_reaction"] == null ? null : RxString(json["my_reaction"]),
        viewers: List<String>.from(json["viewers"].map((x) => x)),
        hasReport: json["has_report"],
        isNotifaction: json["is_notifaction"],
        isVisibleToMe: json["is_visible_to_me"],
        countReaction: json["count_reaction"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        kid: json["kid"] == null ? null : Brand.fromJson(json["kid"]),
        store: json["store"] == null ? null : Brand.fromJson(json["store"]),
        postCategory: json["post_category"] == null ? null : PostCategory.fromJson(json["post_category"]),
        postSubCategory: json["post_sub_category"] == null ? null : PostCategory.fromJson(json["post_sub_category"]),
        postTags: List<dynamic>.from(json["post_tags"].map((x) => x)),
        images: RxList<ImageElement>.from(json["images"].map((x) => ImageElement.fromJson(x))),
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
  String? profilePicture;

  Brand({
    required this.id,
    required this.userId,
    required this.name,
    required this.image,
    this.socialLinks,
    this.brandImage,
    this.age,
    this.kidImage,
    required this.profilePicture,
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
      profilePicture: json["profile_picture"]);
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
  String? description;
  dynamic imageTakenTime;
  dynamic imageTakenLocation;
  int? countView;
  int? countShare;
  int? countComment;
  int? countStar;
  Rx<CountReactions>? countReactions;
  String? fullPath;
  List<FriendFamilyUserData> taggedFriends;
  int? totalViewCount;
  RxString? myReaction;

  ImageElement(
      {required this.id,
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
      required this.myReaction});

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
        countReactions:
            json["count_reactions"] == null || json["count_reactions"] == 0 ? null : Rx<CountReactions>(CountReactions.fromJson(json["count_reactions"])),
        fullPath: json["full_path"],
        taggedFriends: List<FriendFamilyUserData>.from(json["tagged_friends"].map((x) => FriendFamilyUserData.fromJson(x))),
        totalViewCount: json["total_view_count"],
        myReaction: json["my_reaction"] == null ? null : RxString(json["my_reaction"]),
      );
}

class MentionUser {
  int? id;
  String? fullName;

  MentionUser({
    required this.id,
    required this.fullName,
  });

  factory MentionUser.fromJson(Map<String, dynamic> json) => MentionUser(
        id: json["id"],
        fullName: json["full_name"],
      );
}

class CountReactions {
  RxInt? all;
  RxInt? haha;
  RxInt? like;
  RxInt? love;
  RxInt? sad;
  RxInt? wow;
  RxInt? angry;

  CountReactions({
    required this.all,
    required this.haha,
    required this.like,
    required this.love,
    required this.sad,
    required this.wow,
    required this.angry,
  });

  factory CountReactions.fromJson(Map<String, dynamic> json) => CountReactions(
      all: RxInt(json["All"] ?? 0),
      haha: RxInt(json["haha"] ?? 0),
      like: RxInt(json["like"] ?? 0),
      love: RxInt(json["love"] ?? 0),
      sad: RxInt(json["sad"] ?? 0),
      wow: RxInt(json["wow"] ?? 0),
      angry: RxInt(json["angry"] ?? 0));

  Map<String, dynamic> toJson() => {
        "All": all,
        "haha": haha,
        "like": like,
        "love": love,
        "sad": sad,
        "wow": wow,
        "angry": angry,
      };
}
