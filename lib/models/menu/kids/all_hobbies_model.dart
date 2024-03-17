class AllHobbiesModel {
    List<String> hobbies;

    AllHobbiesModel({
        required this.hobbies,
    });

    factory AllHobbiesModel.fromJson(Map<String, dynamic> json) => AllHobbiesModel(
        hobbies: List<String>.from(json["hobbies"].map((x) => x)),
    );
}