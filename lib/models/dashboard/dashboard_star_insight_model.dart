class DashboardStarInsightModel {
    int? year;
    int? myStarBalance;
    int? totalPurchase;
    int? totalSpent;
    // GrowthStatics? growthStatics;
    Map<String, int>? starPurchaseReport;

    DashboardStarInsightModel({
        this.year,
        this.myStarBalance,
        this.totalPurchase,
        this.totalSpent,
        // this.growthStatics,
        this.starPurchaseReport,
    });

    factory DashboardStarInsightModel.fromJson(Map<String, dynamic> json) => DashboardStarInsightModel(
        year: json["year"],
        myStarBalance: json["my_star_balance"],
        totalPurchase: json["total_purchase"],
        totalSpent: json["total_spent"],
        // growthStatics: json["growth_statics"] == null ? null : GrowthStatics.fromJson(json["growth_statics"]),
        starPurchaseReport: Map.from(json["star_purchase_report"]!).map((k, v) => MapEntry<String, int>(k, v)),
    );
}

class GrowthStatics {
    int? friday;
    int? saturday;
    int? sunday;
    int? monday;
    int? tuesday;
    int? wednesday;
    int? thursday;
    int? amount;
    int? incdec;

    GrowthStatics({
        this.friday,
        this.saturday,
        this.sunday,
        this.monday,
        this.tuesday,
        this.wednesday,
        this.thursday,
        this.amount,
        this.incdec,
    });

    factory GrowthStatics.fromJson(Map<String, dynamic> json) => GrowthStatics(
        friday: json["friday"],
        saturday: json["saturday"],
        sunday: json["sunday"],
        monday: json["monday"],
        tuesday: json["tuesday"],
        wednesday: json["wednesday"],
        thursday: json["thursday"],
        amount: json["amount"],
        incdec: json["incdec"],
    );
}
