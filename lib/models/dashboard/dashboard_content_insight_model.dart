class DashboardContentInsightModel {
    String? type;
    Post? post;
    int? countView;
    int? countEngagement;
    int? countGift;
    int? countComment;
    int? countShare;
    int? countReaction;
    int? countReactionLove;
    int? countReactionLike;
    int? countReactionHaha;
    int? countReactionWow;
    int? countReactionSad;
    int? countReactionAngry;

    DashboardContentInsightModel({
        this.type,
        this.post,
        this.countView,
        this.countEngagement,
        this.countGift,
        this.countComment,
        this.countShare,
        this.countReaction,
        this.countReactionLove,
        this.countReactionLike,
        this.countReactionHaha,
        this.countReactionWow,
        this.countReactionSad,
        this.countReactionAngry,
    });

    factory DashboardContentInsightModel.fromJson(Map<String, dynamic> json) => DashboardContentInsightModel(
        type: json["type"],
        post: json["post"] == null ? null : Post.fromJson(json["post"]),
        countView: json["count_view"],
        countEngagement: json["count_engagement"],
        countGift: json["count_gift"],
        countComment: json["count_comment"],
        countShare: json["count_share"],
        countReaction: json["count_reaction"],
        countReactionLove: json["count_reaction_love"],
        countReactionLike: json["count_reaction_like"],
        countReactionHaha: json["count_reaction_haha"],
        countReactionWow: json["count_reaction_wow"],
        countReactionSad: json["count_reaction_sad"],
        countReactionAngry: json["count_reaction_angry"],
    );
}

class Post {
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
    dynamic title;
    DateTime? dateTime;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic postCategoryId;
    int? isPublic;
    int? countView;
    int? countShare;
    int? countComment;
    int? countStar;
    dynamic countReactions;
    dynamic postSubCategoryId;
    int? timelineId;
    int? type;
    dynamic kidId;
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
        countReactions: json["count_reactions"],
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
