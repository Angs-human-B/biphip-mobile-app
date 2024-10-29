import 'package:bip_hip/models/common/common_link_model.dart';
import 'package:bip_hip/models/common/common_user_model.dart';
import 'package:bip_hip/models/home/new_post_list_model.dart';

class ProfileViewStoreReviewModel {
    Reviews? reviews;

    ProfileViewStoreReviewModel({
        this.reviews,
    });

    factory ProfileViewStoreReviewModel.fromJson(Map<String, dynamic> json) => ProfileViewStoreReviewModel(
        reviews: json["reviews"] == null ? null : Reviews.fromJson(json["reviews"]),
    );
}

class Reviews {
    int? currentPage;
    List<ReviewData>? data;
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

    Reviews({
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

    factory Reviews.fromJson(Map<String, dynamic> json) => Reviews(
        currentPage: json["current_page"],
        data: json["data"] == null ? [] : List<ReviewData>.from(json["data"]!.map((x) => ReviewData.fromJson(x))),
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

class ReviewData {
    int? id;
    int? pageId;
    int? userId;
    String? content;
    String? rating;
    int? postId;
    DateTime? createdAt;
    DateTime? updatedAt;
    User? user;
    PostDataRx? post;

    ReviewData({
        this.id,
        this.pageId,
        this.userId,
        this.content,
        this.rating,
        this.postId,
        this.createdAt,
        this.updatedAt,
        this.user,
        this.post,
    });

    factory ReviewData.fromJson(Map<String, dynamic> json) => ReviewData(
        id: json["id"],
        pageId: json["page_id"],
        userId: json["user_id"],
        content: json["content"],
        rating: json["rating"],
        postId: json["post_id"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        post: json["post"] == null ? null : PostDataRx.fromJson(json["post"]),
    );
}