import 'package:bip_hip/models/home/postListModel.dart';

class GetKidPostModel {
  Posts posts;

  GetKidPostModel({
    required this.posts,
  });

  factory GetKidPostModel.fromJson(Map<String, dynamic> json) => GetKidPostModel(
        posts: Posts.fromJson(json["posts"]),
      );
}

class Posts {
  int? currentPage;
  List<PostData> data;
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

  Posts({
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

  factory Posts.fromJson(Map<String, dynamic> json) => Posts(
        currentPage: json["current_page"],
        data: List<PostData>.from(json["data"].map((x) => PostData.fromJson(x))),
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

// class RefRelation {
//   KidPostData post;

//   RefRelation({
//     required this.post,
//   });

//   factory RefRelation.fromJson(Map<String, dynamic> json) => RefRelation(
//         post: KidPostData.fromJson(json["post"]),
//       );
// }

// class Comment {
//   int? id;
//   int? userId;
//   dynamic countReactions;
//   String? comment;
//   dynamic mentionUserIds;
//   int? isEdit;
//   dynamic image;
//   int? refType;
//   int? refId;
//   dynamic deletedAt;
//   List<dynamic> mentionUsers;
//   RefRelation? refRelation;
//   dynamic myReaction;
//   int? countReply;
//   bool? hasReport;
//   bool? myReport;
//   int? countStar;
//   List<dynamic> commentReplies;
//   User? user;
//   PostStar? postStar;

//   Comment({
//     required this.id,
//     required this.userId,
//     required this.countReactions,
//     required this.comment,
//     required this.mentionUserIds,
//     required this.isEdit,
//     required this.image,
//     required this.refType,
//     required this.refId,
//     required this.deletedAt,
//     required this.mentionUsers,
//     required this.refRelation,
//     required this.myReaction,
//     required this.countReply,
//     required this.hasReport,
//     required this.myReport,
//     required this.countStar,
//     required this.commentReplies,
//     required this.user,
//     required this.postStar,
//   });

//   factory Comment.fromJson(Map<String, dynamic> json) => Comment(
//         id: json["id"],
//         userId: json["user_id"],
//         countReactions: json["count_reactions"],
//         comment: json["comment"],
//         mentionUserIds: json["mention_user_ids"],
//         isEdit: json["is_edit"],
//         image: json["image"],
//         refType: json["ref_type"],
//         refId: json["ref_id"],
//         deletedAt: json["deleted_at"],
//         mentionUsers: List<dynamic>.from(json["mention_users"].map((x) => x)),
//         refRelation: RefRelation.fromJson(json["ref_relation"]),
//         myReaction: json["my_reaction"],
//         countReply: json["count_reply"],
//         hasReport: json["has_report"],
//         myReport: json["my_report"],
//         countStar: json["count_star"],
//         commentReplies: List<dynamic>.from(json["comment_replies"].map((x) => x)),
//         user: User.fromJson(json["user"]),
//         postStar: PostStar.fromJson(json["post_star"]),
//       );
// }



class PostStar {
  int? id;
  int? postId;
  int? commentId;
  int? userId;
  int? star;

  PostStar({
    required this.id,
    required this.postId,
    required this.commentId,
    required this.userId,
    required this.star,
  });

  factory PostStar.fromJson(Map<String, dynamic> json) => PostStar(
        id: json["id"],
        postId: json["post_id"],
        commentId: json["comment_id"],
        userId: json["user_id"],
        star: json["star"],
      );
}


// class UserPendent {
//     int? id;
//     int? pendentId;
//     int? userId;
//     DateTime? startDate;
//     DateTime? endDate;
//     int? isActive;
//     String? pendentPurchaseHistory;
//     // PendentPendent pendent;

//     UserPendent({
//         required this.id,
//         required this.pendentId,
//         required this.userId,
//         required this.startDate,
//         required this.endDate,
//         required this.isActive,
//         required this.pendentPurchaseHistory,
//         // required this.pendent,
//     });

//     factory UserPendent.fromJson(Map<String, dynamic> json) => UserPendent(
//         id: json["id"],
//         pendentId: json["pendent_id"],
//         userId: json["user_id"],
//         startDate: DateTime.parse(json["start_date"]),
//         endDate: DateTime.parse(json["end_date"]),
//         isActive: json["is_active"],
//         pendentPurchaseHistory: json["pendent_purchase_history"],
//         // pendent: PendentPendent.fromJson(json["pendent"]),
//     );
//   }

// class PendentPendent {
//     int id;
//     String name;
//     String description;
//     String icon;
//     int price;
//     int star;
//     int validityDays;
//     int monthlyRoi;
//     double dailyRoi;
//     int affilate;
//     int giftSendBenefits;
//     int giftReceiveBenefits;
//     int isActive;
//     dynamic createdAt;
//     dynamic updatedAt;

//     PendentPendent({
//         required this.id,
//         required this.name,
//         required this.description,
//         required this.icon,
//         required this.price,
//         required this.star,
//         required this.validityDays,
//         required this.monthlyRoi,
//         required this.dailyRoi,
//         required this.affilate,
//         required this.giftSendBenefits,
//         required this.giftReceiveBenefits,
//         required this.isActive,
//         required this.createdAt,
//         required this.updatedAt,
//     });

//     factory PendentPendent.fromJson(Map<String, dynamic> json) => PendentPendent(
//         id: json["id"],
//         name: json["name"],
//         description: json["description"],
//         icon: json["icon"],
//         price: json["price"],
//         star: json["star"],
//         validityDays: json["validity_days"],
//         monthlyRoi: json["monthly_roi"],
//         dailyRoi: json["daily_roi"]?.toDouble(),
//         affilate: json["affilate"],
//         giftSendBenefits: json["gift_send_benefits"],
//         giftReceiveBenefits: json["gift_receive_benefits"],
//         isActive: json["is_active"],
//         createdAt: json["created_at"],
//         updatedAt: json["updated_at"],
//     );
//     }

class KidsData {
  int? id;
  String? pageType;
  String? pageId;
  int? userId;
  String? name;
  String? bio;
  int? age;
  dynamic dob;
  int? relationId;
  List<String> categories;
  String? image;
  String? cover;
  dynamic bin;
  dynamic country;
  int? rating;
  List<String> hobbies;
  List<String> languages;
  String? gender;
  dynamic privacyLink;
  dynamic qr;
  dynamic legalFiles;
  dynamic introVideo;
  String? email;
  String? phone;
  String? address;
  String? profilePicture;
  String? coverPhoto;
  int? profileImageId;
  int? coverImageId;
  dynamic qrCode;
  dynamic legalPapers;
  dynamic introVideoFile;
  int? countFollowers;
  int? countPageRating;
  int? countPageReviews;
  String? relation;
  Image? proImage;
  Image? coverImage;

  KidsData({
    required this.id,
    required this.pageType,
    required this.pageId,
    required this.userId,
    required this.name,
    required this.bio,
    required this.age,
    required this.dob,
    required this.relationId,
    required this.categories,
    required this.image,
    required this.cover,
    required this.bin,
    required this.country,
    required this.rating,
    required this.hobbies,
    required this.languages,
    required this.gender,
    required this.privacyLink,
    required this.qr,
    required this.legalFiles,
    required this.introVideo,
    required this.email,
    required this.phone,
    required this.address,
    required this.profilePicture,
    required this.coverPhoto,
    required this.profileImageId,
    required this.coverImageId,
    required this.qrCode,
    required this.legalPapers,
    required this.introVideoFile,
    required this.countFollowers,
    required this.countPageRating,
    required this.countPageReviews,
    required this.relation,
    required this.proImage,
    required this.coverImage,
  });

  factory KidsData.fromJson(Map<String, dynamic> json) => KidsData(
        id: json["id"],
        pageType: json["page_type"],
        pageId: json["page_id"],
        userId: json["user_id"],
        name: json["name"],
        bio: json["bio"],
        age: json["age"],
        dob: json["dob"],
        relationId: json["relation_id"],
        categories: List<String>.from(json["categories"].map((x) => x)),
        image: json["image"],
        cover: json["cover"],
        bin: json["bin"],
        country: json["country"],
        rating: json["rating"],
        hobbies: List<String>.from(json["hobbies"].map((x) => x)),
        languages: List<String>.from(json["languages"].map((x) => x)),
        gender: json["gender"],
        privacyLink: json["privacy_link"],
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
        legalPapers: json["legal_papers"],
        introVideoFile: json["intro_video_file"],
        countFollowers: json["count_followers"],
        countPageRating: json["count_page_rating"],
        countPageReviews: json["count_page_reviews"],
        relation: json["relation"],
        proImage: json["pro_image"] == null ? null : Image.fromJson(json["pro_image"]),
        coverImage: json["cover_image"] == null ? null : Image.fromJson(json["cover_image"]),
      );
}

class Image {
  int? id;
  int? userId;
  dynamic postId;
  String? fileType;
  int? imageAlbumId;
  dynamic imageType;
  String? storageType;
  dynamic mimeType;
  String? title;
  String? storagePath;
  String? path;
  int? filesize;
  dynamic description;
  dynamic imageTakenTime;
  dynamic imageTakenLocation;
  int? countView;
  int? countShare;
  int? countComment;
  int? countStar;
  dynamic countReactions;
  String? fullPath;
  List<dynamic> taggedFriends;
  List<String> reactingPersons;
  int? totalViewCount;
  dynamic myReaction;

  Image({
    required this.id,
    required this.userId,
    required this.postId,
    required this.fileType,
    required this.imageAlbumId,
    required this.imageType,
    required this.storageType,
    required this.mimeType,
    required this.title,
    required this.storagePath,
    required this.path,
    required this.filesize,
    required this.description,
    required this.imageTakenTime,
    required this.imageTakenLocation,
    required this.countView,
    required this.countShare,
    required this.countComment,
    required this.countStar,
    required this.countReactions,
    required this.fullPath,
    required this.taggedFriends,
    required this.reactingPersons,
    required this.totalViewCount,
    required this.myReaction,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json["id"],
        userId: json["user_id"],
        postId: json["post_id"],
        fileType: json["file_type"],
        imageAlbumId: json["image_album_id"],
        imageType: json["image_type"],
        storageType: json["storage_type"],
        mimeType: json["mime_type"],
        title: json["title"],
        storagePath: json["storage_path"],
        path: json["path"],
        filesize: json["filesize"],
        description: json["description"],
        imageTakenTime: json["image_taken_time"],
        imageTakenLocation: json["image_taken_location"],
        countView: json["count_view"],
        countShare: json["count_share"],
        countComment: json["count_comment"],
        countStar: json["count_star"],
        countReactions: json["count_reactions"],
        fullPath: json["full_path"],
        taggedFriends: List<dynamic>.from(json["tagged_friends"].map((x) => x)),
        reactingPersons: List<String>.from(json["reacting_persons"].map((x) => x)),
        totalViewCount: json["total_view_count"],
        myReaction: json["my_reaction"],
      );
}

class PostCategory {
  int? id;
  String? name;
  int? isActive;

  PostCategory({
    required this.id,
    required this.name,
    required this.isActive,
  });

  factory PostCategory.fromJson(Map<String, dynamic> json) => PostCategory(
        id: json["id"],
        name: json["name"],
        isActive: json["is_active"],
      );
}

class PostTag {
  int? id;
  int? postId;
  int? userId;
  DateTime? createdAt;
  DateTime? updatedAt;

  PostTag({
    required this.id,
    required this.postId,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PostTag.fromJson(Map<String, dynamic> json) => PostTag(
        id: json["id"],
        postId: json["post_id"],
        userId: json["user_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );
}

class TaggedFriend {
  int? id;
  String? firstName;
  String? lastName;
  String? image;
  String? referralUrl;
  String? fullName;
  String? profilePicture;
  dynamic coverPhoto;
  String? currentBadge;
  int? friendStatus;
  int? followStatus;
  String? familyRelationStatus;
  int? mutualFriend;
  dynamic yearsOld;
  dynamic pendent;

  TaggedFriend({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.image,
    required this.referralUrl,
    required this.fullName,
    required this.profilePicture,
    required this.coverPhoto,
    required this.currentBadge,
    required this.friendStatus,
    required this.followStatus,
    required this.familyRelationStatus,
    required this.mutualFriend,
    required this.yearsOld,
    required this.pendent,
  });

  factory TaggedFriend.fromJson(Map<String, dynamic> json) => TaggedFriend(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        image: json["image"],
        referralUrl: json["referral_url"],
        fullName: json["full_name"],
        profilePicture: json["profile_picture"],
        coverPhoto: json["cover_photo"],
        currentBadge: json["current_badge"],
        friendStatus: json["friend_status"],
        followStatus: json["follow_status"],
        familyRelationStatus: json["family_relation_status"],
        mutualFriend: json["mutual_friend"],
        yearsOld: json["years_old"],
        pendent: json["pendent"],
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
