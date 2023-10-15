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
