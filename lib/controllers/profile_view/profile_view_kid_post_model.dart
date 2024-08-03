import 'package:bip_hip/models/common/common_link_model.dart';
import 'package:bip_hip/models/home/new_post_list_model.dart';

class ProfileViewKidPostModel {
  Posts? posts;

  ProfileViewKidPostModel({
    this.posts,
  });

  factory ProfileViewKidPostModel.fromJson(Map<String, dynamic> json) => ProfileViewKidPostModel(
        posts: json["posts"] == null ? null : Posts.fromJson(json["posts"]),
      );
}

class Posts {
  int? currentPage;
  List<PostDataRx>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<CommonLink>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  Posts({
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

  factory Posts.fromJson(Map<String, dynamic> json) => Posts(
        currentPage: json["current_page"],
        data: json["data"] == null ? [] : List<PostDataRx>.from(json["data"]!.map((x) => PostDataRx.fromJson(x))),
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
