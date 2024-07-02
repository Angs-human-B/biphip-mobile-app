import 'package:bip_hip/models/common/common_user_model.dart';

class DashboardContentsModel {
    Contents? contents;

    DashboardContentsModel({
        this.contents,
    });

    factory DashboardContentsModel.fromJson(Map<String, dynamic> json) => DashboardContentsModel(
        contents: json["contents"] == null ? null : Contents.fromJson(json["contents"]),
    );
}

class Contents {
    int? currentPage;
    List<ContentData>? data;
    String? firstPageUrl;
    int? from;
    int? lastPage;
    String? lastPageUrl;
    List<Link>? links;
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
        data: json["data"] == null ? [] : List<ContentData>.from(json["data"]!.map((x) => ContentData.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: json["links"] == null ? [] : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
    );
}

class ContentData {
    int? id;
    DateTime? createdAt;
    String? type;
    int? engagement;
    int? countStars;
    int? countViews;
    Details? details;
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

    ContentData({
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

    factory ContentData.fromJson(Map<String, dynamic> json) => ContentData(
        id: json["id"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        type: json["type"],
        engagement: json["engagement"],
        countStars: json["count_stars"],
        countViews: json["count_views"],
        details: json["details"] == null ? null : Details.fromJson(json["details"]),
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
    User? user;
    dynamic timeline;
    Kid? kid;
    dynamic store;
    PostCategory? postCategory;
    dynamic postSubCategory;
    List<PostTag>? postTags;
    List<ImageElement>? images;
    List<dynamic>? comments;
    dynamic sharePosts;

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
        this.user,
        this.timeline,
        this.kid,
        this.store,
        this.postCategory,
        this.postSubCategory,
        this.postTags,
        this.images,
        this.comments,
        this.sharePosts,
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
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        timeline: json["timeline"],
        kid: json["kid"] == null ? null : Kid.fromJson(json["kid"]),
        store: json["store"],
        postCategory: json["post_category"] == null ? null : PostCategory.fromJson(json["post_category"]),
        postSubCategory: json["post_sub_category"],
        postTags: json["post_tags"] == null ? [] : List<PostTag>.from(json["post_tags"]!.map((x) => PostTag.fromJson(x))),
        images: json["images"] == null ? [] : List<ImageElement>.from(json["images"]!.map((x) => ImageElement.fromJson(x))),
        comments: json["comments"] == null ? [] : List<dynamic>.from(json["comments"]!.map((x) => x)),
        sharePosts: json["share_posts"],
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

class ImageElement {
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
    String? description;
    DateTime? imageTakenTime;
    String? imageTakenLocation;
    int? countView;
    int? countShare;
    int? countComment;
    int? countStar;
    dynamic countReactions;
    DateTime? createdAt;
    DateTime? updatedAt;
    String? fullPath;
    List<TaggedFriend>? taggedFriends;
    List<dynamic>? reactingPersons;
    int? totalViewCount;
    dynamic myReaction;

    ImageElement({
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

    factory ImageElement.fromJson(Map<String, dynamic> json) => ImageElement(
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
        imageTakenTime: json["image_taken_time"] == null ? null : DateTime.parse(json["image_taken_time"]),
        imageTakenLocation: json["image_taken_location"],
        countView: json["count_view"],
        countShare: json["count_share"],
        countComment: json["count_comment"],
        countStar: json["count_star"],
        countReactions: json["count_reactions"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        fullPath: json["full_path"],
        taggedFriends: json["tagged_friends"] == null ? [] : List<TaggedFriend>.from(json["tagged_friends"]!.map((x) => TaggedFriend.fromJson(x))),
        // reactingPersons: json["reacting_persons"] == null ? [] : List<ReactingPerson>.from(json["reacting_persons"]!.map((x) => reactingPersonValues.map[x]!)),
        reactingPersons: json["reacting_persons"] == null ? [] : List<dynamic>.from(json["reacting_persons"]!.map((x) => x)),
        totalViewCount: json["total_view_count"],
        myReaction: json["my_reaction"],
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


class Kid {
    int? id;
    String? pageType;
    String? pageId;
    int? userId;
    String? name;
    String? bio;
    int? age;
    dynamic dob;
    dynamic relationId;
    List<String>? categories;
    String? image;
    dynamic cover;
    dynamic bin;
    dynamic country;
    int? rating;
    List<String>? hobbies;
    List<dynamic>? languages;
    dynamic gender;
    dynamic privacyLink;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic qr;
    dynamic legalFiles;
    dynamic introVideo;
    dynamic email;
    dynamic phone;
    dynamic address;
    String? profilePicture;
    dynamic coverPhoto;
    int? profileImageId;
    dynamic coverImageId;
    dynamic qrCode;
    dynamic legalPapers;
    dynamic introVideoFile;
    int? countFollowers;
    int? countPageRating;
    int? countPageReviews;
    dynamic relation;
    dynamic chatRoomId;
    ImageElement? proImage;
    dynamic coverImage;

    Kid({
        this.id,
        this.pageType,
        this.pageId,
        this.userId,
        this.name,
        this.bio,
        this.age,
        this.dob,
        this.relationId,
        this.categories,
        this.image,
        this.cover,
        this.bin,
        this.country,
        this.rating,
        this.hobbies,
        this.languages,
        this.gender,
        this.privacyLink,
        this.createdAt,
        this.updatedAt,
        this.qr,
        this.legalFiles,
        this.introVideo,
        this.email,
        this.phone,
        this.address,
        this.profilePicture,
        this.coverPhoto,
        this.profileImageId,
        this.coverImageId,
        this.qrCode,
        this.legalPapers,
        this.introVideoFile,
        this.countFollowers,
        this.countPageRating,
        this.countPageReviews,
        this.relation,
        this.chatRoomId,
        this.proImage,
        this.coverImage,
    });

    factory Kid.fromJson(Map<String, dynamic> json) => Kid(
        id: json["id"],
        pageType: json["page_type"],
        pageId: json["page_id"],
        userId: json["user_id"],
        name: json["name"],
        bio: json["bio"],
        age: json["age"],
        dob: json["dob"],
        relationId: json["relation_id"],
        categories: json["categories"] == null ? [] : List<String>.from(json["categories"]!.map((x) => x)),
        image: json["image"],
        cover: json["cover"],
        bin: json["bin"],
        country: json["country"],
        rating: json["rating"],
        hobbies: json["hobbies"] == null ? [] : List<String>.from(json["hobbies"]!.map((x) => x)),
        languages: json["languages"] == null ? [] : List<dynamic>.from(json["languages"]!.map((x) => x)),
        gender: json["gender"],
        privacyLink: json["privacy_link"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        qr: json["qr"],
        legalFiles: json["legal_files"],
        introVideo: json["intro_video"],
        email: json["email"],
        phone: json["phone"],
        address: json["address"],
        profilePicture: json["profile_picture"],
        coverPhoto: json["cover_photo"],
        profileImageId: json["profile_image_id"],
        coverImageId: json["cover_image_id"],
        qrCode: json["qr_code"],
        legalPapers: json["legal_papers"],
        introVideoFile: json["intro_video_file"],
        countFollowers: json["count_followers"],
        countPageRating: json["count_page_rating"],
        countPageReviews: json["count_page_reviews"],
        relation: json["relation"],
        chatRoomId: json["chat_room_id"],
        proImage: json["pro_image"] == null ? null : ImageElement.fromJson(json["pro_image"]),
        coverImage: json["cover_image"],
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

class PostTag {
    int? id;
    int? postId;
    int? userId;
    DateTime? createdAt;
    DateTime? updatedAt;

    PostTag({
        this.id,
        this.postId,
        this.userId,
        this.createdAt,
        this.updatedAt,
    });

    factory PostTag.fromJson(Map<String, dynamic> json) => PostTag(
        id: json["id"],
        postId: json["post_id"],
        userId: json["user_id"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
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

// class User {
//     int? id;
//     UserImage? image;
//     String? userName;
//     ReferralCode? referralCode;
//     FirstName? firstName;
//     LastName? lastName;
//     Email? email;
//     DateTime? emailVerifiedAt;
//     dynamic phone;
//     dynamic phoneVerifiedAt;
//     Gender? gender;
//     DateTime? dob;
//     List<Profession>? profession;
//     List<Interest>? interest;
//     Bio? bio;
//     List<String>? languages;
//     String? status;
//     dynamic blockTill;
//     dynamic otp;
//     DateTime? createdAt;
//     DateTime? updatedAt;
//     int? refId;
//     dynamic relation;
//     dynamic relationWithName;
//     dynamic relationWithId;
//     dynamic relationSince;
//     Cover? cover;
//     dynamic badge;
//     int? starBalance;
//     dynamic socialProvider;
//     String? referralUrl;
//     FullName? fullName;
//     String? profilePicture;
//     String? coverPhoto;
//     String? currentBadge;
//     int? friendStatus;
//     int? followStatus;
//     dynamic familyRelationStatus;
//     int? mutualFriend;
//     int? yearsOld;
//     dynamic pendent;
//     int? chatRoomId;

//     User({
//         this.id,
//         this.image,
//         this.userName,
//         this.referralCode,
//         this.firstName,
//         this.lastName,
//         this.email,
//         this.emailVerifiedAt,
//         this.phone,
//         this.phoneVerifiedAt,
//         this.gender,
//         this.dob,
//         this.profession,
//         this.interest,
//         this.bio,
//         this.languages,
//         this.status,
//         this.blockTill,
//         this.otp,
//         this.createdAt,
//         this.updatedAt,
//         this.refId,
//         this.relation,
//         this.relationWithName,
//         this.relationWithId,
//         this.relationSince,
//         this.cover,
//         this.badge,
//         this.starBalance,
//         this.socialProvider,
//         this.referralUrl,
//         this.fullName,
//         this.profilePicture,
//         this.coverPhoto,
//         this.currentBadge,
//         this.friendStatus,
//         this.followStatus,
//         this.familyRelationStatus,
//         this.mutualFriend,
//         this.yearsOld,
//         this.pendent,
//         this.chatRoomId,
//     });

//     factory User.fromJson(Map<String, dynamic> json) => User(
//         id: json["id"],
//         image: userImageValues.map[json["image"]]!,
//         userName: referralCodeValues.map[json["user_name"]]!,
//         referralCode: referralCodeValues.map[json["referral_code"]]!,
//         firstName: firstNameValues.map[json["first_name"]]!,
//         lastName: lastNameValues.map[json["last_name"]]!,
//         email: emailValues.map[json["email"]]!,
//         emailVerifiedAt: json["email_verified_at"] == null ? null : DateTime.parse(json["email_verified_at"]),
//         phone: json["phone"],
//         phoneVerifiedAt: json["phone_verified_at"],
//         gender: genderValues.map[json["gender"]]!,
//         dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
//         profession: json["profession"] == null ? [] : List<Profession>.from(json["profession"]!.map((x) => professionValues.map[x]!)),
//         interest: json["interest"] == null ? [] : List<Interest>.from(json["interest"]!.map((x) => interestValues.map[x]!)),
//         bio: bioValues.map[json["bio"]]!,
//         languages: List<String>.from(json["languages"].map((x) => x)),
//         status: json["status"],
//         blockTill: json["block_till"],
//         otp: json["otp"],
//         createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
//         refId: json["ref_id"],
//         relation: json["relation"],
//         relationWithName: json["relation_with_name"],
//         relationWithId: json["relation_with_id"],
//         relationSince: json["relation_since"],
//         cover: coverValues.map[json["cover"]]!,
//         badge: json["badge"],
//         starBalance: json["star_balance"],
//         socialProvider: json["social_provider"],
//         referralUrl: json["referral_url"],
//         fullName: fullNameValues.map[json["full_name"]]!,
//         profilePicture: json["profile_picture"],
//         coverPhoto: json["cover_photo"],
//         currentBadge: json["current_badge"],
//         friendStatus: json["friend_status"],
//         followStatus: json["follow_status"],
//         familyRelationStatus: json["family_relation_status"],
//         mutualFriend: json["mutual_friend"],
//         yearsOld: json["years_old"],
//         pendent: json["pendent"],
//         chatRoomId: json["chat_room_id"],
//     );
//     }
class Link {
    String? url;
    String? label;
    bool? active;

    Link({
        this.url,
        this.label,
        this.active,
    });

    factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
    );
}
