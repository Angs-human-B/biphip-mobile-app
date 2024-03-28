class AllLocationModel {
    List<Location> locations;

    AllLocationModel({
        required this.locations,
    });

    factory AllLocationModel.fromJson(Map<String, dynamic> json) => AllLocationModel(
        locations: List<Location>.from(json["locations"].map((x) => Location.fromJson(x))),
    );
}

class Location {
    int ?id;
    int ?pageId;
    String? location;

    Location({
        required this.id,
        required this.pageId,
        required this.location,
    });

    factory Location.fromJson(Map<String, dynamic> json) => Location(
        id: json["id"],
        pageId: json["page_id"],
        location: json["location"],
    );
}
