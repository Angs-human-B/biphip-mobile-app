import 'package:bip_hip/models/common/common_link_model.dart';
import 'package:bip_hip/models/common/common_user_model.dart';

class AwardModel {
  Awards? otherAwards;
  Awards? myAwards;

  AwardModel({
    this.otherAwards,
    this.myAwards,
  });

  factory AwardModel.fromJson(Map<String, dynamic> json) => AwardModel(
        otherAwards: json["other_awards"] == null ? null : Awards.fromJson(json["other_awards"]),
        myAwards: json["my_awards"] == null ? null : Awards.fromJson(json["my_awards"]),
      );
}

class Awards {
  int? currentPage;
  List<AwardData>? data;
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

  Awards({
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

  factory Awards.fromJson(Map<String, dynamic> json) => Awards(
        currentPage: json["current_page"],
        data: json["data"] == null ? [] : List<AwardData>.from(json["data"]!.map((x) => AwardData.fromJson(x))),
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

class AwardData {
  int? id;
  int? postCategoryId;
  int? postId;
  int? userId;
  int? rank;
  DateTime? winDate;
  int? participants;
  PostCategory? postCategory;
  User? user;
  Post? post;

  AwardData({
    this.id,
    this.postCategoryId,
    this.postId,
    this.userId,
    this.rank,
    this.winDate,
    this.participants,
    this.postCategory,
    this.user,
    this.post,
  });

  factory AwardData.fromJson(Map<String, dynamic> json) => AwardData(
        id: json["id"],
        postCategoryId: json["post_category_id"],
        postId: json["post_id"],
        userId: json["user_id"],
        rank: json["rank"],
        winDate: json["win_date"] == null ? null : DateTime.parse(json["win_date"]),
        participants: json["participants"],
        postCategory: json["post_category"] == null ? null : PostCategory.fromJson(json["post_category"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        post: json["post"] == null ? null : Post.fromJson(json["post"]),
      );
}

//! Not use this Post. use common PostDataRx from model(new_post_list_model)
class Post {
    int? id;
    int? userId;
    int? isSharePost;
    dynamic sharePostId;
    String? content;
    String? location;
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
    int? isBidding;
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
    int? countView;
    int? countShare;
    int? countComment;
    int? countStar;
    int? postSubCategoryId;
    dynamic timelineId;
    int? type;
    int? kidId;
    dynamic storeId;
    dynamic reviewRating;
    dynamic imageAlbumId;
    List<dynamic>? taggedFriends;
    int? countBids;
    dynamic myReaction;
    List<dynamic>? reactionUsers;
    List<dynamic>? viewers;
    bool? hasReport;
    bool? myReport;
    bool? isNotifaction;
    bool? isVisibleToMe;
    int? countReaction;

    Post({
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

    factory Post.fromJson(Map<String, dynamic> json) => Post(
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
        reactionUsers: json["reaction_users"] == null ? [] : List<dynamic>.from(json["reaction_users"]!.map((x) => x)),
        viewers: json["viewers"] == null ? [] : List<dynamic>.from(json["viewers"]!.map((x) => x)),
        hasReport: json["has_report"],
        myReport: json["my_report"],
        isNotifaction: json["is_notifaction"],
        isVisibleToMe: json["is_visible_to_me"],
        countReaction: json["count_reaction"],
    );
}


class PostCategory {
  int? id;
  String? slug;
  String? name;
  int? isActive;

  PostCategory({
    this.id,
    this.slug,
    this.name,
    this.isActive,
  });

  factory PostCategory.fromJson(Map<String, dynamic> json) => PostCategory(
        id: json["id"],
        slug: json["slug"],
        name: json["name"],
        isActive: json["is_active"],
      );
}