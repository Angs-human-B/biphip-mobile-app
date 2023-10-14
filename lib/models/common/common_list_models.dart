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