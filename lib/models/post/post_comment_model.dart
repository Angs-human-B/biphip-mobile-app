class PostCommentModel {
  int? currentPage;
  List<CommentData> data;
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

  PostCommentModel({
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

  factory PostCommentModel.fromJson(Map<String, dynamic> json) => PostCommentModel(
        currentPage: json["current_page"],
        // data: List<CommentData>.from(json["data"].map((x) => CommentData.fromJson(x))),
        data: json["data"] != null ? List<CommentData>.from(json["data"].map((x) => CommentData.fromJson(x))) : [],
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        // links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        links: json["links"] != null ? List<Link>.from(json["links"].map((x) => Link.fromJson(x))) : [],
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );
}

class CommentData {
  int? id;
  int? userId;
  CommentReplyCountReactions? countReactions;
  String? comment;
  dynamic mentionUserIds;
  int? isEdit;
  String? image;
  // DateTime createdAt;
  // DateTime updatedAt;
  int? refType;
  int? refId;
  dynamic deletedAt;
  List<String> mentionUsers;
  RefRelation? refRelation;
  dynamic myReaction;
  int? countReply;
  // bool? hasReport;
  // bool? myReport;
  // int? countStar;
  List<CommentReply> commentReplies;
  User? user;
  dynamic postStar;

  CommentData({
    required this.id,
    required this.userId,
    required this.countReactions,
    required this.comment,
    required this.mentionUserIds,
    required this.isEdit,
    required this.image,
    // required this.createdAt,
    // required this.updatedAt,
    required this.refType,
    required this.refId,
    required this.deletedAt,
    required this.mentionUsers,
    required this.refRelation,
    required this.myReaction,
    required this.countReply,
    // required this.hasReport,
    // required this.myReport,
    // required this.countStar,
    required this.commentReplies,
    required this.user,
    required this.postStar,
  });

  factory CommentData.fromJson(Map<String, dynamic> json) => CommentData(
        id: json["id"],
        userId: json["user_id"],
        countReactions: json["count_reactions"] == null ? null : CommentReplyCountReactions.fromJson(json["count_reactions"]),
        comment: json["comment"],
        mentionUserIds: json["mention_user_ids"],
        isEdit: json["is_edit"],
        image: json["image"],
        // createdAt: DateTime.parse(json["created_at"]),
        // updatedAt: DateTime.parse(json["updated_at"]),
        refType: json["ref_type"],
        refId: json["ref_id"],
        deletedAt: json["deleted_at"],
        mentionUsers: List<String>.from(json["mention_users"].map((x) => x)),
        refRelation: json["ref_relation"] == null ? null : RefRelation.fromJson(json["ref_relation"]),
        myReaction: json["my_reaction"],
        countReply: json["count_reply"],
        // hasReport: json["has_report"],
        // myReport: json["my_report"],
        // countStar: json["count_star"],
        commentReplies: List<CommentReply>.from(json["comment_replies"].map((x) => CommentReply.fromJson(x))),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        postStar: json["post_star"],
      );
}

class CommentReply {
  int? id;
  int? commentId;
  int? userId;
  CommentReplyCountReactions? countReactions;
  String? reply;
  dynamic mentionUserIds;
  int? isEdit;
  String? image;
  // DateTime createdAt;
  // DateTime updatedAt;
  dynamic deletedAt;
  List<dynamic> mentionUsers;
  dynamic myReaction;
  User? user;

  CommentReply({
    required this.id,
    required this.commentId,
    required this.userId,
    required this.countReactions,
    required this.reply,
    required this.mentionUserIds,
    required this.isEdit,
    required this.image,
    // required this.createdAt,
    // required this.updatedAt,
    required this.deletedAt,
    required this.mentionUsers,
    required this.myReaction,
    required this.user,
  });

  factory CommentReply.fromJson(Map<String, dynamic> json) => CommentReply(
        id: json["id"],
        commentId: json["comment_id"],
        userId: json["user_id"],
        countReactions: json["count_reactions"] == null ? null : CommentReplyCountReactions.fromJson(json["count_reactions"]),
        reply: json["reply"],
        mentionUserIds: json["mention_user_ids"],
        isEdit: json["is_edit"],
        image: json["image"],
        // createdAt: DateTime.parse(json["created_at"]),
        // updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        mentionUsers: List<dynamic>.from(json["mention_users"].map((x) => x)),
        myReaction: json["my_reaction"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );
}

class CommentReplyCountReactions {
  int? all;
  int? wow;
  int? love;
  int? like;
  int? sad;

  CommentReplyCountReactions({
    required this.all,
    this.wow,
    this.love,
    this.like,
    this.sad,
  });

  factory CommentReplyCountReactions.fromJson(Map<String, dynamic> json) => CommentReplyCountReactions(
        all: json["All"],
        wow: json["wow"],
        love: json["love"],
        like: json["like"],
        sad: json["sad"],
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
  int? refId;
  String? relation;
  dynamic relationWithName;
  dynamic relationWithId;
  dynamic relationSince;
  // String? cover;
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
  dynamic familyRelationStatus;
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
    required this.refId,
    required this.relation,
    required this.relationWithName,
    required this.relationWithId,
    required this.relationSince,
    // required this.cover,
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
        refId: json["ref_id"],
        relation: json["relation"],
        relationWithName: json["relation_with_name"],
        relationWithId: json["relation_with_id"],
        relationSince: json["relation_since"],
        // cover: json["cover"],
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

class RefRelation {
  Post? post;

  RefRelation({
    required this.post,
  });

  factory RefRelation.fromJson(Map<String, dynamic> json) => RefRelation(
        post: json["post"] == null ? null : Post.fromJson(json["post"]),
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
  int? isHideFnf;
  String? platform;
  dynamic action;
  int? isBidding;
  dynamic biddingPostType;
  dynamic desireAmount;
  dynamic minBiddingAmount;
  dynamic biddingDuration;
  dynamic title;
  // DateTime dateTime;
  // DateTime createdAt;
  // DateTime updatedAt;
  int? postCategoryId;
  int? isPublic;
  int? countView;
  int? countShare;
  int? countComment;
  int? countStar;
  PostCountReactions? countReactions;
  dynamic postSubCategoryId;
  dynamic timelineId;
  dynamic type;
  dynamic kidId;
  dynamic storeId;
  dynamic reviewRating;
  dynamic imageAlbumId;
  List<TaggedFriend> taggedFriends;
  int? countBids;
  dynamic myReaction;
  List<ReactionUser> reactionUsers;
  List<dynamic> viewers;
  // bool? hasReport;
  // bool? myReport;
  // bool? isNotifaction;
  // bool? isVisibleToMe;
  int? countReaction;

  Post({
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
    // required this.dateTime,
    // required this.createdAt,
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
    // required this.hasReport,
    // required this.myReport,
    // required this.isNotifaction,
    // required this.isVisibleToMe,
    required this.countReaction,
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
        // dateTime: DateTime.parse(json["date_time"]),
        // createdAt: DateTime.parse(json["created_at"]),
        // updatedAt: DateTime.parse(json["updated_at"]),
        postCategoryId: json["post_category_id"],
        isPublic: json["is_public"],
        countView: json["count_view"],
        countShare: json["count_share"],
        countComment: json["count_comment"],
        countStar: json["count_star"],
        countReactions: json["count_reactions"] == null ? null : PostCountReactions.fromJson(json["count_reactions"]),
        postSubCategoryId: json["post_sub_category_id"],
        timelineId: json["timeline_id"],
        type: json["type"],
        kidId: json["kid_id"],
        storeId: json["store_id"],
        reviewRating: json["review_rating"],
        imageAlbumId: json["image_album_id"],
        taggedFriends: List<TaggedFriend>.from(json["tagged_friends"].map((x) => TaggedFriend.fromJson(x))),
        countBids: json["count_bids"],
        myReaction: json["my_reaction"],
        reactionUsers: List<ReactionUser>.from(json["reaction_users"].map((x) => ReactionUser.fromJson(x))),
        viewers: List<dynamic>.from(json["viewers"].map((x) => x)),
        // hasReport: json["has_report"],
        // myReport: json["my_report"],
        // isNotifaction: json["is_notifaction"],
        // isVisibleToMe: json["is_visible_to_me"],
        countReaction: json["count_reaction"],
      );
}

class PostCountReactions {
  int? all;
  int? like;

  PostCountReactions({
    required this.all,
    required this.like,
  });

  factory PostCountReactions.fromJson(Map<String, dynamic> json) => PostCountReactions(
        all: json["All"],
        like: json["like"],
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

class TaggedFriend {
  int? id;
  String? firstName;
  String? lastName;
  String? image;
  String referralUrl;
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
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.image,
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

class Link {
  String? url;
  String? label;
  // bool? active;

  Link({
    required this.url,
    required this.label,
    // required this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        // active: json["active"],
      );
}
