
import 'package:bip_hip/models/common/common_link_model.dart';

class DashboardStarInsightPurchaseModel {
    Purchases? purchases;

    DashboardStarInsightPurchaseModel({
        this.purchases,
    });

    factory DashboardStarInsightPurchaseModel.fromJson(Map<String, dynamic> json) => DashboardStarInsightPurchaseModel(
        purchases: json["purchases"] == null ? null : Purchases.fromJson(json["purchases"]),
    );
}

class Purchases {
    int? currentPage;
    List<PurchaseData>? data;
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

    Purchases({
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

    factory Purchases.fromJson(Map<String, dynamic> json) => Purchases(
        currentPage: json["current_page"],
        data: json["data"] == null ? [] : List<PurchaseData>.from(json["data"]!.map((x) => PurchaseData.fromJson(x))),
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

class PurchaseData {
    int? id;
    int? userId;
    int? badgeId;
    double? price;
    int? star;
    DateTime? dateTime;
    DateTime? createdAt;
    DateTime? updatedAt;
    Badge? badge;

    PurchaseData({
        this.id,
        this.userId,
        this.badgeId,
        this.price,
        this.star,
        this.dateTime,
        this.createdAt,
        this.updatedAt,
        this.badge,
    });

    factory PurchaseData.fromJson(Map<String, dynamic> json) => PurchaseData(
        id: json["id"],
        userId: json["user_id"],
        badgeId: json["badge_id"],
        price: json["price"]?.toDouble(),
        star: json["star"],
        dateTime: json["date_time"] == null ? null : DateTime.parse(json["date_time"]),
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
    int? price;
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
        price: json["price"],
        star: json["star"],
        isActive: json["is_active"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );
}