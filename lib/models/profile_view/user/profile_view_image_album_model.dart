import 'package:bip_hip/models/common/common_link_model.dart';

class ProfileViewImageAlbumModel {
  ImageAlbums? imageAlbums;

  ProfileViewImageAlbumModel({
    this.imageAlbums,
  });

  factory ProfileViewImageAlbumModel.fromJson(Map<String, dynamic> json) => ProfileViewImageAlbumModel(
        imageAlbums: json["image_albums"] == null ? null : ImageAlbums.fromJson(json["image_albums"]),
      );
}

class ImageAlbums {
  int? currentPage;
  List<ImageAlbumData>? data;
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

  ImageAlbums({
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

  factory ImageAlbums.fromJson(Map<String, dynamic> json) => ImageAlbums(
        currentPage: json["current_page"],
        data: json["data"] == null ? [] : List<ImageAlbumData>.from(json["data"]!.map((x) => ImageAlbumData.fromJson(x))),
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

class ImageAlbumData {
  int? id;
  int? userId;
  dynamic pageId;
  int? postCategoryId;
  String? title;
  dynamic description;
  dynamic images;
  int? privacy;
  int? isDefault;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? totalImage;
  List<dynamic>? preview;
  List<ImageList>? imageList;

  ImageAlbumData({
    this.id,
    this.userId,
    this.pageId,
    this.postCategoryId,
    this.title,
    this.description,
    this.images,
    this.privacy,
    this.isDefault,
    this.createdAt,
    this.updatedAt,
    this.totalImage,
    this.preview,
    this.imageList,
  });

  factory ImageAlbumData.fromJson(Map<String, dynamic> json) => ImageAlbumData(
        id: json["id"],
        userId: json["user_id"],
        pageId: json["page_id"],
        postCategoryId: json["post_category_id"],
        title: json["title"],
        description: json["description"],
        images: json["images"],
        privacy: json["privacy"],
        isDefault: json["is_default"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        totalImage: json["total_image"],
        preview: json["preview"] == null ? [] : List<String>.from(json["preview"]!.map((x) => x)),
        imageList: json["image_list"] == null ? [] : List<ImageList>.from(json["image_list"]!.map((x) => ImageList.fromJson(x))),
      );
}

class ImageList {
  int? id;
  int? userId;
  int? postId;
  // Type? fileType;
  int? imageAlbumId;
  dynamic imageType;
  String? storageType;
  dynamic mimeType;
  String? title;
  String? storagePath;
  String? path;
  int? filesize;
  String? description;
  dynamic imageTakenTime;
  String? imageTakenLocation;
  int? countView;
  int? countShare;
  int? countComment;
  int? countStar;
  CountReactions? countReactions;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? fullPath;
  List<dynamic>? taggedFriends;
  List<String>? reactingPersons;
  int? totalViewCount;
  dynamic myReaction;

  ImageList({
    this.id,
    this.userId,
    this.postId,
    // this.fileType,
    this.imageAlbumId,
    this.imageType,
    this.storageType,
    this.mimeType,
    this.title,
    this.storagePath,
    this.path,
    this.filesize,
    this.description,
    this.imageTakenTime,
    this.imageTakenLocation,
    this.countView,
    this.countShare,
    this.countComment,
    this.countStar,
    this.countReactions,
    this.createdAt,
    this.updatedAt,
    this.fullPath,
    this.taggedFriends,
    this.reactingPersons,
    this.totalViewCount,
    this.myReaction,
  });

  factory ImageList.fromJson(Map<String, dynamic> json) => ImageList(
        id: json["id"],
        userId: json["user_id"],
        postId: json["post_id"],
        // fileType: json["file_type"],
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
        countReactions: json["count_reactions"] == null ? null : CountReactions.fromJson(json["count_reactions"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        fullPath: json["full_path"],
        taggedFriends: json["tagged_friends"] == null ? [] : List<dynamic>.from(json["tagged_friends"]!.map((x) => x)),
        reactingPersons: List<String>.from(json["reacting_persons"].map((x) => x)),
        totalViewCount: json["total_view_count"],
        myReaction: json["my_reaction"],
      );
}

class CountReactions {
  int? all;
  int? like;
  int? love;
  int? angry;

  CountReactions({
    this.all,
    this.like,
    this.love,
    this.angry,
  });

  factory CountReactions.fromJson(Map<String, dynamic> json) => CountReactions(
        all: json["All"],
        like: json["like"],
        love: json["love"],
        angry: json["angry"],
      );
}
