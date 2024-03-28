class KidSchoolModel {
  List<School> schools;

  KidSchoolModel({
    required this.schools,
  });

  factory KidSchoolModel.fromJson(Map<String, dynamic> json) => KidSchoolModel(
        schools: List<School>.from(json["schools"].map((x) => School.fromJson(x))),
      );
}

class School {
  int? id;
  int? pageId;
  String? school;
  dynamic description;
  DateTime? started;
  DateTime? ended;
  int? graduated;
  int? isCurrent;

  School({
    required this.id,
    required this.pageId,
    required this.school,
    required this.description,
    required this.started,
    required this.ended,
    required this.graduated,
    required this.isCurrent,
  });

  factory School.fromJson(Map<String, dynamic> json) => School(
        id: json["id"],
        pageId: json["page_id"],
        school: json["school"],
        description: json["description"],
        started: json["started"] == null ? null : DateTime.parse(json["started"]),
        ended: json["ended"] == null ? null : DateTime.parse(json["ended"]),
        graduated: json["graduated"],
        isCurrent: json["is_current"],
      );
}
