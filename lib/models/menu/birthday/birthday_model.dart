class BirthdayModel {
  List<Today> today;
  List<Today> inTwoDays;
  List<Today> upcomings;

  BirthdayModel({
    required this.today,
    required this.inTwoDays,
    required this.upcomings,
  });

  factory BirthdayModel.fromJson(Map<String, dynamic> json) => BirthdayModel(
        today: List<Today>.from(json["today"].map((x) => Today.fromJson(x))),
        inTwoDays: List<Today>.from(json["inTwoDays"].map((x) => x)),
        upcomings: List<Today>.from(json["upcomings"].map((x) => Today.fromJson(x))),
      );
}

class Today {
  int? id;
  String? image;
  String? userName;
  String? referralCode;
  String? firstName;
  String? lastName;
  String? email;
  dynamic phone;
  String? gender;
  DateTime dob;
  List<String> profession;
  List<String> interest;
  String? bio;
  List<String> languages;
  String? status;
  dynamic blockTill;
  String? otp;
  int? refId;
  String? relation;
  String? relationWithName;
  int? relationWithId;
  DateTime? relationSince;
  String? cover;
  dynamic badge;
  int ?starBalance;
  dynamic socialProvider;
  MyWish? myWish;
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
  TodayPendent? pendent;

  Today({
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
    required this.refId,
    required this.relation,
    required this.relationWithName,
    required this.relationWithId,
    required this.relationSince,
    required this.cover,
    required this.badge,
    required this.starBalance,
    required this.socialProvider,
    required this.myWish,
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
  });

  factory Today.fromJson(Map<String, dynamic> json) => Today(
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
        refId: json["ref_id"],
        relation: json["relation"],
        relationWithName: json["relation_with_name"],
        relationWithId: json["relation_with_id"],
        relationSince: json["relation_since"] == null ? null : DateTime.parse(json["relation_since"]),
        cover: json["cover"],
        badge: json["badge"],
        starBalance: json["star_balance"],
        socialProvider: json["social_provider"],
        myWish: json["my_wish"] == null ? null : MyWish.fromJson(json["my_wish"]),
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
        pendent: json["pendent"] == null ? null : TodayPendent.fromJson(json["pendent"]),
      );
}

class MyWish {
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
  List<dynamic> taggedFriends;
  int? countBids;
  dynamic myReaction;
  List<dynamic> reactionUsers;
  List<dynamic> viewers;
  bool? hasReport;
  bool? myReport;
  bool? isNotifaction;
  List<dynamic> images;

  MyWish({
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
    required this.images,
  });

  factory MyWish.fromJson(Map<String, dynamic> json) => MyWish(
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
        images: List<dynamic>.from(json["images"].map((x) => x)),
      );
}

class TodayPendent {
  int? id;
  int? pendentId;
  int? userId;
  DateTime? startDate;
  DateTime? endDate;
  int? isActive;
  String? pendentPurchaseHistory;
  PendentPendent pendent;

  TodayPendent({
    required this.id,
    required this.pendentId,
    required this.userId,
    required this.startDate,
    required this.endDate,
    required this.isActive,
    required this.pendentPurchaseHistory,
    required this.pendent,
  });

  factory TodayPendent.fromJson(Map<String, dynamic> json) => TodayPendent(
        id: json["id"],
        pendentId: json["pendent_id"],
        userId: json["user_id"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        isActive: json["is_active"],
        pendentPurchaseHistory: json["pendent_purchase_history"],
        pendent: PendentPendent.fromJson(json["pendent"]),
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
