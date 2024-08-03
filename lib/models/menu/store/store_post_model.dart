import 'package:bip_hip/models/common/common_link_model.dart';
import 'package:bip_hip/models/home/new_post_list_model.dart';

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
  List<PostDataRx> data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<CommonLink> links;
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
        data: List<PostDataRx>.from(json["data"].map((x) => PostDataRx.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: List<CommonLink>.from(json["links"].map((x) => CommonLink.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );
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
  ImageElement proImage;
  ImageElement coverImage;

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
        proImage: ImageElement.fromJson(json["pro_image"]),
        coverImage: ImageElement.fromJson(json["cover_image"]),
      );
}

