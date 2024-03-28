class SearchModel {
  Users? users;
  Posts? posts;
  Photos? photos;
  Photos? videos;
  Posts? sellposts;
  Posts? kidposts;
  Posts? newsposts;

  SearchModel({
    required this.users,
    required this.posts,
    required this.photos,
    required this.videos,
    required this.sellposts,
    required this.kidposts,
    required this.newsposts,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
        users: json["users"] == null ? null : Users.fromJson(json["users"]),
        posts: json["posts"] == null ? null : Posts.fromJson(json["posts"]),
        photos: json["photos"] == null ? null : Photos.fromJson(json["photos"]),
        videos: json["videos"] == null ? null : Photos.fromJson(json["videos"]),
        sellposts: json["sellposts"] == null ? null : Posts.fromJson(json["sellposts"]),
        kidposts: json["kidposts"] == null ? null : Posts.fromJson(json["kidposts"]),
        newsposts: json["newsposts"] == null ? null : Posts.fromJson(json["newsposts"]),
      );
}

class Posts {
  int ?currentPage;
  List<PostsData> data;
  String ?firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link> links;
  String? nextPageUrl;
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
        data: List<PostsData>.from(json["data"].map((x) => PostsData.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );
}

class PostsData {
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
  dynamic productTags;
  dynamic sku;
  int? isHideFnf;
  String? platform;
  String? action;
  int? isBidding;
  int? biddingPostType;
  int? desireAmount;
  int? minBiddingAmount;
  String? biddingDuration;
  String? title;
  DateTime? dateTime;
  DateTime? createdAt;
  int ?postCategoryId;
  int ?isPublic;
  int ?countView;
  int ?countShare;
  int ?countComment;
  int ?countStar;
  PurpleCountReactions? countReactions;
  int? postSubCategoryId;
  dynamic timelineId;
  int? type;
  int? kidId;
  int? storeId;
  dynamic reviewRating;
  dynamic imageAlbumId;
  List<dynamic> taggedFriends;
  int? countBids;
  dynamic myReaction;
  List<dynamic> reactionUsers;
  List<String> viewers;
  bool? hasReport;
  dynamic myReport;
  bool ?isNotifaction;
  bool ?isVisibleToMe;
  int ?countReaction;
  UserElement? user;

  PostsData({
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
  });

  factory PostsData.fromJson(Map<String, dynamic> json) => PostsData(
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
        postCategoryId: json["post_category_id"],
        isPublic: json["is_public"],
        countView: json["count_view"],
        countShare: json["count_share"],
        countComment: json["count_comment"],
        countStar: json["count_star"],
        countReactions: json["count_reactions"]==null ? null : PurpleCountReactions.fromJson(json["count_reactions"]),
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
        viewers: List<String>.from(json["viewers"].map((x) => x)),
        hasReport: json["has_report"],
        myReport: json["my_report"],
        isNotifaction: json["is_notifaction"],
        isVisibleToMe: json["is_visible_to_me"],
        countReaction: json["count_reaction"],
        user: json["user"]==null ? null : UserElement.fromJson(json["user"]),
      );
}

class PurpleCountReactions {
  int?all;
  int ?haha;
  int ?like;
  int ?love;
  int ?sad;
  int ?wow;

  PurpleCountReactions({
    required this.all,
    required this.haha,
    required this.like,
    required this.love,
    required this.sad,
    required this.wow,
  });

  factory PurpleCountReactions.fromJson(Map<String, dynamic> json) => PurpleCountReactions(
        all: json["All"],
        haha: json["haha"],
        like: json["like"],
        love: json["love"],
        sad: json["sad"],
        wow: json["wow"],
      );
}

class MyReportClass {
  int? id;
  int? userId;
  int? postId;
  int? reportId;
  String? description;
  DateTime? createdAt;
  // DateTime updatedAt;
  Report? report;

  MyReportClass({
    required this.id,
    required this.userId,
    required this.postId,
    required this.reportId,
    required this.description,
    required this.createdAt,
    // required this.updatedAt,
    required this.report,
  });

  factory MyReportClass.fromJson(Map<String, dynamic> json) => MyReportClass(
        id: json["id"],
        userId: json["user_id"],
        postId: json["post_id"],
        reportId: json["report_id"],
        description: json["description"],
        createdAt: DateTime.parse(json["created_at"]),
        // updatedAt: DateTime.parse(json["updated_at"]),
        report: json["report"]==null ? null : Report.fromJson(json["report"]),
      );
}

class Report {
  int? id;
  String? title;
  String? description;
  int? isEditable;
  int? displayOrder;
  DateTime? createdAt;

  Report({
    required this.id,
    required this.title,
    required this.description,
    required this.isEditable,
    required this.displayOrder,
    required this.createdAt,
  });

  factory Report.fromJson(Map<String, dynamic> json) => Report(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        isEditable: json["is_editable"],
        displayOrder: json["display_order"],
        createdAt: DateTime.parse(json["created_at"]),
      );
}

class UserElement {
  int? id;
  String? image;
  String? userName;
  String? referralCode;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String ?gender;
  DateTime? dob;
  List<String> profession;
  List<String> interest;
  String? bio;
  List<String> languages;
  String? status;
  dynamic blockTill;
  String? otp;
  DateTime? createdAt;
  int? refId;
  String? relation;
  String? relationWithName;
  int? relationWithId;
  DateTime? relationSince;
  String? cover;
  dynamic badge;
  int? starBalance;
  String? socialProvider;
  String? referralUrl;
  String? fullName;
  String? profilePicture;
  String? coverPhoto;
  String? currentBadge;
  int? friendStatus;
  int? followStatus;
  dynamic familyRelationStatus;
  int? mutualFriend;
  int? yearsOld;
  PendentData? pendent;
  dynamic chatRoomId;

  UserElement({
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

  factory UserElement.fromJson(Map<String, dynamic> json) => UserElement(
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
        relationSince: json["relation_since"] == null ? null : DateTime.parse(json["relation_since"]),
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
        pendent: json["pendent"] == null ? null : PendentData.fromJson(json["pendent"]),
        chatRoomId: json["chat_room_id"],
      );
}

class PendentData {
  int? id;
  int? pendentId;
  int? userId;
  DateTime? startDate;
  DateTime? endDate;
  int? isActive;
  String? pendentPurchaseHistory;
  PendentPendent? pendent;

  PendentData({
    required this.id,
    required this.pendentId,
    required this.userId,
    required this.startDate,
    required this.endDate,
    required this.isActive,
    required this.pendentPurchaseHistory,
    required this.pendent,
  });

  factory PendentData.fromJson(Map<String, dynamic> json) => PendentData(
        id: json["id"],
        pendentId: json["pendent_id"],
        userId: json["user_id"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        isActive: json["is_active"],
        pendentPurchaseHistory: json["pendent_purchase_history"],
        pendent: json["pendent"]==null ? null : PendentPendent.fromJson(json["pendent"]),
      );
}

class PendentPendent {
  int? id;
  String? name;
  String? description;
  String? icon;
  int? price;
  int? star;
  int? validityDays;
  int? monthlyRoi;
  double? dailyRoi;
  int? affilate;
  int? giftSendBenefits;
  int? giftReceiveBenefits;
  int? isActive;

  PendentPendent({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.price,
    required this.star,
    required this.validityDays,
    required this.monthlyRoi,
    required this.dailyRoi,
    required this.affilate,
    required this.giftSendBenefits,
    required this.giftReceiveBenefits,
    required this.isActive,
  });

  factory PendentPendent.fromJson(Map<String, dynamic> json) => PendentPendent(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        icon: json["icon"],
        price: json["price"],
        star: json["star"],
        validityDays: json["validity_days"],
        monthlyRoi: json["monthly_roi"],
        dailyRoi: json["daily_roi"]?.toDouble(),
        affilate: json["affilate"],
        giftSendBenefits: json["gift_send_benefits"],
        giftReceiveBenefits: json["gift_receive_benefits"],
        isActive: json["is_active"],
      );
}

class Link {
  String? url;
  String? label;
  bool? active;

  Link({
    required this.url,
    required this.label,
    required this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );
}

class Photos {
  int? currentPage;
  List<PhotosData> data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link> links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  Photos({
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

  factory Photos.fromJson(Map<String, dynamic> json) => Photos(
        currentPage: json["current_page"],
        data: List<PhotosData>.from(json["data"].map((x) => PhotosData.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );
}

class PhotosData {
  int? id;
  int? userId;
  int? postId;
  String? fileType;
  int? imageAlbumId;
  String? imageType;
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
  FluffyCountReactions? countReactions;
  String? fullPath;
  List<dynamic> taggedFriends;
  List<String> reactingPersons;
  int? totalViewCount;
  dynamic myReaction;
  UserElement? user;

  PhotosData({
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
    required this.fullPath,
    required this.taggedFriends,
    required this.reactingPersons,
    required this.totalViewCount,
    required this.myReaction,
    required this.user,
  });

  factory PhotosData.fromJson(Map<String, dynamic> json) => PhotosData(
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
        countReactions: json["count_reactions"] == null ? null : FluffyCountReactions.fromJson(json["count_reactions"]),
        fullPath: json["full_path"],
        taggedFriends: List<dynamic>.from(json["tagged_friends"].map((x) => x)),
        reactingPersons: List<String>.from(json["reacting_persons"].map((x) => x)),
        totalViewCount: json["total_view_count"],
        myReaction: json["my_reaction"],
        user: json["user"]==null ? null : UserElement.fromJson(json["user"]),
      );
}

class FluffyCountReactions {
  int? all;
  int? love;

  FluffyCountReactions({
    required this.all,
    required this.love,
  });

  factory FluffyCountReactions.fromJson(Map<String, dynamic> json) => FluffyCountReactions(
        all: json["All"],
        love: json["love"],
      );
}

class Users {
  int? currentPage;
  List<UserElement> data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link> links;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  Users({
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

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        currentPage: json["current_page"],
        data: List<UserElement>.from(json["data"].map((x) => UserElement.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );
}
