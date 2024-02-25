class UserBadgesModel {
  int? starBalance;
  List<Badge> recommendedBadges;
  List<Badge> allBadges;
  List<Badge> popularBadges;
  LastPurchase? lastPurchase;

  UserBadgesModel({
    required this.starBalance,
    required this.recommendedBadges,
    required this.allBadges,
    required this.popularBadges,
    required this.lastPurchase,
  });

  factory UserBadgesModel.fromJson(Map<String, dynamic> json) => UserBadgesModel(
        starBalance: json["star_balance"],
        recommendedBadges: List<Badge>.from(json["recommended_badges"].map((x) => Badge.fromJson(x))),
        allBadges: List<Badge>.from(json["all_badges"].map((x) => Badge.fromJson(x))),
        popularBadges: List<Badge>.from(json["popular_badges"].map((x) => Badge.fromJson(x))),
        lastPurchase: json["last_purchase"] == null ? null : LastPurchase.fromJson(json["last_purchase"]),
      );
}

class Badge {
  int? id;
  String? name;
  String? description;
  double? price;
  int? star;
  String? icon;

  Badge({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.star,
    required this.icon,
  });

  factory Badge.fromJson(Map<String, dynamic> json) => Badge(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        price: json["price"]?.toDouble(),
        star: json["star"],
        icon: json["icon"],
      );
}

class LastPurchase {
  int? id;
  int? userId;
  int? badgeId;
  int? price;
  int? star;
  DateTime dateTime;
  BadgeClass badge;

  LastPurchase({
    required this.id,
    required this.userId,
    required this.badgeId,
    required this.price,
    required this.star,
    required this.dateTime,
    required this.badge,
  });

  factory LastPurchase.fromJson(Map<String, dynamic> json) => LastPurchase(
        id: json["id"],
        userId: json["user_id"],
        badgeId: json["badge_id"],
        price: json["price"],
        star: json["star"],
        dateTime: DateTime.parse(json["date_time"]),
        badge: BadgeClass.fromJson(json["badge"]),
      );
}

class BadgeClass {
  int? id;
  String? name;
  String? description;
  String? icon;
  int? price;
  int? star;
  int? isActive;

  BadgeClass({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.price,
    required this.star,
    required this.isActive,
  });

  factory BadgeClass.fromJson(Map<String, dynamic> json) => BadgeClass(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        icon: json["icon"],
        price: json["price"],
        star: json["star"],
        isActive: json["is_active"],
      );
}
