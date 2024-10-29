import 'package:bip_hip/models/common/common_link_model.dart';

class DashboardOverviewModel {
  int? followers;
  int? postReach;
  int? postReachPercentage;
  int? postEngagement;
  int? postEngagementPercentage;
  int? newFollowers;
  int? newFollowersPercentage;
  Contents? contents;
  Audience? audience;

  DashboardOverviewModel({
    this.followers,
    this.postReach,
    this.postReachPercentage,
    this.postEngagement,
    this.postEngagementPercentage,
    this.newFollowers,
    this.newFollowersPercentage,
    this.contents,
    this.audience,
  });

  factory DashboardOverviewModel.fromJson(Map<String, dynamic> json) => DashboardOverviewModel(
        followers: json["followers"],
        postReach: json["post_reach"],
        postReachPercentage: json["post_reach_percentage"],
        postEngagement: json["post_engagement"],
        postEngagementPercentage: json["post_engagement_percentage"],
        newFollowers: json["new_followers"],
        newFollowersPercentage: json["new_followers_percentage"],
        contents: json["contents"] == null ? null : Contents.fromJson(json["contents"]),
        audience: json["audience"] == null ? null : Audience.fromJson(json["audience"]),
      );
}

class Audience {
  int? men;
  int? women;
  Map<String, AgeGroup>? ageGroup;

  Audience({
    this.men,
    this.women,
    this.ageGroup,
  });

  factory Audience.fromJson(Map<String, dynamic> json) => Audience(
        men: json["men"],
        women: json["women"],
        ageGroup: Map.from(json["age_group"]!).map((k, v) => MapEntry<String, AgeGroup>(k, AgeGroup.fromJson(v))),
      );
}

class AgeGroup {
  int? men;
  int? women;

  AgeGroup({
    this.men,
    this.women,
  });

  factory AgeGroup.fromJson(Map<String, dynamic> json) => AgeGroup(
        men: json["men"],
        women: json["women"],
      );
}

class Contents {
  int? currentPage;
  List<OverviewContentData>? data;
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

  Contents({
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

  factory Contents.fromJson(Map<String, dynamic> json) => Contents(
        currentPage: json["current_page"],
        data: json["data"] == null ? [] : List<OverviewContentData>.from(json["data"]!.map((x) => OverviewContentData.fromJson(x))),
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

class OverviewContentData {
  int? id;
  DateTime? createdAt;
  String? type;
  int? engagement;
  int? countStars;
  int? countViews;
  Details? details;
  List<dynamic>? taggedFriends;
  int? countBids;
  String? myReaction;
  List<ReactionUser>? reactionUsers;
  List<dynamic>? viewers;
  bool? hasReport;
  bool? myReport;
  bool? isNotifaction;
  bool? isVisibleToMe;
  int? countReaction;

  OverviewContentData({
    this.id,
    this.createdAt,
    this.type,
    this.engagement,
    this.countStars,
    this.countViews,
    this.details,
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

  factory OverviewContentData.fromJson(Map<String, dynamic> json) => OverviewContentData(
        id: json["id"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        type: json["type"],
        engagement: json["engagement"],
        countStars: json["count_stars"],
        countViews: json["count_views"],
        details: json["details"] == null ? null : Details.fromJson(json["details"]),
        taggedFriends: json["tagged_friends"] == null ? [] : List<dynamic>.from(json["tagged_friends"]!.map((x) => x)),
        countBids: json["count_bids"],
        myReaction: json["my_reaction"],
        reactionUsers: json["reaction_users"] == null ? [] : List<ReactionUser>.from(json["reaction_users"]!.map((x) => ReactionUser.fromJson(x))),
        viewers: json["viewers"] == null ? [] : List<dynamic>.from(json["viewers"]!.map((x) => x)),
        hasReport: json["has_report"],
        myReport: json["my_report"],
        isNotifaction: json["is_notifaction"],
        isVisibleToMe: json["is_visible_to_me"],
        countReaction: json["count_reaction"],
      );
}

class Details {
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
  int? isBidding;
  dynamic biddingPostType;
  dynamic desireAmount;
  dynamic minBiddingAmount;
  dynamic biddingDuration;
  String? title;
  DateTime? dateTime;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic postCategoryId;
  int? isPublic;
  int? countView;
  int? countShare;
  int? countComment;
  int? countStar;
  CountReactions? countReactions;
  dynamic postSubCategoryId;
  int? timelineId;
  int? type;
  dynamic kidId;
  dynamic storeId;
  dynamic reviewRating;
  dynamic imageAlbumId;
  List<dynamic>? taggedFriends;
  int? countBids;
  String? myReaction;
  List<ReactionUser>? reactionUsers;
  List<dynamic>? viewers;
  bool? hasReport;
  bool? myReport;
  bool? isNotifaction;
  bool? isVisibleToMe;
  int? countReaction;
  int? fileType;
  int? storageType;
  String? storagePath;
  String? path;
  int? privacy;
  String? visibleUserIds;
  String? fullPath;
  int? countViews;
  List<dynamic>? viewerImages;
  List<dynamic>? myReactions;
  int? countStars;
  int? countMyStars;

  Details({
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
    this.fileType,
    this.storageType,
    this.storagePath,
    this.path,
    this.privacy,
    this.visibleUserIds,
    this.fullPath,
    this.countViews,
    this.viewerImages,
    this.myReactions,
    this.countStars,
    this.countMyStars,
  });

  factory Details.fromJson(Map<String, dynamic> json) => Details(
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
        taggedFriends: json["tagged_friends"] == null ? [] : List<dynamic>.from(json["tagged_friends"]!.map((x) => x)),
        countBids: json["count_bids"],
        myReaction: json["my_reaction"],
        reactionUsers: json["reaction_users"] == null ? [] : List<ReactionUser>.from(json["reaction_users"]!.map((x) => ReactionUser.fromJson(x))),
        viewers: json["viewers"] == null ? [] : List<dynamic>.from(json["viewers"]!.map((x) => x)),
        hasReport: json["has_report"],
        myReport: json["my_report"],
        isNotifaction: json["is_notifaction"],
        isVisibleToMe: json["is_visible_to_me"],
        countReaction: json["count_reaction"],
        fileType: json["file_type"],
        storageType: json["storage_type"],
        storagePath: json["storage_path"],
        path: json["path"],
        privacy: json["privacy"],
        visibleUserIds: json["visible_user_ids"],
        fullPath: json["full_path"],
        countViews: json["count_views"],
        viewerImages: json["viewer_images"] == null ? [] : List<dynamic>.from(json["viewer_images"]!.map((x) => x)),
        myReactions: json["my_reactions"] == null ? [] : List<dynamic>.from(json["my_reactions"]!.map((x) => x)),
        countStars: json["count_stars"],
        countMyStars: json["count_my_stars"],
      );
}

class CountReactions {
  int? all;
  int? sad;

  CountReactions({
    this.all,
    this.sad,
  });

  factory CountReactions.fromJson(Map<String, dynamic> json) => CountReactions(
        all: json["All"],
        sad: json["sad"],
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