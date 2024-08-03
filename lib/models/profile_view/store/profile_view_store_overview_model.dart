import 'package:bip_hip/models/profile_view/user/profile_view_award_model.dart';
import 'package:bip_hip/models/profile_view/user/user_profile_view_basic_info_model.dart';

class ProfileViewStoreOverviewModel {
    Store? store;
    List<Contact>? contacts;

    ProfileViewStoreOverviewModel({
        this.store,
        this.contacts,
    });

    factory ProfileViewStoreOverviewModel.fromJson(Map<String, dynamic> json) => ProfileViewStoreOverviewModel(
        store: json["store"] == null ? null : Store.fromJson(json["store"]),
        contacts: json["contacts"] == null ? [] : List<Contact>.from(json["contacts"]!.map((x) => Contact.fromJson(x))),
    );
}

// class Contact {
//     int? id;
//     int? pageId;
//     String? type;
//     String? value;
//     DateTime? createdAt;
//     DateTime? updatedAt;

//     Contact({
//         this.id,
//         this.pageId,
//         this.type,
//         this.value,
//         this.createdAt,
//         this.updatedAt,
//     });

//     factory Contact.fromJson(Map<String, dynamic> json) => Contact(
//         id: json["id"],
//         pageId: json["page_id"],
//         type: json["type"],
//         value: json["value"],
//         createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
//     );
// }

class Store {
    int? id;
    String? pageType;
    String? pageId;
    int? userId;
    String? name;
    String? bio;
    dynamic age;
    dynamic dob;
    dynamic relationId;
    List<String>? categories;
    String? image;
    String? cover;
    String? bin;
    dynamic country;
    int? rating;
    List<dynamic>? hobbies;
    List<dynamic>? languages;
    dynamic gender;
    dynamic privacyLink;
    DateTime? createdAt;
    DateTime? updatedAt;
    String? qr;
    String? legalFiles;
    dynamic introVideo;
    String? email;
    String? phone;
    String? address;
    String? profilePicture;
    String? coverPhoto;
    int? profileImageId;
    int? coverImageId;
    String? qrCode;
    List<String>? legalPapers;
    dynamic introVideoFile;
    int? countFollowers;
    int? countPageRating;
    int? countPageReviews;
    dynamic relation;
    dynamic chatRoomId;
    Image? proImage;
    Image? coverImage;

    Store({
        this.id,
        this.pageType,
        this.pageId,
        this.userId,
        this.name,
        this.bio,
        this.age,
        this.dob,
        this.relationId,
        this.categories,
        this.image,
        this.cover,
        this.bin,
        this.country,
        this.rating,
        this.hobbies,
        this.languages,
        this.gender,
        this.privacyLink,
        this.createdAt,
        this.updatedAt,
        this.qr,
        this.legalFiles,
        this.introVideo,
        this.email,
        this.phone,
        this.address,
        this.profilePicture,
        this.coverPhoto,
        this.profileImageId,
        this.coverImageId,
        this.qrCode,
        this.legalPapers,
        this.introVideoFile,
        this.countFollowers,
        this.countPageRating,
        this.countPageReviews,
        this.relation,
        this.chatRoomId,
        this.proImage,
        this.coverImage,
    });

    factory Store.fromJson(Map<String, dynamic> json) => Store(
        id: json["id"],
        pageType: json["page_type"],
        pageId: json["page_id"],
        userId: json["user_id"],
        name: json["name"],
        bio: json["bio"],
        age: json["age"],
        dob: json["dob"],
        relationId: json["relation_id"],
        categories: json["categories"] == null ? [] : List<String>.from(json["categories"]!.map((x) => x)),
        image: json["image"],
        cover: json["cover"],
        bin: json["bin"],
        country: json["country"],
        rating: json["rating"],
        hobbies: json["hobbies"] == null ? [] : List<dynamic>.from(json["hobbies"]!.map((x) => x)),
        languages: json["languages"] == null ? [] : List<dynamic>.from(json["languages"]!.map((x) => x)),
        gender: json["gender"],
        privacyLink: json["privacy_link"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        qr: json["qr"],
        legalFiles: json["legal_files"],
        introVideo: json["intro_video"],
        email: json["email"],
        phone: json["phone"],
        address: json["address"],
        profilePicture: json["profile_picture"],
        coverPhoto: json["cover_photo"],
        profileImageId: json["profile_image_id"],
        coverImageId: json["cover_image_id"],
        qrCode: json["qr_code"],
        legalPapers: json["legal_papers"] == null ? [] : List<String>.from(json["legal_papers"]!.map((x) => x)),
        introVideoFile: json["intro_video_file"],
        countFollowers: json["count_followers"],
        countPageRating: json["count_page_rating"],
        countPageReviews: json["count_page_reviews"],
        relation: json["relation"],
        chatRoomId: json["chat_room_id"],
        proImage: json["pro_image"] == null ? null : Image.fromJson(json["pro_image"]),
        coverImage: json["cover_image"] == null ? null : Image.fromJson(json["cover_image"]),
    );
}

// class Image {
//     int? id;
//     int? userId;
//     dynamic postId;
//     String? fileType;
//     int? imageAlbumId;
//     dynamic imageType;
//     String? storageType;
//     dynamic mimeType;
//     String? title;
//     String? storagePath;
//     String? path;
//     int? filesize;
//     dynamic description;
//     dynamic imageTakenTime;
//     dynamic imageTakenLocation;
//     int? countView;
//     int? countShare;
//     int? countComment;
//     int? countStar;
//     dynamic countReactions;
//     DateTime? createdAt;
//     DateTime? updatedAt;
//     String? fullPath;
//     List<dynamic>? taggedFriends;
//     List<String>? reactingPersons;
//     int? totalViewCount;
//     dynamic myReaction;

//     Image({
//         this.id,
//         this.userId,
//         this.postId,
//         this.fileType,
//         this.imageAlbumId,
//         this.imageType,
//         this.storageType,
//         this.mimeType,
//         this.title,
//         this.storagePath,
//         this.path,
//         this.filesize,
//         this.description,
//         this.imageTakenTime,
//         this.imageTakenLocation,
//         this.countView,
//         this.countShare,
//         this.countComment,
//         this.countStar,
//         this.countReactions,
//         this.createdAt,
//         this.updatedAt,
//         this.fullPath,
//         this.taggedFriends,
//         this.reactingPersons,
//         this.totalViewCount,
//         this.myReaction,
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
//         createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
//         fullPath: json["full_path"],
//         taggedFriends: json["tagged_friends"] == null ? [] : List<dynamic>.from(json["tagged_friends"]!.map((x) => x)),
//         reactingPersons: json["reacting_persons"] == null ? [] : List<String>.from(json["reacting_persons"]!.map((x) => x)),
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
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//         "full_path": fullPath,
//         "tagged_friends": taggedFriends == null ? [] : List<dynamic>.from(taggedFriends!.map((x) => x)),
//         "reacting_persons": reactingPersons == null ? [] : List<dynamic>.from(reactingPersons!.map((x) => x)),
//         "total_view_count": totalViewCount,
//         "my_reaction": myReaction,
//     };
// }
