import 'package:bip_hip/models/profile_view/user/user_profile_view_overview_model.dart';

class ProfileViewPlaceLiveModel {
    CurrentCity? hometown;
    CurrentCity? currentCity;
    List<CurrentCity>? places;

    ProfileViewPlaceLiveModel({
        this.hometown,
        this.currentCity,
        this.places,
    });

    factory ProfileViewPlaceLiveModel.fromJson(Map<String, dynamic> json) => ProfileViewPlaceLiveModel(
        hometown: json["hometown"] == null ? null : CurrentCity.fromJson(json["hometown"]),
        currentCity: json["current_city"] == null ? null : CurrentCity.fromJson(json["current_city"]),
        places: json["places"] == null ? [] : List<CurrentCity>.from(json["places"]!.map((x) => CurrentCity.fromJson(x))),
    );
}
