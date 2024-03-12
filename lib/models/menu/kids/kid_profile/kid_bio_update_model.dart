import 'package:bip_hip/models/menu/kids/kid_profile/kid_overview_model.dart';
class KidBioUpdateModel {
    Kids ?kids;

    KidBioUpdateModel({
        required this.kids,
    });

    factory KidBioUpdateModel.fromJson(Map<String, dynamic> json) => KidBioUpdateModel(
        kids: Kids.fromJson(json["kid"]),
    );
}

// class Kid {
//     int ?id;
//     String? pageType;
//     String? pageId;
//     int userId;
//     String name;
//     String bio;
//     int age;
//     dynamic dob;
//     int relationId;
//     List<String> categories;
//     String image;
//     String cover;
//     dynamic bin;
//     dynamic country;
//     int rating;
//     List<dynamic> hobbies;
//     List<dynamic> languages;
//     String gender;
//     dynamic privacyLink;
//     DateTime createdAt;
//     DateTime updatedAt;
//     dynamic qr;
//     dynamic legalFiles;
//     dynamic introVideo;
//     String email;
//     String phone;
//     String address;
//     String profilePicture;
//     String coverPhoto;
//     int profileImageId;
//     int coverImageId;
//     dynamic qrCode;
//     dynamic legalPapers;
//     dynamic introVideoFile;
//     int countFollowers;
//     int countPageRating;
//     int countPageReviews;
//     String relation;
//     Image proImage;
//     Image coverImage;

//     Kid({
//         required this.id,
//         required this.pageType,
//         required this.pageId,
//         required this.userId,
//         required this.name,
//         required this.bio,
//         required this.age,
//         required this.dob,
//         required this.relationId,
//         required this.categories,
//         required this.image,
//         required this.cover,
//         required this.bin,
//         required this.country,
//         required this.rating,
//         required this.hobbies,
//         required this.languages,
//         required this.gender,
//         required this.privacyLink,
//         required this.createdAt,
//         required this.updatedAt,
//         required this.qr,
//         required this.legalFiles,
//         required this.introVideo,
//         required this.email,
//         required this.phone,
//         required this.address,
//         required this.profilePicture,
//         required this.coverPhoto,
//         required this.profileImageId,
//         required this.coverImageId,
//         required this.qrCode,
//         required this.legalPapers,
//         required this.introVideoFile,
//         required this.countFollowers,
//         required this.countPageRating,
//         required this.countPageReviews,
//         required this.relation,
//         required this.proImage,
//         required this.coverImage,
//     });

//     factory Kid.fromJson(Map<String, dynamic> json) => Kid(
//         id: json["id"],
//         pageType: json["page_type"],
//         pageId: json["page_id"],
//         userId: json["user_id"],
//         name: json["name"],
//         bio: json["bio"],
//         age: json["age"],
//         dob: json["dob"],
//         relationId: json["relation_id"],
//         categories: List<String>.from(json["categories"].map((x) => x)),
//         image: json["image"],
//         cover: json["cover"],
//         bin: json["bin"],
//         country: json["country"],
//         rating: json["rating"],
//         hobbies: List<dynamic>.from(json["hobbies"].map((x) => x)),
//         languages: List<dynamic>.from(json["languages"].map((x) => x)),
//         gender: json["gender"],
//         privacyLink: json["privacy_link"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//         qr: json["qr"],
//         legalFiles: json["legal_files"],
//         introVideo: json["intro_video"],
//         email: json["email"],
//         phone: json["phone"],
//         address: json["address"],
//         profilePicture: json["profile_picture"],
//         coverPhoto: json["cover_photo"],
//         profileImageId: json["profile_image_id"],
//         coverImageId: json["cover_image_id"],
//         qrCode: json["qr_code"],
//         legalPapers: json["legal_papers"],
//         introVideoFile: json["intro_video_file"],
//         countFollowers: json["count_followers"],
//         countPageRating: json["count_page_rating"],
//         countPageReviews: json["count_page_reviews"],
//         relation: json["relation"],
//         proImage: Image.fromJson(json["pro_image"]),
//         coverImage: Image.fromJson(json["cover_image"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "page_type": pageType,
//         "page_id": pageId,
//         "user_id": userId,
//         "name": name,
//         "bio": bio,
//         "age": age,
//         "dob": dob,
//         "relation_id": relationId,
//         "categories": List<dynamic>.from(categories.map((x) => x)),
//         "image": image,
//         "cover": cover,
//         "bin": bin,
//         "country": country,
//         "rating": rating,
//         "hobbies": List<dynamic>.from(hobbies.map((x) => x)),
//         "languages": List<dynamic>.from(languages.map((x) => x)),
//         "gender": gender,
//         "privacy_link": privacyLink,
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//         "qr": qr,
//         "legal_files": legalFiles,
//         "intro_video": introVideo,
//         "email": email,
//         "phone": phone,
//         "address": address,
//         "profile_picture": profilePicture,
//         "cover_photo": coverPhoto,
//         "profile_image_id": profileImageId,
//         "cover_image_id": coverImageId,
//         "qr_code": qrCode,
//         "legal_papers": legalPapers,
//         "intro_video_file": introVideoFile,
//         "count_followers": countFollowers,
//         "count_page_rating": countPageRating,
//         "count_page_reviews": countPageReviews,
//         "relation": relation,
//         "pro_image": proImage.toJson(),
//         "cover_image": coverImage.toJson(),
//     };
// }

