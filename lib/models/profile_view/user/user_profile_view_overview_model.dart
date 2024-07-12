import 'package:bip_hip/models/common/common_user_model.dart';

class UserProfileViewOverviewModel {
    User? user;
    // Works? works;
    Colleges? colleges;
    Colleges? schools;
    CurrentCity? hometown;
    CurrentCity? currentCity;
    String? relation;

    UserProfileViewOverviewModel({
        this.user,
        // this.works,
        this.colleges,
        this.schools,
        // this.hometown,
        // this.currentCity,
        this.relation,
    });

    factory UserProfileViewOverviewModel.fromJson(Map<String, dynamic> json) => UserProfileViewOverviewModel(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        // works: json["works"] == null ? null : Works.fromJson(json["works"]),
        colleges: json["colleges"] == null ? null : Colleges.fromJson(json["colleges"]),
        schools: json["schools"] == null ? null : Colleges.fromJson(json["schools"]),
        // hometown: json["hometown"] == null ? null : CurrentCity.fromJson(json["hometown"]),
        // currentCity: json["current_city"] == null ? null : CurrentCity.fromJson(json["current_city"]),
        relation: json["relation"],
    );
}

class Colleges {
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

    Colleges({
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

    factory Colleges.fromJson(Map<String, dynamic> json) => Colleges(
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

class CurrentCity {
    int? id;
    int? userId;
    String? city;
    dynamic moved;
    int? isHometown;
    int? isCurrent;
    DateTime? createdAt;
    DateTime? updatedAt;

    CurrentCity({
        this.id,
        this.userId,
        this.city,
        this.moved,
        this.isHometown,
        this.isCurrent,
        this.createdAt,
        this.updatedAt,
    });

    factory CurrentCity.fromJson(Map<String, dynamic> json) => CurrentCity(
        id: json["id"],
        userId: json["user_id"],
        city: json["city"],
        moved: json["moved"],
        isHometown: json["is_hometown"],
        isCurrent: json["is_current"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );
}
// class Works {
//     int? id;
//     int? userId;
//     String? company;
//     String? position;
//     dynamic city;
//     dynamic description;
//     DateTime? started;
//     dynamic ended;
//     int? isCurrent;
//     DateTime? createdAt;
//     DateTime? updatedAt;

//     Works({
//         this.id,
//         this.userId,
//         this.company,
//         this.position,
//         this.city,
//         this.description,
//         this.started,
//         this.ended,
//         this.isCurrent,
//         this.createdAt,
//         this.updatedAt,
//     });

//     factory Works.fromJson(Map<String, dynamic> json) => Works(
//         id: json["id"],
//         userId: json["user_id"],
//         company: json["company"],
//         position: json["position"],
//         city: json["city"],
//         description: json["description"],
//         started: json["started"] == null ? null : DateTime.parse(json["started"]),
//         ended: json["ended"],
//         isCurrent: json["is_current"],
//         createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
//     );
// }
