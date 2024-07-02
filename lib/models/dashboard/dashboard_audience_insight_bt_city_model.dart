
class DashboardAudienceInsightByCityModel {
    List<City>? cities;

    DashboardAudienceInsightByCityModel({
        this.cities,
    });

    factory DashboardAudienceInsightByCityModel.fromJson(Map<String, dynamic> json) => DashboardAudienceInsightByCityModel(
        cities: json["cities"] == null ? [] : List<City>.from(json["cities"]!.map((x) => City.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "cities": cities == null ? [] : List<dynamic>.from(cities!.map((x) => x.toJson())),
    };
}

class City {
    String? city;
    double? audience;

    City({
        this.city,
        this.audience,
    });

    factory City.fromJson(Map<String, dynamic> json) => City(
        city: json["city"],
        audience: json["audience"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "city": city,
        "audience": audience,
    };
}
