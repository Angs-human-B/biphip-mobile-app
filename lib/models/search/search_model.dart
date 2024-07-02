import 'package:bip_hip/models/common/Common_link_model.dart';
import 'package:bip_hip/models/common/common_user_model.dart';
import 'package:bip_hip/models/home/new_post_list_model.dart';

class SearchModel {
  Users? users;
  Posts? posts;
  Photos? photos;
  Photos? videos;
  Posts? sellposts;
  Posts? kidposts;
  Posts? newsposts;

  SearchModel({
    required this.users,
    required this.posts,
    required this.photos,
    required this.videos,
    required this.sellposts,
    required this.kidposts,
    required this.newsposts,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
        users: json["users"] == null ? null : Users.fromJson(json["users"]),
        posts: json["posts"] == null ? null : Posts.fromJson(json["posts"]),
        photos: json["photos"] == null ? null : Photos.fromJson(json["photos"]),
        videos: json["videos"] == null ? null : Photos.fromJson(json["videos"]),
        sellposts: json["sellposts"] == null ? null : Posts.fromJson(json["sellposts"]),
        kidposts: json["kidposts"] == null ? null : Posts.fromJson(json["kidposts"]),
        newsposts: json["newsposts"] == null ? null : Posts.fromJson(json["newsposts"]),
      );
}


class Photos {
  int? currentPage;
  List<PhotosData> data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<CommonLink> links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  Photos({
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

  factory Photos.fromJson(Map<String, dynamic> json) => Photos(
        currentPage: json["current_page"],
        data: List<PhotosData>.from(json["data"].map((x) => PhotosData.fromJson(x))),
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

class PhotosData {
  int? id;
  int? userId;
  int? postId;
  String? fileType;
  int? imageAlbumId;
  String? imageType;
  String? storageType;
  dynamic mimeType;
  String? title;
  String? storagePath;
  String? path;
  int? filesize;
  String? description;
  DateTime? imageTakenTime;
  String? imageTakenLocation;
  int? countView;
  int? countShare;
  int? countComment;
  int? countStar;
  FluffyCountReactions? countReactions;
  String? fullPath;
  List<dynamic> taggedFriends;
  List<String> reactingPersons;
  int? totalViewCount;
  dynamic myReaction;
  User? user;

  PhotosData({
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
    required this.myReaction,
    required this.user,
  });

  factory PhotosData.fromJson(Map<String, dynamic> json) => PhotosData(
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
        countReactions: json["count_reactions"] == null ? null : FluffyCountReactions.fromJson(json["count_reactions"]),
        fullPath: json["full_path"],
        taggedFriends: List<dynamic>.from(json["tagged_friends"].map((x) => x)),
        reactingPersons: List<String>.from(json["reacting_persons"].map((x) => x)),
        totalViewCount: json["total_view_count"],
        myReaction: json["my_reaction"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );
}

class FluffyCountReactions {
  int? all;
  int? love;

  FluffyCountReactions({
    required this.all,
    required this.love,
  });

  factory FluffyCountReactions.fromJson(Map<String, dynamic> json) => FluffyCountReactions(
        all: json["All"],
        love: json["love"],
      );
}

class Users {
  int? currentPage;
  List<User> data;
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

  Users({
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

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        currentPage: json["current_page"],
        data: List<User>.from(json["data"].map((x) => User.fromJson(x))),
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
