class ProfessionListModel {
    List<String> professions;

    ProfessionListModel({
        required this.professions,
    });

    factory ProfessionListModel.fromJson(Map<String, dynamic> json) => ProfessionListModel(
        professions: List<String>.from(json["professions"].map((x) => x)),
    );

}
class InterestListModel {
    List<String> interests;

    InterestListModel({
        required this.interests,
    });

    factory InterestListModel.fromJson(Map<String, dynamic> json) => InterestListModel(
        interests: List<String>.from(json["interests"].map((x) => x)),
    );
}

class RelationshipListModel {
    List<String> relationships;

    RelationshipListModel({
        required this.relationships,
    });

    factory RelationshipListModel.fromJson(Map<String, dynamic> json) => RelationshipListModel(
        relationships: List<String>.from(json["relationships"].map((x) => x)),
    );
}

class GenderListModel {
    List<String> genders;

    GenderListModel({
        required this.genders,
    });

    factory GenderListModel.fromJson(Map<String, dynamic> json) => GenderListModel(
        genders: List<String>.from(json["genders"].map((x) => x)),
    );
}