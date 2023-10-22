class FriendFamilyUserData {
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

  FriendFamilyUserData({
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

  factory FriendFamilyUserData.fromJson(Map<String, dynamic> json) => FriendFamilyUserData(
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