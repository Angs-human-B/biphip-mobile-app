class ProfileOverviewModel {
  User? user;
  CurrentCity? hometown;
  CurrentCity? currentCity;
  List<School> school;
  List<College> college;
  CurrentWorkplace? currentWorkplace;
  List<Link> links;
  List<Contact> contacts;

  ProfileOverviewModel({
    required this.user,
    required this.hometown,
    required this.currentCity,
    required this.school,
    required this.college,
    required this.currentWorkplace,
    required this.links,
    required this.contacts,
  });

  factory ProfileOverviewModel.fromJson(Map<String, dynamic> json) => ProfileOverviewModel(
        user: User.fromJson(json["user"]),
        hometown: CurrentCity.fromJson(json["hometown"]),
        currentCity: CurrentCity.fromJson(json["current_city"]),
        school: List<School>.from(json["school"].map((x) => School.fromJson(x))),
        college: List<College>.from(json["college"].map((x) => College.fromJson(x))),
        currentWorkplace: CurrentWorkplace.fromJson(json["current_workplace"]),
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        contacts: List<Contact>.from(json["contacts"].map((x) => Contact.fromJson(x))),
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
  dynamic started;
  dynamic ended;
  int? graduated;

  College({
    required this.id,
    required this.userId,
    required this.school,
    required this.description,
    required this.concentrations,
    required this.degree,
    required this.attendFor,
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
        started: json["started"],
        ended: json["ended"],
        graduated: json["graduated"],
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

class CurrentCity {
  int? id;
  int? userId;
  String? city;
  dynamic moved;
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
        moved: json["moved"],
        isHometown: json["is_hometown"],
        isCurrent: json["is_current"],
      );
}

class CurrentWorkplace {
  int? id;
  int? userId;
  String? company;
  dynamic position;
  dynamic city;
  dynamic description;
  dynamic started;
  dynamic ended;
  int? isCurrent;

  CurrentWorkplace({
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

  factory CurrentWorkplace.fromJson(Map<String, dynamic> json) => CurrentWorkplace(
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

class School {
  int? id;
  int? userId;
  String? school;
  dynamic description;
  dynamic started;
  dynamic ended;
  int? graduated;

  School({
    required this.id,
    required this.userId,
    required this.school,
    required this.description,
    required this.started,
    required this.ended,
    required this.graduated,
  });

  factory School.fromJson(Map<String, dynamic> json) => School(
        id: json["id"],
        userId: json["user_id"],
        school: json["school"],
        description: json["description"],
        started: json["started"],
        ended: json["ended"],
        graduated: json["graduated"],
      );
}

class User {
  int? id;
  String? userName;
  String? firstName;
  String? lastName;
  String? email;
  dynamic phone;
  String? gender;
  DateTime? dob;
  List<String> profession;
  List<String> interest;
  dynamic bio;
  dynamic languages;
  String? status;
  dynamic blockTill;
  dynamic refId;
  dynamic relation;
  dynamic relationWithName;
  dynamic relationWithId;
  dynamic profilePicture;
  dynamic coverPhoto;
  int? friendStatus;
  int? followStatus;
  String? familyRelationStatus;

  User({
    required this.id,
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
    required this.refId,
    required this.relation,
    required this.relationWithName,
    required this.relationWithId,

    required this.profilePicture,
    required this.coverPhoto,
    required this.friendStatus,
    required this.followStatus,
    required this.familyRelationStatus,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        userName: json["user_name"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        phone: json["phone"],

        gender: json["gender"],
        dob: DateTime.parse(json["dob"]),
        profession: List<String>.from(json["profession"].map((x) => x)),
        interest: List<String>.from(json["interest"].map((x) => x)),
        bio: json["bio"],
        languages: json["languages"],
        status: json["status"],
        blockTill: json["block_till"],
        refId: json["ref_id"],
        relation: json["relation"],
        relationWithName: json["relation_with_name"],
        relationWithId: json["relation_with_id"],

        profilePicture: json["profile_picture"],
        coverPhoto: json["cover_photo"],
        friendStatus: json["friend_status"],
        followStatus: json["follow_status"],
        familyRelationStatus: json["family_relation_status"],
      );
}
