class DashboardGiftInsightModel {
    int? year;
    int? myGiftBalance;
    int? dailyEarnings;
    GrowthStatics? growthStatics;
    Map<String, int>? giftEarningReport;

    DashboardGiftInsightModel({
        this.year,
        this.myGiftBalance,
        this.dailyEarnings,
        this.growthStatics,
        this.giftEarningReport,
    });

    factory DashboardGiftInsightModel.fromJson(Map<String, dynamic> json) => DashboardGiftInsightModel(
        year: json["year"],
        myGiftBalance: json["my_gift_balance"],
        dailyEarnings: json["daily_earnings"],
        growthStatics: json["growth_statics"] == null ? null : GrowthStatics.fromJson(json["growth_statics"]),
        giftEarningReport: Map.from(json["gift_earning_report"]!).map((k, v) => MapEntry<String, int>(k, v)),
    );

    Map<String, dynamic> toJson() => {
        "year": year,
        "my_gift_balance": myGiftBalance,
        "daily_earnings": dailyEarnings,
        "growth_statics": growthStatics?.toJson(),
        "gift_earning_report": Map.from(giftEarningReport!).map((k, v) => MapEntry<String, dynamic>(k, v)),
    };
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

    Map<String, dynamic> toJson() => {
        "friday": friday,
        "saturday": saturday,
        "sunday": sunday,
        "monday": monday,
        "tuesday": tuesday,
        "wednesday": wednesday,
        "thursday": thursday,
        "amount": amount,
        "incdec": incdec,
    };
}
