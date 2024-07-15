import 'package:bip_hip/models/common/common_link_model.dart';

class DashboardGiftEarnedPostModel {
    Posts? posts;

    DashboardGiftEarnedPostModel({
        this.posts,
    });

    factory DashboardGiftEarnedPostModel.fromJson(Map<String, dynamic> json) => DashboardGiftEarnedPostModel(
        posts: json["posts"] == null ? null : Posts.fromJson(json["posts"]),
    );
}

class Posts {
    int? currentPage;
    List<PostData>? data;
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

    Posts({
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

    factory Posts.fromJson(Map<String, dynamic> json) => Posts(
        currentPage: json["current_page"],
        data: json["data"] == null ? [] : List<PostData>.from(json["data"]!.map((x) => PostData.fromJson(x))),
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
    CountReactions? countReactions;
    dynamic postSubCategoryId;
    dynamic timelineId;
    dynamic type;
    int? kidId;
    dynamic storeId;
    dynamic reviewRating;
    dynamic imageAlbumId;
    int? engagements;
    int? countViews;
    int? countStars;
    List<TaggedFriend>? taggedFriends;
    int? countBids;
    String? myReaction;
    List<ReactionUser>? reactionUsers;
    List<String>? viewers;
    bool? hasReport;
    bool? myReport;
    bool? isNotifaction;
    bool? isVisibleToMe;
    int? countReaction;

    PostData({
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
        this.engagements,
        this.countViews,
        this.countStars,
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
        engagements: json["engagements"],
        countViews: json["count_views"],
        countStars: json["count_stars"],
        taggedFriends: json["tagged_friends"] == null ? [] : List<TaggedFriend>.from(json["tagged_friends"]!.map((x) => TaggedFriend.fromJson(x))),
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

class CountReactions {
    int? all;
    int? haha;
    int? wow;

    CountReactions({
        this.all,
        this.haha,
        this.wow,
    });

    factory CountReactions.fromJson(Map<String, dynamic> json) => CountReactions(
        all: json["All"],
        haha: json["haha"],
        wow: json["wow"],
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
    dynamic pendent;
    dynamic chatRoomId;

    TaggedFriend({
        this.id,
        this.firstName,
        this.lastName,
        this.image,
        this.referralUrl,
        this.fullName,
        this.profilePicture,
        this.coverPhoto,
        this.currentBadge,
        this.friendStatus,
        this.followStatus,
        this.familyRelationStatus,
        this.mutualFriend,
        this.yearsOld,
        this.pendent,
        this.chatRoomId,
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
        pendent: json["pendent"],
        chatRoomId: json["chat_room_id"],
    );

}