class ImageDetailsModel {
  Image? image;

  ImageDetailsModel({
    required this.image,
  });

  factory ImageDetailsModel.fromJson(Map<String, dynamic> json) => ImageDetailsModel(
        image: Image.fromJson(json["image"]),
      );
}

class Image {
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
  List<dynamic> comments;

  Image({
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
    required this.comments,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
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
        comments: List<dynamic>.from(json["comments"].map((x) => x)),
      );
}
