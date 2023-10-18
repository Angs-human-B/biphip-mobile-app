class CommonFamilySendReceiveModel {
  CommonFamilies? users;

  CommonFamilySendReceiveModel({
    required this.users,
  });

  factory CommonFamilySendReceiveModel.fromJson(Map<String, dynamic> json) => CommonFamilySendReceiveModel(
        users: CommonFamilies.fromJson(json["users"]),
      );
}

class CommonFamilyModel {
  CommonFamilies? families;

  CommonFamilyModel({
    required this.families,
  });

  factory CommonFamilyModel.fromJson(Map<String, dynamic> json) => CommonFamilyModel(
        families: CommonFamilies.fromJson(json["families"]),
      );
}

class CommonFamilies {
  int? currentPage;
  List<FamilyData> data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link> links;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  CommonFamilies({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
  });

  factory CommonFamilies.fromJson(Map<String, dynamic> json) => CommonFamilies(
        currentPage: json["current_page"],
        data: List<FamilyData>.from(json["data"].map((x) => FamilyData.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );
}

class FamilyData {
  int? id;
  String? userName;
  String? firstName;
  String? lastName;
  String? email;
  dynamic phone;
  String? gender;
  DateTime? dob;
  List<dynamic> profession;
  List<dynamic> interest;
  dynamic bio;
  String? languages;
  String? status;
  dynamic refId;
  String? relation;
  dynamic relationWithName;
  dynamic relationWithId;
  String? fullName;
  dynamic profilePicture;
  String? coverPhoto;
  int? friendStatus;
  int? followStatus;
  String? familyRelationStatus;

  FamilyData({
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

  factory FamilyData.fromJson(Map<String, dynamic> json) => FamilyData(
        id: json["id"],
        userName: json["user_name"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        phone: json["phone"],
        gender: json["gender"],
        dob: DateTime.parse(json["dob"]),
        profession: List<dynamic>.from(json["profession"].map((x) => x)),
        interest: List<dynamic>.from(json["interest"].map((x) => x)),
        bio: json["bio"],
        languages: json["languages"],
        status: json["status"],
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

class Link {
  String? url;
  String? label;
  bool? active;

  Link({
    required this.url,
    required this.label,
    required this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );
}
