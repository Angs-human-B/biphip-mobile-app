class DashboardPayoutEaringInsightModel {
    int? year;
    int? totalEarning;
    int? totalWithdraw;
    Map<String, int>? earningReport;

    DashboardPayoutEaringInsightModel({
        this.year,
        this.totalEarning,
        this.totalWithdraw,
        this.earningReport,
    });

    factory DashboardPayoutEaringInsightModel.fromJson(Map<String, dynamic> json) => DashboardPayoutEaringInsightModel(
        year: json["year"],
        totalEarning: json["total_earning"],
        totalWithdraw: json["total_withdraw"],
        earningReport: Map.from(json["earning_report"]!).map((k, v) => MapEntry<String, int>(k, v)),
    );
}
