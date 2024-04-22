class StorePostModel {
  Posts? posts;

  StorePostModel({
    required this.posts,
  });

  factory StorePostModel.fromJson(Map<String, dynamic> json) => StorePostModel(
        posts: json["posts"] == null ? null : Posts.fromJson(json["posts"]),
      );
}

class Posts {
  int? currentPage;
  List<StorePostData> data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links> links;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
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
        data: List<StorePostData>.from(json["data"].map((x) => StorePostData.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: List<Links>.from(json["links"].map((x) => Links.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );
}

class StorePostData {
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
  dynamic biddingDuration;
  String? title;
  DateTime? dateTime;
  DateTime? createdAt;
  // DateTime updatedAt;
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
  List<dynamic> taggedFriends;
  int? countBids;
  dynamic myReaction;
  List<dynamic> reactionUsers;
  List<dynamic> viewers;
  bool? hasReport;
  bool? myReport;
  bool? isNotifaction;
  bool? isVisibleToMe;
  int? countReaction;
  User? user;
  StoreData? stores;
  PostCategory? postCategory;
  dynamic postSubCategory;
  List<dynamic> postTags;
  List<Image> images;
  List<dynamic> comments;
  dynamic sharePosts;

  StorePostData({
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
    // required this.updatedAt,
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
    required this.reactionUsers,
    required this.viewers,
    required this.hasReport,
    required this.myReport,
    required this.isNotifaction,
    required this.isVisibleToMe,
    required this.countReaction,
    required this.user,
    required this.stores,
    required this.postCategory,
    required this.postSubCategory,
    required this.postTags,
    required this.images,
    required this.comments,
    required this.sharePosts,
  });

  factory StorePostData.fromJson(Map<String, dynamic> json) => StorePostData(
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
        dateTime: DateTime.parse(json["date_time"]),
        createdAt: DateTime.parse(json["created_at"]),
        // updatedAt: DateTime.parse(json["updated_at"]),
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
        taggedFriends: List<dynamic>.from(json["tagged_friends"].map((x) => x)),
        countBids: json["count_bids"],
        myReaction: json["my_reaction"],
        reactionUsers: List<dynamic>.from(json["reaction_users"].map((x) => x)),
        viewers: List<dynamic>.from(json["viewers"].map((x) => x)),
        hasReport: json["has_report"],
        myReport: json["my_report"],
        isNotifaction: json["is_notifaction"],
        isVisibleToMe: json["is_visible_to_me"],
        countReaction: json["count_reaction"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        stores: json["store"] == null ? null : StoreData.fromJson(json["store"]),
        postCategory: json["post_category"] == null ? null : PostCategory.fromJson(json["post_category"]),
        postSubCategory: json["post_sub_category"],
        postTags: List<dynamic>.from(json["post_tags"].map((x) => x)),
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
        comments: List<dynamic>.from(json["comments"].map((x) => x)),
        sharePosts: json["share_posts"],
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
  // DateTime updatedAt;
  String? fullPath;
  List<dynamic> taggedFriends;
  List<String> reactingPersons;
  int? totalViewCount;
  dynamic myReaction;

  Image({
    required this.id,
    required this.userId,
    required this.postId,
    required this.fileType,
    required this.imageAlbumId,
    required this.imageType,
    required this.storageType,
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
    required this.createdAt,
    // required this.updatedAt,
    required this.fullPath,
    required this.taggedFriends,
    required this.reactingPersons,
    required this.totalViewCount,
    required this.myReaction,
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
        createdAt: DateTime.parse(json["created_at"]),
        // updatedAt: DateTime.parse(json["updated_at"]),
        fullPath: json["full_path"],
        taggedFriends: List<dynamic>.from(json["tagged_friends"].map((x) => x)),
        reactingPersons: List<String>.from(json["reacting_persons"].map((x) => x)),
        totalViewCount: json["total_view_count"],
        myReaction: json["my_reaction"],
      );
}

// enum LastName {
//     EMON,
//     SAZID
// }

// final lastNameValues = EnumValues({
//     "Emon": LastName.EMON,
//     "Sazid": LastName.SAZID
// });

class PostCategory {
  int id;
  String slug;
  String name;
  int isActive;
  dynamic createdAt;
  dynamic updatedAt;

  PostCategory({
    required this.id,
    required this.slug,
    required this.name,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PostCategory.fromJson(Map<String, dynamic> json) => PostCategory(
        id: json["id"],
        slug: json["slug"],
        name: json["name"],
        isActive: json["is_active"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "slug": slug,
        "name": name,
        "is_active": isActive,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class StoreData {
  int id;
  String pageType;
  String pageId;
  int userId;
  String name;
  String bio;
  dynamic age;
  dynamic dob;
  dynamic relationId;
  List<String> categories;
  String image;
  String cover;
  String bin;
  dynamic country;
  int rating;
  List<dynamic> hobbies;
  List<dynamic> languages;
  dynamic gender;
  dynamic privacyLink;
  DateTime createdAt;
  DateTime updatedAt;
  String qr;
  String legalFiles;
  dynamic introVideo;
  String email;
  String phone;
  String address;
  String profilePicture;
  String coverPhoto;
  int profileImageId;
  int coverImageId;
  String qrCode;
  List<String> legalPapers;
  dynamic introVideoFile;
  int countFollowers;
  int countPageRating;
  int countPageReviews;
  dynamic relation;
  dynamic chatRoomId;
  Image proImage;
  Image coverImage;

  StoreData({
    required this.id,
    required this.pageType,
    required this.pageId,
    required this.userId,
    required this.name,
    required this.bio,
    required this.age,
    required this.dob,
    required this.relationId,
    required this.categories,
    required this.image,
    required this.cover,
    required this.bin,
    required this.country,
    required this.rating,
    required this.hobbies,
    required this.languages,
    required this.gender,
    required this.privacyLink,
    required this.createdAt,
    required this.updatedAt,
    required this.qr,
    required this.legalFiles,
    required this.introVideo,
    required this.email,
    required this.phone,
    required this.address,
    required this.profilePicture,
    required this.coverPhoto,
    required this.profileImageId,
    required this.coverImageId,
    required this.qrCode,
    required this.legalPapers,
    required this.introVideoFile,
    required this.countFollowers,
    required this.countPageRating,
    required this.countPageReviews,
    required this.relation,
    required this.chatRoomId,
    required this.proImage,
    required this.coverImage,
  });

  factory StoreData.fromJson(Map<String, dynamic> json) => StoreData(
        id: json["id"],
        pageType: json["page_type"],
        pageId: json["page_id"],
        userId: json["user_id"],
        name: json["name"],
        bio: json["bio"],
        age: json["age"],
        dob: json["dob"],
        relationId: json["relation_id"],
        categories: List<String>.from(json["categories"].map((x) => x)),
        image: json["image"],
        cover: json["cover"],
        bin: json["bin"],
        country: json["country"],
        rating: json["rating"],
        hobbies: List<dynamic>.from(json["hobbies"].map((x) => x)),
        languages: List<dynamic>.from(json["languages"].map((x) => x)),
        gender: json["gender"],
        privacyLink: json["privacy_link"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
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
        legalPapers: List<String>.from(json["legal_papers"].map((x) => x)),
        introVideoFile: json["intro_video_file"],
        countFollowers: json["count_followers"],
        countPageRating: json["count_page_rating"],
        countPageReviews: json["count_page_reviews"],
        relation: json["relation"],
        chatRoomId: json["chat_room_id"],
        proImage: Image.fromJson(json["pro_image"]),
        coverImage: Image.fromJson(json["cover_image"]),
      );
}

class User {
  int? id;
  String? image;
  String? userName;
  String? referralCode;
  String? firstName;
  String? lastName;
  String? email;
  dynamic phone;
  String? gender;
  DateTime? dob;
  List<String> profession;
  List<String> interest;
  String? bio;
  List<String> languages;
  String? status;
  dynamic blockTill;
  String? otp;
  DateTime? createdAt;
  // DateTime updatedAt;
  int? refId;
  String? relation;
  dynamic relationWithName;
  dynamic relationWithId;
  dynamic relationSince;
  String? cover;
  dynamic badge;
  int? starBalance;
  dynamic socialProvider;
  String? referralUrl;
  String? fullName;
  String? profilePicture;
  String? coverPhoto;
  String? currentBadge;
  int? friendStatus;
  int? followStatus;
  String? familyRelationStatus;
  int? mutualFriend;
  int? yearsOld;
  dynamic pendent;
  dynamic chatRoomId;

  User({
    required this.id,
    required this.image,
    required this.userName,
    required this.referralCode,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.gender,
    required this.dob,
    required this.profession,
    required this.interest,
    required this.bio,
    required this.languages,
    required this.status,
    required this.blockTill,
    required this.otp,
    required this.createdAt,
    // required this.updatedAt,
    required this.refId,
    required this.relation,
    required this.relationWithName,
    required this.relationWithId,
    required this.relationSince,
    required this.cover,
    required this.badge,
    required this.starBalance,
    required this.socialProvider,
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
    required this.pendent,
    required this.chatRoomId,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        image: json["image"],
        userName: json["user_name"],
        referralCode: json["referral_code"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        phone: json["phone"],
        gender: json["gender"],
        dob: DateTime.parse(json["dob"]),
        profession: List<String>.from(json["profession"].map((x) => x)),
        interest: List<String>.from(json["interest"].map((x) => x)),
        bio: json["bio"],
        languages: List<String>.from(json["languages"].map((x) => x)),
        status: json["status"],
        blockTill: json["block_till"],
        otp: json["otp"],
        createdAt: DateTime.parse(json["created_at"]),
        refId: json["ref_id"],
        relation: json["relation"],
        relationWithName: json["relation_with_name"],
        relationWithId: json["relation_with_id"],
        relationSince: json["relation_since"],
        cover: json["cover"],
        badge: json["badge"],
        starBalance: json["star_balance"],
        socialProvider: json["social_provider"],
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

class Links {
  String? url;
  String? label;
  bool? active;

  Links({
    required this.url,
    required this.label,
    required this.active,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );
}
