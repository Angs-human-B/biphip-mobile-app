
import 'package:bip_hip/models/common/common_link_model.dart';
import 'package:bip_hip/models/common/common_user_model.dart';

class ProfileViewAwardModel {
    Awards? awards;

    ProfileViewAwardModel({
        this.awards,
    });

    factory ProfileViewAwardModel.fromJson(Map<String, dynamic> json) => ProfileViewAwardModel(
        awards: json["awards"] == null ? null : Awards.fromJson(json["awards"]),
    );
}

class Awards {
    int? currentPage;
    List<AllAwardData>? data;
    String? firstPageUrl;
    int? from;
    int? lastPage;
    String? lastPageUrl;
    List<CommonLink>? links;
    dynamic nextPageUrl;
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
        data: json["data"] == null ? [] : List<AllAwardData>.from(json["data"]!.map((x) => AllAwardData.fromJson(x))),
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

class AllAwardData {
    int? id;
    int? postCategoryId;
    int? postId;
    int? userId;
    int? rank;
    DateTime? winDate;
    int? participants;
    DateTime? createdAt;
    DateTime? updatedAt;
    PostCategory? postCategory;
    User? user;
    Post? post;

    AllAwardData({
        this.id,
        this.postCategoryId,
        this.postId,
        this.userId,
        this.rank,
        this.winDate,
        this.participants,
        this.createdAt,
        this.updatedAt,
        this.postCategory,
        this.user,
        this.post,
    });

    factory AllAwardData.fromJson(Map<String, dynamic> json) => AllAwardData(
        id: json["id"],
        postCategoryId: json["post_category_id"],
        postId: json["post_id"],
        userId: json["user_id"],
        rank: json["rank"],
        winDate: json["win_date"] == null ? null : DateTime.parse(json["win_date"]),
        participants: json["participants"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        postCategory: json["post_category"] == null ? null : PostCategory.fromJson(json["post_category"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        post: json["post"] == null ? null : Post.fromJson(json["post"]),
    );
}

class Post {
    int? id;
    int? userId;
    int? isSharePost;
    dynamic sharePostId;
    dynamic content;
    dynamic location;
    int? sellPostType;
    dynamic sellPostCategoryId;
    dynamic sellPostConditionId;
    dynamic price;
    dynamic discount;
    dynamic description;
    dynamic sellPostAvailabilty;
    dynamic productTags;
    dynamic sku;
    int? isHideFnf;
    String? platform;
    String? action;
    int? isBidding;
    dynamic biddingPostType;
    int? desireAmount;
    dynamic minBiddingAmount;
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
    dynamic countReactions;
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
    List<dynamic>? reactionUsers;
    List<dynamic>? viewers;
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
    List<Image>? images;
    List<dynamic>? comments;

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
        this.user,
        this.timeline,
        this.postCategory,
        this.postSubCategory,
        this.postTags,
        this.images,
        this.comments,
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
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        timeline: json["timeline"],
        postCategory: json["post_category"] == null ? null : PostCategory.fromJson(json["post_category"]),
        postSubCategory: json["post_sub_category"],
        postTags: json["post_tags"] == null ? [] : List<dynamic>.from(json["post_tags"]!.map((x) => x)),
        images: json["images"] == null ? [] : List<Image>.from(json["images"]!.map((x) => Image.fromJson(x))),
        comments: json["comments"] == null ? [] : List<dynamic>.from(json["comments"]!.map((x) => x)),
    );
}

class Image {
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

    Image({
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
    });

    factory Image.fromJson(Map<String, dynamic> json) => Image(
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
        reactingPersons: json["reacting_persons"] == null ? [] : List<String>.from(json["reacting_persons"]!.map((x) => x)),
        totalViewCount: json["total_view_count"],
        myReaction: json["my_reaction"],
    );

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