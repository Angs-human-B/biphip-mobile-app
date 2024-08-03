import 'package:bip_hip/models/common/common_link_model.dart';
import 'package:bip_hip/models/home/new_post_list_model.dart';

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
  List<ImageElement> imageList;

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
        imageList: List<ImageElement>.from(json["image_list"].map((x) => ImageElement.fromJson(x))),
      );
}