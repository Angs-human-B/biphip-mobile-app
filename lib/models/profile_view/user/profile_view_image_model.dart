import 'package:bip_hip/models/common/common_link_model.dart';
import 'package:bip_hip/models/common/common_user_model.dart';

class ProfileViewImageModel {
  Images? images;

  ProfileViewImageModel({
    this.images,
  });

  factory ProfileViewImageModel.fromJson(Map<String, dynamic> json) => ProfileViewImageModel(
        images: json["images"] == null ? null : Images.fromJson(json["images"]),
      );
}

class Images {
  int? currentPage;
  List<ImageData>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<CommonLink>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  Images({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory Images.fromJson(Map<String, dynamic> json) => Images(
        currentPage: json["current_page"],
        data: json["data"] == null ? [] : List<ImageData>.from(json["data"]!.map((x) => ImageData.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: json["links"] == null ? [] : List<CommonLink>.from(json["links"]!.map((x) => CommonLink.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );
}

class DatumPost {
  int? id;
  int? userId;
  int? isSharePost;
  dynamic sharePostId;
  String? content;
  String? location;
  int? sellPostType;
  int? sellPostCategoryId;
  int? sellPostConditionId;
  int? price;
  int? discount;
  String? description;
  int? sellPostAvailabilty;
  String? productTags;
  String? sku;
  int? isHideFnf;
  dynamic platform;
  dynamic action;
  int? isBidding;
  int? biddingPostType;
  int? desireAmount;
  int? minBiddingAmount;
  DateTime? biddingDuration;
  String? title;
  DateTime? dateTime;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? postCategoryId;
  int? isPublic;
  int? countView;
  int? countShare;
  int? countComment;
  int? countStar;
  FluffyCountReactions? countReactions;
  dynamic postSubCategoryId;
  dynamic timelineId;
  dynamic type;
  dynamic kidId;
  int? storeId;
  dynamic reviewRating;
  dynamic imageAlbumId;
  List<dynamic>? taggedFriends;
  int? countBids;
  dynamic myReaction;
  List<ReactionUser>? reactionUsers;
  List<String>? viewers;
  bool? hasReport;
  bool? myReport;
  bool? isNotifaction;
  bool? isVisibleToMe;
  int? countReaction;
  User? user;
  dynamic timeline;
  PostCategory? postCategory;
  dynamic postSubCategory;
  List<dynamic>? postTags;
  List<ImageData>? images;
  List<Comment>? comments;

  DatumPost({
    this.id,
    this.userId,
    this.isSharePost,
    this.sharePostId,
    this.content,
    this.location,
    this.sellPostType,
    this.sellPostCategoryId,
    this.sellPostConditionId,
    this.price,
    this.discount,
    this.description,
    this.sellPostAvailabilty,
    this.productTags,
    this.sku,
    this.isHideFnf,
    this.platform,
    this.action,
    this.isBidding,
    this.biddingPostType,
    this.desireAmount,
    this.minBiddingAmount,
    this.biddingDuration,
    this.title,
    this.dateTime,
    this.createdAt,
    this.updatedAt,
    this.postCategoryId,
    this.isPublic,
    this.countView,
    this.countShare,
    this.countComment,
    this.countStar,
    this.countReactions,
    this.postSubCategoryId,
    this.timelineId,
    this.type,
    this.kidId,
    this.storeId,
    this.reviewRating,
    this.imageAlbumId,
    this.taggedFriends,
    this.countBids,
    this.myReaction,
    this.reactionUsers,
    this.viewers,
    this.hasReport,
    this.myReport,
    this.isNotifaction,
    this.isVisibleToMe,
    this.countReaction,
    this.user,
    this.timeline,
    this.postCategory,
    this.postSubCategory,
    this.postTags,
    this.images,
    this.comments,
  });

  factory DatumPost.fromJson(Map<String, dynamic> json) => DatumPost(
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
        biddingDuration: json["bidding_duration"] == null ? null : DateTime.parse(json["bidding_duration"]),
        title: json["title"],
        dateTime: json["date_time"] == null ? null : DateTime.parse(json["date_time"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        postCategoryId: json["post_category_id"],
        isPublic: json["is_public"],
        countView: json["count_view"],
        countShare: json["count_share"],
        countComment: json["count_comment"],
        countStar: json["count_star"],
        countReactions: json["count_reactions"] == null ? null : FluffyCountReactions.fromJson(json["count_reactions"]),
        postSubCategoryId: json["post_sub_category_id"],
        timelineId: json["timeline_id"],
        type: json["type"],
        kidId: json["kid_id"],
        storeId: json["store_id"],
        reviewRating: json["review_rating"],
        imageAlbumId: json["image_album_id"],
        taggedFriends: json["tagged_friends"] == null ? [] : List<dynamic>.from(json["tagged_friends"]!.map((x) => x)),
        countBids: json["count_bids"],
        myReaction: json["my_reaction"],
        reactionUsers: json["reaction_users"] == null ? [] : List<ReactionUser>.from(json["reaction_users"]!.map((x) => ReactionUser.fromJson(x))),
        viewers: json["viewers"] == null ? [] : List<String>.from(json["viewers"]!.map((x) => x)),
        hasReport: json["has_report"],
        myReport: json["my_report"],
        isNotifaction: json["is_notifaction"],
        isVisibleToMe: json["is_visible_to_me"],
        countReaction: json["count_reaction"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        timeline: json["timeline"],
        postCategory: json["post_category"] == null ? null : PostCategory.fromJson(json["post_category"]),
        postSubCategory: json["post_sub_category"],
        postTags: json["post_tags"] == null ? [] : List<dynamic>.from(json["post_tags"]!.map((x) => x)),
        images: json["images"] == null ? [] : List<ImageData>.from(json["images"]!.map((x) => ImageData.fromJson(x))),
        comments: json["comments"] == null ? [] : List<Comment>.from(json["comments"]!.map((x) => Comment.fromJson(x))),
      );
}

class ImageData {
  int? id;
  int? userId;
  int? postId;
  String? fileType;
  int? imageAlbumId;
  dynamic imageType;
  String? storageType;
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
  DateTime? createdAt;
  DateTime? updatedAt;
  String? fullPath;
  List<dynamic>? taggedFriends;
  List<String>? reactingPersons;
  int? totalViewCount;
  dynamic myReaction;
  DatumPost? post;

  ImageData({
    this.id,
    this.userId,
    this.postId,
    this.fileType,
    this.imageAlbumId,
    this.imageType,
    this.storageType,
    this.mimeType,
    this.title,
    this.storagePath,
    this.path,
    this.filesize,
    this.description,
    this.imageTakenTime,
    this.imageTakenLocation,
    this.countView,
    this.countShare,
    this.countComment,
    this.countStar,
    this.countReactions,
    this.createdAt,
    this.updatedAt,
    this.fullPath,
    this.taggedFriends,
    this.reactingPersons,
    this.totalViewCount,
    this.myReaction,
    this.post,
  });

  factory ImageData.fromJson(Map<String, dynamic> json) => ImageData(
        id: json["id"],
        userId: json["user_id"],
        postId: json["post_id"],
        fileType: json["file_type"],
        imageAlbumId: json["image_album_id"],
        imageType: json["image_type"],
        storageType: json["storage_type"],
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
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        fullPath: json["full_path"],
        taggedFriends: json["tagged_friends"] == null ? [] : List<dynamic>.from(json["tagged_friends"]!.map((x) => x)),
        reactingPersons: List<String>.from(json["reacting_persons"].map((x) => x)),
        totalViewCount: json["total_view_count"],
        myReaction: json["my_reaction"],
        post: json["post"] == null ? null : DatumPost.fromJson(json["post"]),
      );
}

class Comment {
  int? id;
  int? userId;
  dynamic countReactions;
  String? comment;
  dynamic mentionUserIds;
  int? isEdit;
  dynamic image;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? refType;
  int? refId;
  dynamic deletedAt;
  List<dynamic>? mentionUsers;
  RefRelation? refRelation;
  dynamic myReaction;
  int? countReply;
  bool? hasReport;
  bool? myReport;
  int? countStar;
  List<dynamic>? commentReplies;
  User? user;
  dynamic postStar;

  Comment({
    this.id,
    this.userId,
    this.countReactions,
    this.comment,
    this.mentionUserIds,
    this.isEdit,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.refType,
    this.refId,
    this.deletedAt,
    this.mentionUsers,
    this.refRelation,
    this.myReaction,
    this.countReply,
    this.hasReport,
    this.myReport,
    this.countStar,
    this.commentReplies,
    this.user,
    this.postStar,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["id"],
        userId: json["user_id"],
        countReactions: json["count_reactions"],
        comment: json["comment"],
        mentionUserIds: json["mention_user_ids"],
        isEdit: json["is_edit"],
        image: json["image"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        refType: json["ref_type"],
        refId: json["ref_id"],
        deletedAt: json["deleted_at"],
        mentionUsers: json["mention_users"] == null ? [] : List<dynamic>.from(json["mention_users"]!.map((x) => x)),
        refRelation: json["ref_relation"] == null ? null : RefRelation.fromJson(json["ref_relation"]),
        myReaction: json["my_reaction"],
        countReply: json["count_reply"],
        hasReport: json["has_report"],
        myReport: json["my_report"],
        countStar: json["count_star"],
        commentReplies: json["comment_replies"] == null ? [] : List<dynamic>.from(json["comment_replies"]!.map((x) => x)),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        postStar: json["post_star"],
      );
}

class RefRelation {
  RefRelationPost? post;

  RefRelation({
    this.post,
  });

  factory RefRelation.fromJson(Map<String, dynamic> json) => RefRelation(
        post: json["post"] == null ? null : RefRelationPost.fromJson(json["post"]),
      );
}

class RefRelationPost {
  int? id;
  int? userId;
  int? isSharePost;
  dynamic sharePostId;
  String? content;
  String? location;
  int? sellPostType;
  int? sellPostCategoryId;
  int? sellPostConditionId;
  dynamic price;
  dynamic discount;
  String? description;
  dynamic sellPostAvailabilty;
  String? productTags;
  String? sku;
  int? isHideFnf;
  dynamic platform;
  dynamic action;
  int? isBidding;
  int? biddingPostType;
  int? desireAmount;
  int? minBiddingAmount;
  dynamic biddingDuration;
  String? title;
  DateTime? dateTime;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? postCategoryId;
  int? isPublic;
  int? countView;
  int? countShare;
  int? countComment;
  int? countStar;
  PurpleCountReactions? countReactions;
  dynamic postSubCategoryId;
  dynamic timelineId;
  dynamic type;
  dynamic kidId;
  int? storeId;
  dynamic reviewRating;
  dynamic imageAlbumId;
  List<dynamic>? taggedFriends;
  int? countBids;
  dynamic myReaction;
  List<ReactionUser>? reactionUsers;
  List<String>? viewers;
  bool? hasReport;
  bool? myReport;
  bool? isNotifaction;
  bool? isVisibleToMe;
  int? countReaction;

  RefRelationPost({
    this.id,
    this.userId,
    this.isSharePost,
    this.sharePostId,
    this.content,
    this.location,
    this.sellPostType,
    this.sellPostCategoryId,
    this.sellPostConditionId,
    this.price,
    this.discount,
    this.description,
    this.sellPostAvailabilty,
    this.productTags,
    this.sku,
    this.isHideFnf,
    this.platform,
    this.action,
    this.isBidding,
    this.biddingPostType,
    this.desireAmount,
    this.minBiddingAmount,
    this.biddingDuration,
    this.title,
    this.dateTime,
    this.createdAt,
    this.updatedAt,
    this.postCategoryId,
    this.isPublic,
    this.countView,
    this.countShare,
    this.countComment,
    this.countStar,
    this.countReactions,
    this.postSubCategoryId,
    this.timelineId,
    this.type,
    this.kidId,
    this.storeId,
    this.reviewRating,
    this.imageAlbumId,
    this.taggedFriends,
    this.countBids,
    this.myReaction,
    this.reactionUsers,
    this.viewers,
    this.hasReport,
    this.myReport,
    this.isNotifaction,
    this.isVisibleToMe,
    this.countReaction,
  });

  factory RefRelationPost.fromJson(Map<String, dynamic> json) => RefRelationPost(
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
        dateTime: json["date_time"] == null ? null : DateTime.parse(json["date_time"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        postCategoryId: json["post_category_id"],
        isPublic: json["is_public"],
        countView: json["count_view"],
        countShare: json["count_share"],
        countComment: json["count_comment"],
        countStar: json["count_star"],
        countReactions: json["count_reactions"] == null ? null : PurpleCountReactions.fromJson(json["count_reactions"]),
        postSubCategoryId: json["post_sub_category_id"],
        timelineId: json["timeline_id"],
        type: json["type"],
        kidId: json["kid_id"],
        storeId: json["store_id"],
        reviewRating: json["review_rating"],
        imageAlbumId: json["image_album_id"],
        taggedFriends: json["tagged_friends"] == null ? [] : List<dynamic>.from(json["tagged_friends"]!.map((x) => x)),
        countBids: json["count_bids"],
        myReaction: json["my_reaction"],
        reactionUsers: json["reaction_users"] == null ? [] : List<ReactionUser>.from(json["reaction_users"]!.map((x) => ReactionUser.fromJson(x))),
        viewers: json["viewers"] == null ? [] : List<String>.from(json["viewers"]!.map((x) => x)),
        hasReport: json["has_report"],
        myReport: json["my_report"],
        isNotifaction: json["is_notifaction"],
        isVisibleToMe: json["is_visible_to_me"],
        countReaction: json["count_reaction"],
      );
}

class PurpleCountReactions {
  int? all;
  int? angry;

  PurpleCountReactions({
    this.all,
    this.angry,
  });

  factory PurpleCountReactions.fromJson(Map<String, dynamic> json) => PurpleCountReactions(
        all: json["All"],
        angry: json["angry"],
      );
}

class ReactionUser {
  int? id;
  String? fullName;
  String? profilePicture;

  ReactionUser({
    this.id,
    this.fullName,
    this.profilePicture,
  });

  factory ReactionUser.fromJson(Map<String, dynamic> json) => ReactionUser(
        id: json["id"],
        fullName: json["full_name"],
        profilePicture: json["profile_picture"],
      );
}

class FluffyCountReactions {
  int? all;
  int? angry;
  int? love;

  FluffyCountReactions({
    this.all,
    this.angry,
    this.love,
  });

  factory FluffyCountReactions.fromJson(Map<String, dynamic> json) => FluffyCountReactions(
        all: json["All"],
        angry: json["angry"],
        love: json["love"],
      );

  Map<String, dynamic> toJson() => {
        "All": all,
        "angry": angry,
        "love": love,
      };
}

class PostCategory {
  int? id;
  String? slug;
  String? name;
  int? isActive;
  dynamic createdAt;
  dynamic updatedAt;

  PostCategory({
    this.id,
    this.slug,
    this.name,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory PostCategory.fromJson(Map<String, dynamic> json) => PostCategory(
        id: json["id"],
        slug: json["slug"],
        name: json["name"],
        isActive: json["is_active"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );
}
