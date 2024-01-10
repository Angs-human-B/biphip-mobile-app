import 'package:bip_hip/models/common/common_link_model.dart';

class AlbumListModel {
  ImageAlbums imageAlbums;

  AlbumListModel({
    required this.imageAlbums,
  });

  factory AlbumListModel.fromJson(Map<String, dynamic> json) => AlbumListModel(
        imageAlbums: ImageAlbums.fromJson(json["image_albums"]),
      );
}

class ImageAlbums {
  int? currentPage;
  List<AlbumData> data;
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

  ImageAlbums({
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

  factory ImageAlbums.fromJson(Map<String, dynamic> json) => ImageAlbums(
        currentPage: json["current_page"],
        data: List<AlbumData>.from(json["data"].map((x) => AlbumData.fromJson(x))),
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

class AlbumData {
  int? id;
  int? userId;
  dynamic postCategoryId;
  String? title;
  dynamic description;
  dynamic images;
  int? privacy;
  int? isDefault;
  String? type;
  int? totalImage;
  List<String> preview;
  List<ImageList> imageList;

  AlbumData({
    required this.id,
    required this.userId,
    required this.postCategoryId,
    required this.title,
    required this.description,
    required this.images,
    required this.privacy,
    required this.isDefault,
    required this.type,
    required this.totalImage,
    required this.preview,
    required this.imageList,
  });

  factory AlbumData.fromJson(Map<String, dynamic> json) => AlbumData(
        id: json["id"],
        userId: json["user_id"],
        postCategoryId: json["post_category_id"],
        title: json["title"],
        description: json["description"],
        images: json["images"],
        privacy: json["privacy"],
        isDefault: json["is_default"],
        type: json["type"],
        totalImage: json["total_image"],
        preview: List<String>.from(json["preview"].map((x) => x)),
        imageList: List<ImageList>.from(json["image_list"].map((x) => ImageList.fromJson(x))),
      );
}

class ImageList {
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
  // int? totalReactions;
  List<String> reactingPersons;
  // MostlyReactedReactions mostlyReactedReactions;
  int? totalViewCount;

  ImageList({
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
    // required this.totalReactions,
    required this.reactingPersons,
    // required this.mostlyReactedReactions,
    required this.totalViewCount,
  });

  factory ImageList.fromJson(Map<String, dynamic> json) => ImageList(
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
        countReactions: json["count_reactions"],
        fullPath: json["full_path"],
        taggedFriends: List<dynamic>.from(json["tagged_friends"].map((x) => x)),
        // totalReactions: json["total_reactions"],
        reactingPersons: List<String>.from(json["reacting_persons"].map((x) => x)),
        // mostlyReactedReactions: MostlyReactedReactions.fromJson(json["mostly_reacted_reactions"]),
        totalViewCount: json["total_view_count"],
      );
}

class MostlyReactedReactions {
  int? love;
  int? like;

  MostlyReactedReactions({
    required this.love,
    required this.like,
  });

  factory MostlyReactedReactions.fromJson(Map<String, dynamic> json) => MostlyReactedReactions(
        love: json["love"],
        like: json["like"],
      );
}
