import 'package:bip_hip/models/common/common_user_model.dart';
class ProfileOverviewModel {
    User? user;
    String? profile;
    Workplace? currentWorkplace;
    College? school;
    College? college;
    CurrentCity? hometown;
    CurrentCity? currentCity;
    Link? link;
    String? email;
    dynamic phone;
    dynamic relation;
    List<Workplace> workplaces;
    List<College> schools;
    List<College> colleges;
    List<CurrentCity> cities;
    List<Link> links;
    List<Contact> contacts;

    ProfileOverviewModel({
        required this.user,
        required this.profile,
        required this.currentWorkplace,
        required this.school,
        required this.college,
        required this.hometown,
        required this.currentCity,
        required this.link,
        required this.email,
        required this.phone,
        required this.relation,
        required this.workplaces,
        required this.schools,
        required this.colleges,
        required this.cities,
        required this.links,
        required this.contacts,
    });

    factory ProfileOverviewModel.fromJson(Map<String, dynamic> json) => ProfileOverviewModel(
        user: json["user"] == null ? null :User.fromJson(json["user"]),
        profile: json["profile"],
        currentWorkplace: json["current_workplace"]==null?null:Workplace.fromJson(json["current_workplace"]),
        school: json["school"]==null?null:College.fromJson(json["school"]),
        college: json["college"]==null?null:College.fromJson(json["college"]),
        hometown: json["hometown"]==null?null:CurrentCity.fromJson(json["hometown"]),
        currentCity: json["current_city"]==null?null:CurrentCity.fromJson(json["current_city"]),
        link:json["link"]==null?null:Link.fromJson(json["link"]),
        email: json["email"],
        phone: json["phone"],
        relation: json["relation"],
        workplaces: List<Workplace>.from(json["workplaces"].map((x) => Workplace.fromJson(x))),
        schools: List<College>.from(json["schools"].map((x) => College.fromJson(x))),
        colleges: List<College>.from(json["colleges"].map((x) => College.fromJson(x))),
        cities: List<CurrentCity>.from(json["cities"].map((x) => CurrentCity.fromJson(x))),
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        contacts: List<Contact>.from(json["contacts"].map((x) => Contact.fromJson(x))),
    );
}

class CurrentCity {
    int? id;
    int? userId;
    String? city;
    DateTime? moved;
    int? isHometown;
    int? isCurrent;

    CurrentCity({
        required this.id,
        required this.userId,
        required this.city,
        required this.moved,
        required this.isHometown,
        required this.isCurrent,
    });

    factory CurrentCity.fromJson(Map<String, dynamic> json) => CurrentCity(
        id: json["id"],
        userId: json["user_id"],
        city: json["city"],
        moved: json["moved"] == null ? null : DateTime.parse(json["moved"]),
        isHometown: json["is_hometown"],
        isCurrent: json["is_current"],
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
    int? isCurrent;

    College({
        required this.id,
        required this.userId,
        required this.school,
        required this.description,
        this.concentrations,
        this.degree,
        this.attendFor,
        required this.started,
        required this.ended,
        required this.graduated,
        required this.isCurrent,
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
        isCurrent: json["is_current"],
    );
}

class Contact {
    int? id;
    int? userId;
    String? type;
    String? value;

    Contact({
        required this.id,
        required this.userId,
        required this.type,
        required this.value,
    });

    factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        id: json["id"],
        userId: json["user_id"],
        type: json["type"],
        value: json["value"],
    );
}

class Workplace {
    int? id;
    int? userId;
    String? company;
    String? position;
    dynamic city;
    dynamic description;
    DateTime? started;
    DateTime? ended;
    int? isCurrent;

    Workplace({
        required this.id,
        required this.userId,
        required this.company,
        required this.position,
        required this.city,
        required this.description,
        required this.started,
        required this.ended,
        required this.isCurrent,
    });

    factory Workplace.fromJson(Map<String, dynamic> json) => Workplace(
        id: json["id"],
        userId: json["user_id"],
        company: json["company"],
        position: json["position"],
        city: json["city"],
        description: json["description"],
        started: json["started"] == null ? null : DateTime.parse(json["started"]),
        ended: json["ended"] == null ? null : DateTime.parse(json["ended"]),
        isCurrent: json["is_current"],
    );
}

class Link {
    int? id;
    int? userId;
    String? type;
    String? userName;
    String? link;

    Link({
        required this.id,
        required this.userId,
        required this.type,
        required this.userName,
        required this.link,
    });

    factory Link.fromJson(Map<String, dynamic> json) => Link(
        id: json["id"],
        userId: json["user_id"],
        type: json["type"],
        userName: json["user_name"],
        link: json["link"],
    );
}


