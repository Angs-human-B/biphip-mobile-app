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

class PositionListModel {
  List<String> positions;

  PositionListModel({
    required this.positions,
  });

  factory PositionListModel.fromJson(Map<String, dynamic> json) => PositionListModel(
        positions: List<String>.from(json["positions"].map((x) => x)),
      );
}

class LinkListModel {
  List<String> linkTypes;

  LinkListModel({
    required this.linkTypes,
  });

  factory LinkListModel.fromJson(Map<String, dynamic> json) => LinkListModel(
        linkTypes: List<String>.from(json["linkTypes"].map((x) => x)),
      );
}

class CityListModel {
  List<String> cities;

  CityListModel({
    required this.cities,
  });

  factory CityListModel.fromJson(Map<String, dynamic> json) => CityListModel(
        cities: List<String>.from(json["cities"].map((x) => x)),
      );
}

class CompanyListModel {
  List<String> companies;

  CompanyListModel({
    required this.companies,
  });

  factory CompanyListModel.fromJson(Map<String, dynamic> json) => CompanyListModel(
        companies: List<String>.from(json["companies"].map((x) => x)),
      );
}

class SchoolListModel {
  List<String> schools;

  SchoolListModel({
    required this.schools,
  });

  factory SchoolListModel.fromJson(Map<String, dynamic> json) => SchoolListModel(
        schools: List<String>.from(json["schools"].map((x) => x)),
      );
}

class CommonListModel {
  List<String> professions;
  List<String> interests;
  List<String> relationships;
  List<String> linkTypes;
  List<String> genders;
  List<String> positions;
  List<String> cities;
  List<String> companies;

  List<String> schools;

  CommonListModel({
    required this.professions,
    required this.interests,
    required this.relationships,
    required this.linkTypes,
    required this.genders,
    required this.positions,
    required this.cities,
    required this.schools,
    required this.companies,

  });

  factory CommonListModel.fromJson(Map<String, dynamic> json) => CommonListModel(
        professions: List<String>.from(json["professions"].map((x) => x)),
        interests: List<String>.from(json["interests"].map((x) => x)),
        relationships: List<String>.from(json["relationships"].map((x) => x)),
        linkTypes: List<String>.from(json["linkTypes"].map((x) => x)),
        genders: List<String>.from(json["genders"].map((x) => x)),
        positions: List<String>.from(json["positions"].map((x) => x)),
        cities: List<String>.from(json["cities"].map((x) => x)),
        schools: List<String>.from(json["schools"].map((x) => x)),
        companies: List<String>.from(json["companies"].map((x) => x)),
      );
}
