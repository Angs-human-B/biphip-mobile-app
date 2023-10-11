class ProfileOverviewModel {
  String? relation;
  User? user;
  CurrentCity? hometown;
  CurrentCity? currentCity;
  List<CurrentCity> cities;
  List<College> school;
  List<College> college;
  Workplace? currentWorkplace;
  List<Workplace> workplaces;
  List<Link> links;
  List<Contact> contacts;
  String? email;
  dynamic phone;

  ProfileOverviewModel({
    required this.relation,
    required this.user,
    required this.hometown,
    required this.currentCity,
    required this.cities,
    required this.school,
    required this.college,
    required this.currentWorkplace,
    required this.workplaces,
    required this.links,
    required this.contacts,
    required this.email,
    required this.phone,
  });

  factory ProfileOverviewModel.fromJson(Map<String, dynamic> json) => ProfileOverviewModel(
        relation: json["relation"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        hometown: json["hometown"] == null ? null : CurrentCity.fromJson(json["hometown"]),
        currentCity: json["current_city"] == null ? null : CurrentCity.fromJson(json["current_city"]),
        cities: List<CurrentCity>.from(json["cities"].map((x) => CurrentCity.fromJson(x))),
        school: List<College>.from(json["school"].map((x) => College.fromJson(x))),
        college: List<College>.from(json["college"].map((x) => College.fromJson(x))),
        currentWorkplace: json["current_workplace"] == null ? null : Workplace.fromJson(json["current_workplace"]),
        workplaces: List<Workplace>.from(json["workplaces"].map((x) => Workplace.fromJson(x))),
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        contacts: List<Contact>.from(json["contacts"].map((x) => Contact.fromJson(x))),
        email: json["email"],
        phone: json["phone"],
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

  factory CurrentCity.fromJson(Map<String, dynamic>? json) => CurrentCity(
        id: json?["id"],
        userId: json?["user_id"],
        city: json?["city"],
        moved: json?["moved"] == null ? null : DateTime.parse(json?["moved"]),
        isHometown: json?["is_hometown"],
        isCurrent: json?["is_current"],
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
  dynamic position;
  dynamic city;
  dynamic description;
  dynamic started;
  dynamic ended;
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
        started: json["started"],
        ended: json["ended"],
        isCurrent: json["is_current"],
      );
}

class College {
  int? id;
  int? userId;
  String? school;
  String? description;
  String? concentrations;
  String? degree;
  String? attendFor;
  DateTime? started;
  DateTime? ended;
  int? graduated;

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

class User {
  int? id;
  dynamic image;
  String? userName;
  String? firstName;
  String? lastName;
  String? email;
  dynamic phone;
  String? gender;
  DateTime? dob;
  dynamic profession;
  dynamic interest;
  dynamic bio;
  dynamic languages;
  String? status;
  dynamic blockTill;
  String? otp;
  dynamic refId;
  String? relation;
  dynamic relationWithName;
  dynamic relationWithId;
  String? fullName;
  dynamic profilePicture;
  dynamic coverPhoto;
  int? friendStatus;
  int? followStatus;
  String? familyRelationStatus;

  User({
    required this.id,
    required this.image,
    required this.userName,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.gender,
    required this.dob,
    required this.profession,
    required this.interest,
    required this.bio,
    required this.languages,
    required this.status,
    required this.blockTill,
    required this.otp,
    required this.refId,
    required this.relation,
    required this.relationWithName,
    required this.relationWithId,
    required this.fullName,
    required this.profilePicture,
    required this.coverPhoto,
    required this.friendStatus,
    required this.followStatus,
    required this.familyRelationStatus,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        image: json["image"],
        userName: json["user_name"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        phone: json["phone"],
        gender: json["gender"],
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
        profession: json["profession"],
        interest: json["interest"],
        bio: json["bio"],
        languages: json["languages"],
        status: json["status"],
        blockTill: json["block_till"],
        otp: json["otp"],
        refId: json["ref_id"],
        relation: json["relation"],
        relationWithName: json["relation_with_name"],
        relationWithId: json["relation_with_id"],
        fullName: json["full_name"],
        profilePicture: json["profile_picture"],
        coverPhoto: json["cover_photo"],
        friendStatus: json["friend_status"],
        followStatus: json["follow_status"],
        familyRelationStatus: json["family_relation_status"],
      );
}
