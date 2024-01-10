import 'package:bip_hip/models/common/common_user_model.dart';

class CommonUserDataModel {
  User? user;

  CommonUserDataModel({
    required this.user,
  });

  factory CommonUserDataModel.fromJson(Map<String, dynamic> json) => CommonUserDataModel(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );
}

class ProfessionListModel {
  List<String> professions;

  ProfessionListModel({
    required this.professions,
  });

  factory ProfessionListModel.fromJson(Map<String, dynamic> json) => ProfessionListModel(
        professions: List<String>.from(json["professions"].map((x) => x)),
      );
}

class InterestListModel {
  List<String> interests;

  InterestListModel({
    required this.interests,
  });

  factory InterestListModel.fromJson(Map<String, dynamic> json) => InterestListModel(
        interests: List<String>.from(json["interests"].map((x) => x)),
      );
}

class RelationshipListModel {
  List<String> relationships;

  RelationshipListModel({
    required this.relationships,
  });

  factory RelationshipListModel.fromJson(Map<String, dynamic> json) => RelationshipListModel(
        relationships: List<String>.from(json["relationships"].map((x) => x)),
      );
}

class GenderListModel {
  List<String> genders;

  GenderListModel({
    required this.genders,
  });

  factory GenderListModel.fromJson(Map<String, dynamic> json) => GenderListModel(
        genders: List<String>.from(json["genders"].map((x) => x)),
      );
}

class PositionListModel {
  List<String> positions;

  PositionListModel({
    required this.positions,
  });

  factory PositionListModel.fromJson(Map<String, dynamic> json) => PositionListModel(
        positions: List<String>.from(json["positions"].map((x) => x)),
      );
}

class LinkListModel {
  List<String> linkTypes;

  LinkListModel({
    required this.linkTypes,
  });

  factory LinkListModel.fromJson(Map<String, dynamic> json) => LinkListModel(
        linkTypes: List<String>.from(json["linkTypes"].map((x) => x)),
      );
}

class CityListModel {
  List<String> cities;

  CityListModel({
    required this.cities,
  });

  factory CityListModel.fromJson(Map<String, dynamic> json) => CityListModel(
        cities: List<String>.from(json["cities"].map((x) => x)),
      );
}

class CompanyListModel {
  List<String> companies;

  CompanyListModel({
    required this.companies,
  });

  factory CompanyListModel.fromJson(Map<String, dynamic> json) => CompanyListModel(
        companies: List<String>.from(json["companies"].map((x) => x)),
      );
}

class SchoolListModel {
  List<String> schools;

  SchoolListModel({
    required this.schools,
  });

  factory SchoolListModel.fromJson(Map<String, dynamic> json) => SchoolListModel(
        schools: List<String>.from(json["schools"].map((x) => x)),
      );
}

class PostCategoryListModel {
  List<PostCategory> postCategories;

  PostCategoryListModel({
    required this.postCategories,
  });

  factory PostCategoryListModel.fromJson(Map<String, dynamic> json) => PostCategoryListModel(
        postCategories: List<PostCategory>.from(json["postCategories"].map((x) => PostCategory.fromJson(x))),
      );
}

class PostCategory {
  int? id;
  String? name;
  int? isActive;

  PostCategory({
    required this.id,
    required this.name,
    required this.isActive,
  });

  factory PostCategory.fromJson(Map<String, dynamic> json) => PostCategory(
        id: json["id"],
        name: json["name"],
        isActive: json["is_active"],
      );
}

class KidListModel {
  List<Kid> kids;

  KidListModel({
    required this.kids,
  });

  factory KidListModel.fromJson(Map<String, dynamic> json) => KidListModel(
        kids: List<Kid>.from(json["kids"].map((x) => Kid.fromJson(x))),
      );
}

class Kid {
  int? id;
  int? userId;
  String? name;
  String? image;
  int? age;
  String kidImage;

  Kid({
    required this.id,
    required this.userId,
    required this.name,
    required this.image,
    required this.age,
    required this.kidImage,
  });

  factory Kid.fromJson(Map<String, dynamic> json) => Kid(
        id: json["id"],
        userId: json["user_id"],
        name: json["name"],
        image: json["image"],
        age: json["age"],
        kidImage: json["kid_image"],
      );
}

class StoreModel {
    List<Store> stores;

    StoreModel({
        required this.stores,
    });

    factory StoreModel.fromJson(Map<String, dynamic> json) => StoreModel(
        stores: List<Store>.from(json["stores"].map((x) => Store.fromJson(x))),
    );
}

class Store {
    int? id;
    String? pageType;
    String? pageId;
    int? userId;
    String? name;
    dynamic bio;
    dynamic age;
    List<dynamic> categories;
    String? image;
    dynamic cover;
    dynamic bin;
    dynamic country;
    int? rating;
    List<dynamic> hobbies;
    List<dynamic> languages;
    dynamic gender;
    dynamic privacyLink;
    String? profilePicture;
    dynamic coverPhoto;
    ProPic? proPic;
    dynamic coverPic;

    Store({
        required this.id,
        required this.pageType,
        required this.pageId,
        required this.userId,
        required this.name,
        required this.bio,
        required this.age,
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
        required this.profilePicture,
        required this.coverPhoto,
        required this.proPic,
        required this.coverPic,
    });

    factory Store.fromJson(Map<String, dynamic> json) => Store(
        id: json["id"],
        pageType: json["page_type"],
        pageId: json["page_id"],
        userId: json["user_id"],
        name: json["name"],
        bio: json["bio"],
        age: json["age"],
        categories: List<dynamic>.from(json["categories"].map((x) => x)),
        image: json["image"],
        cover: json["cover"],
        bin: json["bin"],
        country: json["country"],
        rating: json["rating"],
        hobbies: List<dynamic>.from(json["hobbies"].map((x) => x)),
        languages: List<dynamic>.from(json["languages"].map((x) => x)),
        gender: json["gender"],
        privacyLink: json["privacy_link"],
        profilePicture: json["profile_picture"],
        coverPhoto: json["cover_photo"],
        proPic: json["pro_pic"] == null?null:ProPic.fromJson(json["pro_pic"]),
        coverPic: json["cover_pic"],
    );
}

class ProPic {
    int? id;
    int? userId;
    dynamic postId;
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
    String? fullPath;
    List<dynamic> taggedFriends;
    List<String> reactingPersons;
    int? totalViewCount;

    ProPic({
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
    });

    factory ProPic.fromJson(Map<String, dynamic> json) => ProPic(
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
        fullPath: json["full_path"],
        taggedFriends: List<dynamic>.from(json["tagged_friends"].map((x) => x)),
        reactingPersons: List<String>.from(json["reacting_persons"].map((x) => x)),
        totalViewCount: json["total_view_count"],
    );
}