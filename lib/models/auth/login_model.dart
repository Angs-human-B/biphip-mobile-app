

import 'package:bip_hip/models/common/common_user_model.dart';

class LoginModel {
  User user;
  dynamic token;

  LoginModel({
    required this.user,
    required this.token,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        user: User.fromJson(json["user"]),
        token: json["token"],
      );
}

// class User {
//   int id;
//   dynamic image;
//   String? userName;
//   String? firstName;
//   String? lastName;
//   String? email;
//   dynamic phone;
//   String? gender;
//   DateTime? dob;
//   dynamic profession;
//   dynamic interest;
//   dynamic bio;
//   dynamic languages;
//   String? status;
//   dynamic blockTill;
//   String? otp;
//   dynamic refId;
//   dynamic relation;
//   dynamic relationWithName;
//   dynamic relationWithId;
//   dynamic cover;
//   String fullName;
//   dynamic profilePicture;
//   dynamic coverPhoto;

//   User({
//     required this.id,
//     required this.image,
//     required this.userName,
//     required this.firstName,
//     required this.lastName,
//     required this.email,
//     required this.phone,
//     required this.gender,
//     required this.dob,
//     required this.profession,
//     required this.interest,
//     required this.bio,
//     required this.languages,
//     required this.status,
//     required this.blockTill,
//     required this.otp,
//     required this.refId,
//     required this.relation,
//     required this.relationWithName,
//     required this.relationWithId,
//     required this.cover,
//     required this.fullName,
//     required this.profilePicture,
//     required this.coverPhoto,
//   });

//   factory User.fromJson(Map<String, dynamic> json) => User(
//         id: json["id"],
//         image: json["image"],
//         userName: json["user_name"],
//         firstName: json["first_name"],
//         lastName: json["last_name"],
//         email: json["email"],
//         phone: json["phone"],
//         gender: json["gender"],
//         dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
//         profession: json["profession"],
//         interest: json["interest"],
//         bio: json["bio"],
//         languages: json["languages"],
//         status: json["status"],
//         blockTill: json["block_till"],
//         otp: json["otp"],
//         refId: json["ref_id"],
//         relation: json["relation"],
//         relationWithName: json["relation_with_name"],
//         relationWithId: json["relation_with_id"],
//         cover: json["cover"],
//         fullName: json["full_name"],
//         profilePicture: json["profile_picture"],
//         coverPhoto: json["cover_photo"],
//       );
// }
