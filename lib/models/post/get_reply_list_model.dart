import 'package:bip_hip/models/post/post_comment_model.dart';

class ReplyListModel {
  CommentReplies? commentReplies;

  ReplyListModel({
    required this.commentReplies,
  });

  factory ReplyListModel.fromJson(Map<String, dynamic> json) => ReplyListModel(
        commentReplies: json["commentReplies"] == null ? null : CommentReplies.fromJson(json["commentReplies"]),
      );
}

class CommentReplies {
  int? currentPage;
  List<CommentReply> data;
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

  CommentReplies({
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

  factory CommentReplies.fromJson(Map<String, dynamic> json) => CommentReplies(
        currentPage: json["current_page"],
        data: List<CommentReply>.from(json["data"].map((x) => CommentReply.fromJson(x))),
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


class User {
  int? id;
  String? image;
  String? userName;
  String? referralCode;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? gender;
  DateTime? dob;
  List<String> profession;
  List<String> interest;
  String? bio;
  List<String> languages;
  String? status;
  dynamic blockTill;
  String? otp;
  DateTime createdAt;
  // DateTime updatedAt;
  int? refId;
  String? relation;
  String? relationWithName;
  int? relationWithId;
  DateTime? relationSince;
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
  dynamic familyRelationStatus;
  int? mutualFriend;
  int? yearsOld;
  dynamic pendent;
  int? chatRoomId;

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
        // updatedAt: DateTime.parse(json["updated_at"]),
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
        pendent: json["pendent"],
        chatRoomId: json["chat_room_id"],
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
