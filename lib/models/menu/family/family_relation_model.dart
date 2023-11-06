class FamilyRelationModel {
  List<Relation> relations;

  FamilyRelationModel({
    required this.relations,
  });

  factory FamilyRelationModel.fromJson(Map<String, dynamic> json) => FamilyRelationModel(
        relations: List<Relation>.from(json["relations"].map((x) => Relation.fromJson(x))),
      );
}

class Relation {
  int id;
  String name;

  Relation({
    required this.id,
    required this.name,
  });

  factory Relation.fromJson(Map<String, dynamic> json) => Relation(
        id: json["id"],
        name: json["name"],
      );
}
