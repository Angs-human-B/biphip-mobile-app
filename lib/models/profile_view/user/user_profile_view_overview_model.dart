import 'package:bip_hip/models/common/common_user_model.dart';

class UserProfileViewOverviewModel {
  User? user;
  Works? works;
  Colleges? colleges;
  Colleges? schools;
  CurrentCity? hometown;
  CurrentCity? currentCity;
  String? relation;

  UserProfileViewOverviewModel({
    this.user,
    this.works,
    this.colleges,
    this.schools,
    this.hometown,
    this.currentCity,
    this.relation,
  });

  factory UserProfileViewOverviewModel.fromJson(Map<String, dynamic> json) => UserProfileViewOverviewModel(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        works: json["works"] == null ? null : Works.fromJson(json["works"]),
        colleges: json["colleges"] == null ? null : Colleges.fromJson(json["colleges"]),
        schools: json["schools"] == null ? null : Colleges.fromJson(json["schools"]),
        hometown: json["hometown"] == null ? null : CurrentCity.fromJson(json["hometown"]),
        currentCity: json["current_city"] == null ? null : CurrentCity.fromJson(json["current_city"]),
        relation: json["relation"],
      );
}

class Colleges {
  int? id;
  int? userId;
  String? school;
  String? description;
  dynamic concentrations;
  dynamic degree;
  dynamic attendFor;
  DateTime? started;
  DateTime? ended;
  int? graduated;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? isCurrent;

  Colleges({
    this.id,
    this.userId,
    this.school,
    this.description,
    this.concentrations,
    this.degree,
    this.attendFor,
    this.started,
    this.ended,
    this.graduated,
    this.createdAt,
    this.updatedAt,
    this.isCurrent,
  });

  factory Colleges.fromJson(Map<String, dynamic> json) => Colleges(
        id: json["id"],
        userId: json["user_id"],
        school: json["school"],
        description: json["description"],
        concentrations: json["concentrations"],
        degree: json["degree"],
        attendFor: json["attend_for"],
        started: json["started"] == null ? null : DateTime.parse(json["started"]),
        ended: json["ended"] == null ? null : DateTime.parse(json["ended"]),
        graduated: json["graduated"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        isCurrent: json["is_current"],
      );
}

class CurrentCity {
  int? id;
  int? userId;
  String? city;
  dynamic moved;
  int? isHometown;
  int? isCurrent;
  DateTime? createdAt;
  DateTime? updatedAt;

  CurrentCity({
    this.id,
    this.userId,
    this.city,
    this.moved,
    this.isHometown,
    this.isCurrent,
    this.createdAt,
    this.updatedAt,
  });

  factory CurrentCity.fromJson(Map<String, dynamic> json) => CurrentCity(
        id: json["id"],
        userId: json["user_id"],
        city: json["city"],
        moved: json["moved"],
        isHometown: json["is_hometown"],
        isCurrent: json["is_current"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
      );
}

class Relation {
  int? id;
  String? image;
  String? userName;
  String? referralCode;
  String? firstName;
  String? lastName;
  String? email;
  DateTime? emailVerifiedAt;
  dynamic phone;
  dynamic phoneVerifiedAt;
  String? gender;
  DateTime? dob;
  List<String>? profession;
  List<String>? interest;
  String? bio;
  List<String>? languages;
  String? status;
  dynamic blockTill;
  String? otp;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? refId;
  String? relation;
  dynamic relationWithName;
  dynamic relationWithId;
  dynamic relationSince;
  String? cover;
  dynamic badge;
  int? starBalance;
  String? usdBalance;
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

  Relation({
    this.id,
    this.image,
    this.userName,
    this.referralCode,
    this.firstName,
    this.lastName,
    this.email,
    this.emailVerifiedAt,
    this.phone,
    this.phoneVerifiedAt,
    this.gender,
    this.dob,
    this.profession,
    this.interest,
    this.bio,
    this.languages,
    this.status,
    this.blockTill,
    this.otp,
    this.createdAt,
    this.updatedAt,
    this.refId,
    this.relation,
    this.relationWithName,
    this.relationWithId,
    this.relationSince,
    this.cover,
    this.badge,
    this.starBalance,
    this.usdBalance,
    this.socialProvider,
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

  factory Relation.fromJson(Map<String, dynamic> json) => Relation(
        id: json["id"],
        image: json["image"],
        userName: json["user_name"],
        referralCode: json["referral_code"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"] == null ? null : DateTime.parse(json["email_verified_at"]),
        phone: json["phone"],
        phoneVerifiedAt: json["phone_verified_at"],
        gender: json["gender"],
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
        profession: json["profession"] == null ? [] : List<String>.from(json["profession"]!.map((x) => x)),
        interest: json["interest"] == null ? [] : List<String>.from(json["interest"]!.map((x) => x)),
        bio: json["bio"],
        languages: json["languages"] == null ? [] : List<String>.from(json["languages"]!.map((x) => x)),
        status: json["status"],
        blockTill: json["block_till"],
        otp: json["otp"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        refId: json["ref_id"],
        relation: json["relation"],
        relationWithName: json["relation_with_name"],
        relationWithId: json["relation_with_id"],
        relationSince: json["relation_since"],
        cover: json["cover"],
        badge: json["badge"],
        starBalance: json["star_balance"],
        usdBalance: json["usd_balance"],
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

class Works {
  int? id;
  int? userId;
  String? company;
  String? position;
  dynamic city;
  dynamic description;
  DateTime? started;
  DateTime? ended;
  int? isCurrent;
  DateTime? createdAt;
  DateTime? updatedAt;

  Works({
    this.id,
    this.userId,
    this.company,
    this.position,
    this.city,
    this.description,
    this.started,
    this.ended,
    this.isCurrent,
    this.createdAt,
    this.updatedAt,
  });

  factory Works.fromJson(Map<String, dynamic> json) => Works(
        id: json["id"],
        userId: json["user_id"],
        company: json["company"],
        position: json["position"],
        city: json["city"],
        description: json["description"],
        started: json["started"] == null ? null : DateTime.parse(json["started"]),
        ended: json["ended"] == null ? null : DateTime.parse(json["ended"]),
        isCurrent: json["is_current"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
      );
}