// class Image {
//     int id;
//     int userId;
//     dynamic postId;
//     String fileType;
//     int imageAlbumId;
//     dynamic imageType;
//     String storageType;
//     dynamic mimeType;
//     String title;
//     String storagePath;
//     String path;
//     int filesize;
//     dynamic description;
//     dynamic imageTakenTime;
//     dynamic imageTakenLocation;
//     int countView;
//     int countShare;
//     int countComment;
//     int countStar;
//     dynamic countReactions;
//     DateTime createdAt;
//     DateTime updatedAt;
//     String fullPath;
//     List<dynamic> taggedFriends;
//     List<String> reactingPersons;
//     int totalViewCount;
//     dynamic myReaction;

//     Image({
//         required this.id,
//         required this.userId,
//         required this.postId,
//         required this.fileType,
//         required this.imageAlbumId,
//         required this.imageType,
//         required this.storageType,
//         required this.mimeType,
//         required this.title,
//         required this.storagePath,
//         required this.path,
//         required this.filesize,
//         required this.description,
//         required this.imageTakenTime,
//         required this.imageTakenLocation,
//         required this.countView,
//         required this.countShare,
//         required this.countComment,
//         required this.countStar,
//         required this.countReactions,
//         required this.createdAt,
//         required this.updatedAt,
//         required this.fullPath,
//         required this.taggedFriends,
//         required this.reactingPersons,
//         required this.totalViewCount,
//         required this.myReaction,
//     });

//     factory Image.fromJson(Map<String, dynamic> json) => Image(
//         id: json["id"],
//         userId: json["user_id"],
//         postId: json["post_id"],
//         fileType: json["file_type"],
//         imageAlbumId: json["image_album_id"],
//         imageType: json["image_type"],
//         storageType: json["storage_type"],
//         mimeType: json["mime_type"],
//         title: json["title"],
//         storagePath: json["storage_path"],
//         path: json["path"],
//         filesize: json["filesize"],
//         description: json["description"],
//         imageTakenTime: json["image_taken_time"],
//         imageTakenLocation: json["image_taken_location"],
//         countView: json["count_view"],
//         countShare: json["count_share"],
//         countComment: json["count_comment"],
//         countStar: json["count_star"],
//         countReactions: json["count_reactions"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//         fullPath: json["full_path"],
//         taggedFriends: List<dynamic>.from(json["tagged_friends"].map((x) => x)),
//         reactingPersons: List<String>.from(json["reacting_persons"].map((x) => x)),
//         totalViewCount: json["total_view_count"],
//         myReaction: json["my_reaction"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "user_id": userId,
//         "post_id": postId,
//         "file_type": fileType,
//         "image_album_id": imageAlbumId,
//         "image_type": imageType,
//         "storage_type": storageType,
//         "mime_type": mimeType,
//         "title": title,
//         "storage_path": storagePath,
//         "path": path,
//         "filesize": filesize,
//         "description": description,
//         "image_taken_time": imageTakenTime,
//         "image_taken_location": imageTakenLocation,
//         "count_view": countView,
//         "count_share": countShare,
//         "count_comment": countComment,
//         "count_star": countStar,
//         "count_reactions": countReactions,
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//         "full_path": fullPath,
//         "tagged_friends": List<dynamic>.from(taggedFriends.map((x) => x)),
//         "reacting_persons": List<dynamic>.from(reactingPersons.map((x) => x)),
//         "total_view_count": totalViewCount,
//         "my_reaction": myReaction,
//     };
// }
