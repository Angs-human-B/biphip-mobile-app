import 'package:bip_hip/models/common/common_link_model.dart';

class ProfileViewVideoModel {
  Videos? videos;

  ProfileViewVideoModel({
    this.videos,
  });

  factory ProfileViewVideoModel.fromJson(Map<String, dynamic> json) => ProfileViewVideoModel(
        videos: json["videos"] == null ? null : Videos.fromJson(json["videos"]),
      );
}

class Videos {
  int? currentPage;
  List<VideoData>? data;
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

  Videos({
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

  factory Videos.fromJson(Map<String, dynamic> json) => Videos(
        currentPage: json["current_page"],
        data: json["data"] == null ? [] : List<VideoData>.from(json["data"]!.map((x) => VideoData.fromJson(x))),
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

class VideoData {
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
  DateTime? createdAt;
  DateTime? updatedAt;
  String? fullPath;
  List<dynamic>? taggedFriends;
  List<String>? reactingPersons;
  int? totalViewCount;
  dynamic myReaction;
  dynamic post;

  VideoData({
    this.id,
    this.userId,
    this.postId,
    this.fileType,
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
    this.post,
  });

  factory VideoData.fromJson(Map<String, dynamic> json) => VideoData(
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
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        fullPath: json["full_path"],
        taggedFriends: json["tagged_friends"] == null ? [] : List<dynamic>.from(json["tagged_friends"]!.map((x) => x)),
        reactingPersons: List<String>.from(json["reacting_persons"].map((x) => x)),
        totalViewCount: json["total_view_count"],
        myReaction: json["my_reaction"],
        post: json["post"],
      );
}
