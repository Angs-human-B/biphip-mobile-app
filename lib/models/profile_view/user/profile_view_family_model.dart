import 'package:bip_hip/models/common/common_link_model.dart';

class ProfileViewFamilyModel {
    Families? families;

    ProfileViewFamilyModel({
        this.families,
    });

    factory ProfileViewFamilyModel.fromJson(Map<String, dynamic> json) => ProfileViewFamilyModel(
        families: json["families"] == null ? null : Families.fromJson(json["families"]),
    );
}

class Families {
    int? currentPage;
    List<FamilyData>? data;
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

    Families({
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

    factory Families.fromJson(Map<String, dynamic> json) => Families(
        currentPage: json["current_page"],
        data: json["data"] == null ? [] : List<FamilyData>.from(json["data"]!.map((x) => FamilyData.fromJson(x))),
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

class FamilyData {
    int? id;
    int? userId;
    int? familyId;
    int? friendId;
    int? relationId;
    int? status;
    String? tags;
    DateTime? acceptedAt;
    DateTime? createdAt;
    DateTime? updatedAt;
    String? relationName;
    Family? family;

    FamilyData({
        this.id,
        this.userId,
        this.familyId,
        this.friendId,
        this.relationId,
        this.status,
        this.tags,
        this.acceptedAt,
        this.createdAt,
        this.updatedAt,
        this.relationName,
        this.family,
    });

    factory FamilyData.fromJson(Map<String, dynamic> json) => FamilyData(
        id: json["id"],
        userId: json["user_id"],
        familyId: json["family_id"],
        friendId: json["friend_id"],
        relationId: json["relation_id"],
        status: json["status"],
        tags: json["tags"],
        acceptedAt: json["accepted_at"] == null ? null : DateTime.parse(json["accepted_at"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        relationName: json["relation_name"],
        family: json["family"] == null ? null : Family.fromJson(json["family"]),
    );
}

class Family {
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
    dynamic chatRoomId;

    Family({
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

    factory Family.fromJson(Map<String, dynamic> json) => Family(
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