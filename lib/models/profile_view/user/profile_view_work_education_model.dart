class ProfileViewWorkEducationModel {
    List<Work>? works;
    List<College>? colleges;
    List<College>? schools;

    ProfileViewWorkEducationModel({
        this.works,
        this.colleges,
        this.schools,
    });

    factory ProfileViewWorkEducationModel.fromJson(Map<String, dynamic> json) => ProfileViewWorkEducationModel(
        works: json["works"] == null ? [] : List<Work>.from(json["works"]!.map((x) => Work.fromJson(x))),
        colleges: json["colleges"] == null ? [] : List<College>.from(json["colleges"]!.map((x) => College.fromJson(x))),
        schools: json["schools"] == null ? [] : List<College>.from(json["schools"]!.map((x) => College.fromJson(x))),
    );
}

class College {
    int? id;
    int? userId;
    String? school;
    dynamic description;
    dynamic concentrations;
    dynamic degree;
    dynamic attendFor;
    DateTime? started;
    DateTime? ended;
    int? graduated;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? isCurrent;

    College({
        this.id,
        this.userId,
        this.school,
        this.description,
        this.concentrations,
        this.degree,
        this.attendFor,
        this.started,
        this.ended,
        this.graduated,
        this.createdAt,
        this.updatedAt,
        this.isCurrent,
    });

    factory College.fromJson(Map<String, dynamic> json) => College(
        id: json["id"],
        userId: json["user_id"],
        school: json["school"],
        description: json["description"],
        concentrations: json["concentrations"],
        degree: json["degree"],
        attendFor: json["attend_for"],
        started: json["started"] == null ? null : DateTime.parse(json["started"]),
        ended: json["ended"] == null ? null : DateTime.parse(json["ended"]),
        graduated: json["graduated"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        isCurrent: json["is_current"],
    );
}

class Work {
    int? id;
    int? userId;
    String? company;
    String? position;
    dynamic city;
    dynamic description;
    DateTime? started;
    dynamic ended;
    int? isCurrent;
    DateTime? createdAt;
    DateTime? updatedAt;

    Work({
        this.id,
        this.userId,
        this.company,
        this.position,
        this.city,
        this.description,
        this.started,
        this.ended,
        this.isCurrent,
        this.createdAt,
        this.updatedAt,
    });

    factory Work.fromJson(Map<String, dynamic> json) => Work(
        id: json["id"],
        userId: json["user_id"],
        company: json["company"],
        position: json["position"],
        city: json["city"],
        description: json["description"],
        started: json["started"] == null ? null : DateTime.parse(json["started"]),
        ended: json["ended"],
        isCurrent: json["is_current"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );
}
