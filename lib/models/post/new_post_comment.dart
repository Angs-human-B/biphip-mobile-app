import 'package:bip_hip/models/common/common_link_model.dart';
import 'package:bip_hip/models/common/common_user_model.dart';
import 'package:bip_hip/models/home/new_post_list_model.dart';
import 'package:bip_hip/models/menu/profile/common_list_models.dart';
import 'package:get/get.dart';

class PostCommentModel {
  CommentsRx? comments;

  PostCommentModel({
    required this.comments,
  });

  factory PostCommentModel.fromJson(Map<String, dynamic> json) => PostCommentModel(
        comments: json["comments"] == null ? null : CommentsRx.fromJson(json["comments"]),
      );
}

class CommentsRx {
  int? currentPage;
  List<CommentDataRx> data;
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

  CommentsRx({
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

  factory CommentsRx.fromJson(Map<String, dynamic> json) => CommentsRx(
        currentPage: json["current_page"],
        data: List<CommentDataRx>.from(json["data"].map((x) => CommentDataRx.fromJson(x))),
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

class CommentDataRx {
  int? id;
  int? userId;
  Rx<CountReactions>? countReactions;
  String? comment;
  dynamic mentionUserIds;
  int? isEdit;
  dynamic image;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? refType;
  int? refId;
  dynamic deletedAt;
  List<dynamic> mentionUsers;
  RefRelation? refRelation;
  RxString? myReaction;
  int? countReply;
  bool? hasReport;
  int? countStar;
  RxList<CommentReply> commentReplies;
  User? user;
  dynamic postStar;

  CommentDataRx({
    required this.id,
    required this.userId,
    required this.countReactions,
    required this.comment,
    required this.mentionUserIds,
    required this.isEdit,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.refType,
    required this.refId,
    required this.deletedAt,
    required this.mentionUsers,
    required this.refRelation,
    required this.myReaction,
    required this.countReply,
    required this.hasReport,
    required this.countStar,
    required this.commentReplies,
    required this.user,
    required this.postStar,
  });

  factory CommentDataRx.fromJson(Map<String, dynamic> json) => CommentDataRx(
        id: json["id"],
        userId: json["user_id"],
        countReactions: json["count_reactions"] == null ? null : Rx<CountReactions>(CountReactions.fromJson(json["count_reactions"])),
        comment: json["comment"],
        mentionUserIds: json["mention_user_ids"],
        isEdit: json["is_edit"],
        image: json["image"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        refType: json["ref_type"],
        refId: json["ref_id"],
        deletedAt: json["deleted_at"],
        mentionUsers: List<dynamic>.from(json["mention_users"].map((x) => x)),
        refRelation: json["ref_relation"] == null ? null : RefRelation.fromJson(json["ref_relation"]),
        myReaction: json["my_reaction"] == null ? null : RxString(json["my_reaction"]),
        countReply: json["count_reply"],
        hasReport: json["has_report"],
        countStar: json["count_star"],
        commentReplies: RxList<CommentReply>.from(json["comment_replies"].map((x) => CommentReply.fromJson(x))),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        postStar: json["post_star"],
      );
}

class CommentReply {
  int? id;
  int? commentId;
  int? userId;
  Rx<CountReactions>? countReactions;
  String? reply;
  dynamic mentionUserIds;
  int? isEdit;
  dynamic image;
  dynamic deletedAt;
  List<dynamic> mentionUsers;
  RxString? myReaction;
  User? user;
  DateTime createdAt;
  DateTime updatedAt;

  CommentReply({
    required this.id,
    required this.commentId,
    required this.userId,
    required this.countReactions,
    required this.reply,
    required this.mentionUserIds,
    required this.isEdit,
    required this.image,
    required this.deletedAt,
    required this.mentionUsers,
    required this.myReaction,
    required this.user,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CommentReply.fromJson(Map<String, dynamic> json) => CommentReply(
        id: json["id"],
        commentId: json["comment_id"],
        userId: json["user_id"],
        countReactions: json["count_reactions"] == null ? null : Rx<CountReactions>(CountReactions.fromJson(json["count_reactions"])),
        reply: json["reply"],
        mentionUserIds: json["mention_user_ids"],
        isEdit: json["is_edit"],
        image: json["image"],
        deletedAt: json["deleted_at"],
        mentionUsers: List<dynamic>.from(json["mention_users"].map((x) => x)),
        myReaction: json["my_reaction"] == null ? null : RxString(json["my_reaction"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );
}

class RefRelation {
  RefRelationData? post;

  RefRelation({
    required this.post,
  });

  factory RefRelation.fromJson(Map<String, dynamic> json) => RefRelation(
        post: json["post"] == null ? null : RefRelationData.fromJson(json["post"]),
      );
}

class ReactionUser {
  int? id;
  String? fullName;
  String? profilePicture;

  ReactionUser({
    required this.id,
    required this.fullName,
    required this.profilePicture,
  });

  factory ReactionUser.fromJson(Map<String, dynamic> json) => ReactionUser(
        id: json["id"],
        fullName: json["full_name"],
        profilePicture: json["profile_picture"],
      );
}

class RefRelationData {
  int? id;
  int? userId;
  int? isSharePost;
  int? sharePostId;
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
  dynamic biddingDuration;
  String? title;
  DateTime? dateTime;
  //!problem
  DateTime? createdAt;
  DateTime? updatedAt;
  int? postCategoryId;
  int? isPublic;
  int? countView;
  int? countShare;
  int? countComment;
  int? countStar;
  CountReactions? countReactions;
  dynamic postSubCategoryId;
  dynamic timelineId;
  dynamic type;
  dynamic kidId;
  int? storeId;
  dynamic reviewRating;
  dynamic imageAlbumId;
  int? countBids;
  dynamic myReaction;
  bool? hasReport;
  bool? isNotifaction;
  bool? isVisibleToMe;
  int? countReaction;
  User? user;
  Brand? kid;
  Brand? store;
  PostCategory? postCategory;
  dynamic postSubCategory;
  List<dynamic>? postTags;
  List<ImageElement>? images;
  List<CommentDataRx>? comments;
  SharePosts? sharePosts;

  RefRelationData({
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
    required this.timelineId,
    required this.type,
    required this.kidId,
    required this.storeId,
    required this.reviewRating,
    required this.imageAlbumId,
    required this.countBids,
    required this.myReaction,
    required this.hasReport,
    required this.isNotifaction,
    required this.isVisibleToMe,
    required this.countReaction,
    this.user,
    this.kid,
    this.store,
    this.postCategory,
    this.postSubCategory,
    this.postTags,
    this.images,
    this.comments,
    this.sharePosts,
  });

  factory RefRelationData.fromJson(Map<String, dynamic> json) => RefRelationData(
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
        countReactions: json["count_reactions"] == null ? null : CountReactions.fromJson(json["count_reactions"]),
        postSubCategoryId: json["post_sub_category_id"],
        timelineId: json["timeline_id"],
        type: json["type"],
        kidId: json["kid_id"],
        storeId: json["store_id"],
        reviewRating: json["review_rating"],
        imageAlbumId: json["image_album_id"],
        countBids: json["count_bids"],
        myReaction: json["my_reaction"],
        hasReport: json["has_report"],
        isNotifaction: json["is_notifaction"],
        isVisibleToMe: json["is_visible_to_me"],
        countReaction: json["count_reaction"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        kid: json["kid"] == null ? null : Brand.fromJson(json["kid"]),
        store: json["store"] == null ? null : Brand.fromJson(json["store"]),
        postCategory: json["post_category"] == null ? null : PostCategory.fromJson(json["post_category"]),
        postSubCategory: json["post_sub_category"],
        postTags: json["post_tags"] == null ? [] : List<dynamic>.from(json["post_tags"]!.map((x) => x)),
        images: json["images"] == null ? [] : List<ImageElement>.from(json["images"]!.map((x) => ImageElement.fromJson(x))),
        comments: json["comments"] == null ? [] : List<CommentDataRx>.from(json["comments"]!.map((x) => CommentDataRx.fromJson(x))),
        sharePosts: json["share_posts"] == null ? null : SharePosts.fromJson(json["share_posts"]),
      );
}
