import 'package:bip_hip/models/common/common_user_model.dart';
import 'package:bip_hip/models/profile_view/user/user_profile_view_basic_info_model.dart';

class ProfileViewKidOverviewModel {
    Kid? kid;
    School? school;
    List<Contact>? contacts;

    ProfileViewKidOverviewModel({
        this.kid,
        this.school,
        this.contacts,
    });

    factory ProfileViewKidOverviewModel.fromJson(Map<String, dynamic> json) => ProfileViewKidOverviewModel(
        kid: json["kid"] == null ? null : Kid.fromJson(json["kid"]),
        school: json["school"] == null ? null : School.fromJson(json["school"]),
        contacts: json["contacts"] == null ? [] : List<Contact>.from(json["contacts"]!.map((x) => Contact.fromJson(x))),
    );
}

class Kid {
    int? id;
    String? pageType;
    String? pageId;
    int? userId;
    String? name;
    dynamic bio;
    int? age;
    dynamic dob;
    int? relationId;
    List<String>? categories;
    String? image;
    String? cover;
    dynamic bin;
    dynamic country;
    int? rating;
    List<String>? hobbies;
    List<String>? languages;
    String? gender;
    List<PrivacyLink>? privacyLink;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic qr;
    dynamic legalFiles;
    dynamic introVideo;
    dynamic email;
    dynamic phone;
    dynamic address;
    dynamic profilePicture;
    dynamic coverPhoto;
    dynamic profileImageId;
    dynamic coverImageId;
    dynamic qrCode;
    dynamic legalPapers;
    dynamic introVideoFile;
    int? countFollowers;
    int? countPageRating;
    int? countPageReviews;
    String? relation;
    dynamic chatRoomId;
    User? user;
    dynamic proImage;
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
        this.user,
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
        languages: json["languages"] == null ? [] : List<String>.from(json["languages"]!.map((x) => x)),
        gender: json["gender"],
        privacyLink: json["privacy_link"] == null ? [] : List<PrivacyLink>.from(json["privacy_link"]!.map((x) => PrivacyLink.fromJson(x))),
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
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        proImage: json["pro_image"],
        coverImage: json["cover_image"],
    );
}

class PrivacyLink {
    String? facebook;
    String? twitter;

    PrivacyLink({
        this.facebook,
        this.twitter,
    });

    factory PrivacyLink.fromJson(Map<String, dynamic> json) => PrivacyLink(
        facebook: json["Facebook"],
        twitter: json["Twitter"],
    );
}
class School {
    int? id;
    int? pageId;
    String? school;
    dynamic description;
    DateTime? started;
    dynamic ended;
    int? graduated;
    int? isCurrent;
    DateTime? createdAt;
    DateTime? updatedAt;

    School({
        this.id,
        this.pageId,
        this.school,
        this.description,
        this.started,
        this.ended,
        this.graduated,
        this.isCurrent,
        this.createdAt,
        this.updatedAt,
    });

    factory School.fromJson(Map<String, dynamic> json) => School(
        id: json["id"],
        pageId: json["page_id"],
        school: json["school"],
        description: json["description"],
        started: json["started"] == null ? null : DateTime.parse(json["started"]),
        ended: json["ended"],
        graduated: json["graduated"],
        isCurrent: json["is_current"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

}
