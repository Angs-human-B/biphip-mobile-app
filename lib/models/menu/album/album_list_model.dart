class AlbumListModel {
  ImageAlbums? imageAlbums;

  AlbumListModel({
    required this.imageAlbums,
  });

  factory AlbumListModel.fromJson(Map<String, dynamic> json) => AlbumListModel(
        imageAlbums: json["image_albums"] == null ? null : ImageAlbums.fromJson(json["image_albums"]),
      );
}

class ImageAlbums {
  int? currentPage;
  List<ImageData> data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link> links;
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
        data: List<ImageData>.from(json["data"].map((x) => ImageData.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );
}

class ImageData {
  int? id;
  int? userId;
  int? postCategoryId;
  String? title;
  String? description;
  String? images;
  int? totalImage;
  List<String> preview;
  List<ImageList> imageList;

  ImageData({
    required this.id,
    required this.userId,
    required this.postCategoryId,
    required this.title,
    required this.description,
    required this.images,
    required this.totalImage,
    required this.preview,
    required this.imageList,
  });

  factory ImageData.fromJson(Map<String, dynamic> json) => ImageData(
        id: json["id"],
        userId: json["user_id"],
        postCategoryId: json["post_category_id"],
        title: json["title"],
        description: json["description"],
        images: json["images"],
        totalImage: json["total_image"],
        preview: List<String>.from(json["preview"].map((x) => x)),
        imageList: List<ImageList>.from(json["image_list"].map((x) => ImageList.fromJson(x))),
      );
}

class ImageList {
  int? id;
  int? userId;
  dynamic postId;
  int? imageAlbumId;
  String? imageType;
  String? storageType;
  dynamic mimeType;
  String? title;
  String? storagePath;
  String? path;
  int? fileSize;
  String? fullPath;

  ImageList({
    required this.id,
    required this.userId,
    required this.postId,
    required this.imageAlbumId,
    required this.imageType,
    required this.storageType,
    required this.mimeType,
    required this.title,
    required this.storagePath,
    required this.path,
    required this.fileSize,
    required this.fullPath,
  });

  factory ImageList.fromJson(Map<String, dynamic> json) => ImageList(
        id: json["id"],
        userId: json["user_id"],
        postId: json["post_id"],
        imageAlbumId: json["image_album_id"],
        imageType: json["image_type"],
        storageType: json["storage_type"],
        mimeType: json["mime_type"],
        title: json["title"],
        storagePath: json["storage_path"],
        path: json["path"],
        fileSize: json["filesize"],
        fullPath: json["full_path"],
      );
}

class Link {
  String? url;
  String? label;
  bool? active;

  Link({
    required this.url,
    required this.label,
    required this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );
}
