class DashboardStarInsightGiftModel {
    Posts? posts;

    DashboardStarInsightGiftModel({
        this.posts,
    });

    factory DashboardStarInsightGiftModel.fromJson(Map<String, dynamic> json) => DashboardStarInsightGiftModel(
        posts: json["posts"] == null ? null : Posts.fromJson(json["posts"]),
    );
}

class Posts {
    int? currentPage;
    List<PostsData>? data;
    String? firstPageUrl;
    int? from;
    int? lastPage;
    String? lastPageUrl;
    List<Link>? links;
    dynamic nextPageUrl;
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
        data: json["data"] == null ? [] : List<PostsData>.from(json["data"]!.map((x) => PostsData.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: json["links"] == null ? [] : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
    );
}

class PostsData {
    int? id;
    int? postId;
    dynamic commentId;
    int? userId;
    int? star;
    DateTime? createdAt;
    DateTime? updatedAt;
    Badge? badge;

    PostsData({
        this.id,
        this.postId,
        this.commentId,
        this.userId,
        this.star,
        this.createdAt,
        this.updatedAt,
        this.badge,
    });

    factory PostsData.fromJson(Map<String, dynamic> json) => PostsData(
        id: json["id"],
        postId: json["post_id"],
        commentId: json["comment_id"],
        userId: json["user_id"],
        star: json["star"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        badge: json["badge"] == null ? null : Badge.fromJson(json["badge"]),
    );
}

class Badge {
    int? id;
    String? name;
    String? description;
    String? icon;
    double? price;
    int? star;
    int? isActive;
    dynamic createdAt;
    dynamic updatedAt;

    Badge({
        this.id,
        this.name,
        this.description,
        this.icon,
        this.price,
        this.star,
        this.isActive,
        this.createdAt,
        this.updatedAt,
    });

    factory Badge.fromJson(Map<String, dynamic> json) => Badge(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        icon: json["icon"],
        price: json["price"]?.toDouble(),
        star: json["star"],
        isActive: json["is_active"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );
}

class Link {
    String? url;
    String? label;
    bool? active;

    Link({
        this.url,
        this.label,
        this.active,
    });

    factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
    );
}
