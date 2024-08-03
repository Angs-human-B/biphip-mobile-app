class DashboardAudienceInsightByCountriesModel {
    List<Country>? countries;

    DashboardAudienceInsightByCountriesModel({
        this.countries,
    });

    factory DashboardAudienceInsightByCountriesModel.fromJson(Map<String, dynamic> json) => DashboardAudienceInsightByCountriesModel(
        countries: json["countries"] == null ? [] : List<Country>.from(json["countries"]!.map((x) => Country.fromJson(x))),
    );
}

class Country {
    String? country;
    double? audience;

    Country({
        this.country,
        this.audience,
    });

    factory Country.fromJson(Map<String, dynamic> json) => Country(
        country: json["country"],
        audience: json["audience"]?.toDouble(),
    );

}
