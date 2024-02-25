class UserPendentModel {
    List<UserPendent> userPendents;
    List<Pendent> recommendedPendents;
    List<Pendent> allPendents;

    UserPendentModel({
        required this.userPendents,
        required this.recommendedPendents,
        required this.allPendents,
    });

    factory UserPendentModel.fromJson(Map<String, dynamic> json) => UserPendentModel(
        userPendents: List<UserPendent>.from(json["user_pendents"].map((x) => UserPendent.fromJson(x))),
        recommendedPendents: List<Pendent>.from(json["recommended_pendents"].map((x) => Pendent.fromJson(x))),
        allPendents: List<Pendent>.from(json["all_pendents"].map((x) => Pendent.fromJson(x))),
    );
}

class Pendent {
    int ? id;
    String? name;
    String ?description;
    int ?price;
    int ?star;
    String ?icon;

    Pendent({
        required this.id,
        required this.name,
        required this.description,
        required this.price,
        required this.star,
        required this.icon,
    });

    factory Pendent.fromJson(Map<String, dynamic> json) => Pendent(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        price: json["price"],
        star: json["star"],
        icon: json["icon"],
    );
}

class UserPendent {
    int ?id;
    int ?pendentId;
    int ?userId;
    DateTime ?startDate;
    DateTime ?endDate;
    int ?isActive;
    String ?pendentPurchaseHistory;
    PendentClass ? pendent;

    UserPendent({
        required this.id,
        required this.pendentId,
        required this.userId,
        required this.startDate,
        required this.endDate,
        required this.isActive,
        required this.pendentPurchaseHistory,
        required this.pendent,
    });

    factory UserPendent.fromJson(Map<String, dynamic> json) => UserPendent(
        id: json["id"],
        pendentId: json["pendent_id"],
        userId: json["user_id"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        isActive: json["is_active"],
        pendentPurchaseHistory: json["pendent_purchase_history"],
        pendent: PendentClass.fromJson(json["pendent"]),
    );
}

class PendentClass {
    int ?id;
    String ?name;
    String ?description;
    String ?icon;
    int ?price;
    int ?star;
    int ?validityDays;
    int ?monthlyRoi;
    double ?dailyRoi;
    int ?affilate;
    int ?giftSendBenefits;
    int ?giftReceiveBenefits;
    int ?isActive;

    PendentClass({
        required this.id,
        required this.name,
        required this.description,
        required this.icon,
        required this.price,
        required this.star,
        required this.validityDays,
        required this.monthlyRoi,
        required this.dailyRoi,
        required this.affilate,
        required this.giftSendBenefits,
        required this.giftReceiveBenefits,
        required this.isActive,
    });

    factory PendentClass.fromJson(Map<String, dynamic> json) => PendentClass(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        icon: json["icon"],
        price: json["price"],
        star: json["star"],
        validityDays: json["validity_days"],
        monthlyRoi: json["monthly_roi"],
        dailyRoi: json["daily_roi"]?.toDouble(),
        affilate: json["affilate"],
        giftSendBenefits: json["gift_send_benefits"],
        giftReceiveBenefits: json["gift_receive_benefits"],
        isActive: json["is_active"],
    );
}
