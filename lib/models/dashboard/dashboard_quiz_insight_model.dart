class DashboardQuizInsightModel {
    DateTime? startDate;
    DateTime? endDate;
    int? totalPlay;
    int? totalPlayPercentage;
    int? win;
    int? winPercentage;
    int? lost;
    int? lostPercentage;
    int? winRatio;
    int? winRatioPercentage;

    DashboardQuizInsightModel({
        this.startDate,
        this.endDate,
        this.totalPlay,
        this.totalPlayPercentage,
        this.win,
        this.winPercentage,
        this.lost,
        this.lostPercentage,
        this.winRatio,
        this.winRatioPercentage,
    });

    factory DashboardQuizInsightModel.fromJson(Map<String, dynamic> json) => DashboardQuizInsightModel(
        startDate: json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
        endDate: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        totalPlay: json["total_play"],
        totalPlayPercentage: json["total_play_percentage"],
        win: json["win"],
        winPercentage: json["win_percentage"],
        lost: json["lost"],
        lostPercentage: json["lost_percentage"],
        winRatio: json["win_ratio"],
        winRatioPercentage: json["win_ratio_percentage"],
    );
}
