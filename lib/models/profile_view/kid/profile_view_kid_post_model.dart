// class ProfileViewKidPostModel {
//   Posts? posts;

//   ProfileViewKidPostModel({
//     this.posts,
//   });

//   factory ProfileViewKidPostModel.fromJson(Map<String, dynamic> json) => ProfileViewKidPostModel(
//         posts: json["posts"] == null ? null : Posts.fromJson(json["posts"]),
//       );
// }

// class Posts {
//   int? currentPage;
//   List<Datum>? data;
//   String? firstPageUrl;
//   int? from;
//   int? lastPage;
//   String? lastPageUrl;
//   List<Link>? links;
//   String? nextPageUrl;
//   String? path;
//   int? perPage;
//   dynamic prevPageUrl;
//   int? to;
//   int? total;

//   Posts({
//     this.currentPage,
//     this.data,
//     this.firstPageUrl,
//     this.from,
//     this.lastPage,
//     this.lastPageUrl,
//     this.links,
//     this.nextPageUrl,
//     this.path,
//     this.perPage,
//     this.prevPageUrl,
//     this.to,
//     this.total,
//   });

//   factory Posts.fromJson(Map<String, dynamic> json) => Posts(
//         currentPage: json["current_page"],
//         data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
//         firstPageUrl: json["first_page_url"],
//         from: json["from"],
//         lastPage: json["last_page"],
//         lastPageUrl: json["last_page_url"],
//         links: json["links"] == null ? [] : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
//         nextPageUrl: json["next_page_url"],
//         path: json["path"],
//         perPage: json["per_page"],
//         prevPageUrl: json["prev_page_url"],
//         to: json["to"],
//         total: json["total"],
//       );
// }

// class Datum {
//   int? id;
//   int? userId;
//   int? isSharePost;
//   int? sharePostId;
//   String? content;
//   String? location;
//   dynamic sellPostType;
//   dynamic sellPostCategoryId;
//   dynamic sellPostConditionId;
//   dynamic price;
//   dynamic discount;
//   dynamic description;
//   dynamic sellPostAvailabilty;
//   dynamic productTags;
//   dynamic sku;
//   int? isHideFnf;
//   dynamic platform;
//   dynamic action;
//   int? isBidding;
//   dynamic biddingPostType;
//   dynamic desireAmount;
//   dynamic minBiddingAmount;
//   dynamic biddingDuration;
//   dynamic title;
//   DateTime? dateTime;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   int? postCategoryId;
//   int? isPublic;
//   int? countView;
//   int? countShare;
//   int? countComment;
//   int? countStar;
//   CountReactions? countReactions;
//   int? postSubCategoryId;
//   dynamic timelineId;
//   int? type;
//   int? kidId;
//   dynamic storeId;
//   dynamic reviewRating;
//   dynamic imageAlbumId;
//   List<dynamic>? taggedFriends;
//   int? countBids;
//   dynamic myReaction;
//   List<dynamic>? reactionUsers;
//   List<dynamic>? viewers;
//   bool? hasReport;
//   bool? myReport;
//   bool? isNotifaction;
//   bool? isVisibleToMe;
//   int? countReaction;
//   User? user;
//   Kid? kid;
//   dynamic timeline;
//   PostCategory? postCategory;
//   PostCategory? postSubCategory;
//   List<dynamic>? postTags;
//   List<Image>? images;
//   List<dynamic>? comments;

//   Datum({
//     this.id,
//     this.userId,
//     this.isSharePost,
//     this.sharePostId,
//     this.content,
//     this.location,
//     this.sellPostType,
//     this.sellPostCategoryId,
//     this.sellPostConditionId,
//     this.price,
//     this.discount,
//     this.description,
//     this.sellPostAvailabilty,
//     this.productTags,
//     this.sku,
//     this.isHideFnf,
//     this.platform,
//     this.action,
//     this.isBidding,
//     this.biddingPostType,
//     this.desireAmount,
//     this.minBiddingAmount,
//     this.biddingDuration,
//     this.title,
//     this.dateTime,
//     this.createdAt,
//     this.updatedAt,
//     this.postCategoryId,
//     this.isPublic,
//     this.countView,
//     this.countShare,
//     this.countComment,
//     this.countStar,
//     this.countReactions,
//     this.postSubCategoryId,
//     this.timelineId,
//     this.type,
//     this.kidId,
//     this.storeId,
//     this.reviewRating,
//     this.imageAlbumId,
//     this.taggedFriends,
//     this.countBids,
//     this.myReaction,
//     this.reactionUsers,
//     this.viewers,
//     this.hasReport,
//     this.myReport,
//     this.isNotifaction,
//     this.isVisibleToMe,
//     this.countReaction,
//     this.user,
//     this.kid,
//     this.timeline,
//     this.postCategory,
//     this.postSubCategory,
//     this.postTags,
//     this.images,
//     this.comments,
//   });

//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//         id: json["id"],
//         userId: json["user_id"],
//         isSharePost: json["is_share_post"],
//         sharePostId: json["share_post_id"],
//         content: json["content"],
//         location: json["location"],
//         sellPostType: json["sell_post_type"],
//         sellPostCategoryId: json["sell_post_category_id"],
//         sellPostConditionId: json["sell_post_condition_id"],
//         price: json["price"],
//         discount: json["discount"],
//         description: json["description"],
//         sellPostAvailabilty: json["sell_post_availabilty"],
//         productTags: json["product_tags"],
//         sku: json["sku"],
//         isHideFnf: json["is_hide_fnf"],
//         platform: json["platform"],
//         action: json["action"],
//         isBidding: json["is_bidding"],
//         biddingPostType: json["bidding_post_type"],
//         desireAmount: json["desire_amount"],
//         minBiddingAmount: json["min_bidding_amount"],
//         biddingDuration: json["bidding_duration"],
//         title: json["title"],
//         dateTime: json["date_time"] == null ? null : DateTime.parse(json["date_time"]),
//         createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
//         postCategoryId: json["post_category_id"],
//         isPublic: json["is_public"],
//         countView: json["count_view"],
//         countShare: json["count_share"],
//         countComment: json["count_comment"],
//         countStar: json["count_star"],
//         countReactions: json["count_reactions"] == null ? null : CountReactions.fromJson(json["count_reactions"]),
//         postSubCategoryId: json["post_sub_category_id"],
//         timelineId: json["timeline_id"],
//         type: json["type"],
//         kidId: json["kid_id"],
//         storeId: json["store_id"],
//         reviewRating: json["review_rating"],
//         imageAlbumId: json["image_album_id"],
//         taggedFriends: json["tagged_friends"] == null ? [] : List<dynamic>.from(json["tagged_friends"]!.map((x) => x)),
//         countBids: json["count_bids"],
//         myReaction: json["my_reaction"],
//         reactionUsers: json["reaction_users"] == null ? [] : List<dynamic>.from(json["reaction_users"]!.map((x) => x)),
//         viewers: json["viewers"] == null ? [] : List<dynamic>.from(json["viewers"]!.map((x) => x)),
//         hasReport: json["has_report"],
//         myReport: json["my_report"],
//         isNotifaction: json["is_notifaction"],
//         isVisibleToMe: json["is_visible_to_me"],
//         countReaction: json["count_reaction"],
//         user: json["user"] == null ? null : User.fromJson(json["user"]),
//         kid: json["kid"] == null ? null : Kid.fromJson(json["kid"]),
//         timeline: json["timeline"],
//         postCategory: json["post_category"] == null ? null : PostCategory.fromJson(json["post_category"]),
//         postSubCategory: json["post_sub_category"] == null ? null : PostCategory.fromJson(json["post_sub_category"]),
//         postTags: json["post_tags"] == null ? [] : List<dynamic>.from(json["post_tags"]!.map((x) => x)),
//         images: json["images"] == null ? [] : List<Image>.from(json["images"]!.map((x) => Image.fromJson(x))),
//         comments: json["comments"] == null ? [] : List<dynamic>.from(json["comments"]!.map((x) => x)),
//       );
// }

// class CountReactions {
//   int? all;
//   int? haha;
//   int? like;
//   int? love;
//   int? sad;
//   int? wow;

//   CountReactions({
//     this.all,
//     this.haha,
//     this.like,
//     this.love,
//     this.sad,
//     this.wow,
//   });

//   factory CountReactions.fromJson(Map<String, dynamic> json) => CountReactions(
//         all: json["All"],
//         haha: json["haha"],
//         like: json["like"],
//         love: json["love"],
//         sad: json["sad"],
//         wow: json["wow"],
//       );
// }

// class Image {
//   int? id;
//   int? userId;
//   int? postId;
//   String? fileType;
//   dynamic imageAlbumId;
//   dynamic imageType;
//   String? storageType;
//   dynamic mimeType;
//   String? title;
//   String? storagePath;
//   String? path;
//   int? filesize;
//   String? description;
//   DateTime? imageTakenTime;
//   String? imageTakenLocation;
//   int? countView;
//   int? countShare;
//   int? countComment;
//   int? countStar;
//   dynamic countReactions;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   String? fullPath;
//   List<TaggedFriend>? taggedFriends;
//   List<String>? reactingPersons;
//   int? totalViewCount;
//   dynamic myReaction;

//   Image({
//     this.id,
//     this.userId,
//     this.postId,
//     this.fileType,
//     this.imageAlbumId,
//     this.imageType,
//     this.storageType,
//     this.mimeType,
//     this.title,
//     this.storagePath,
//     this.path,
//     this.filesize,
//     this.description,
//     this.imageTakenTime,
//     this.imageTakenLocation,
//     this.countView,
//     this.countShare,
//     this.countComment,
//     this.countStar,
//     this.countReactions,
//     this.createdAt,
//     this.updatedAt,
//     this.fullPath,
//     this.taggedFriends,
//     this.reactingPersons,
//     this.totalViewCount,
//     this.myReaction,
//   });

//   factory Image.fromJson(Map<String, dynamic> json) => Image(
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
//         imageTakenTime: json["image_taken_time"] == null ? null : DateTime.parse(json["image_taken_time"]),
//         imageTakenLocation: json["image_taken_location"],
//         countView: json["count_view"],
//         countShare: json["count_share"],
//         countComment: json["count_comment"],
//         countStar: json["count_star"],
//         countReactions: json["count_reactions"],
//         createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
//         fullPath: json["full_path"],
//         taggedFriends: json["tagged_friends"] == null ? [] : List<TaggedFriend>.from(json["tagged_friends"]!.map((x) => TaggedFriend.fromJson(x))),
//         reactingPersons: json["reacting_persons"] == null ? [] : List<String>.from(json["reacting_persons"]!.map((x) => x)),
//         totalViewCount: json["total_view_count"],
//         myReaction: json["my_reaction"],
//       );
// }

// class TaggedFriend {
//   int? id;
//   String? firstName;
//   String? lastName;
//   dynamic image;
//   String? referralUrl;
//   String? fullName;
//   dynamic profilePicture;
//   dynamic coverPhoto;
//   String? currentBadge;
//   int? friendStatus;
//   int? followStatus;
//   dynamic familyRelationStatus;
//   int? mutualFriend;
//   dynamic yearsOld;
//   dynamic pendent;
//   dynamic chatRoomId;

//   TaggedFriend({
//     this.id,
//     this.firstName,
//     this.lastName,
//     this.image,
//     this.referralUrl,
//     this.fullName,
//     this.profilePicture,
//     this.coverPhoto,
//     this.currentBadge,
//     this.friendStatus,
//     this.followStatus,
//     this.familyRelationStatus,
//     this.mutualFriend,
//     this.yearsOld,
//     this.pendent,
//     this.chatRoomId,
//   });

//   factory TaggedFriend.fromJson(Map<String, dynamic> json) => TaggedFriend(
//         id: json["id"],
//         firstName: json["first_name"],
//         lastName: json["last_name"],
//         image: json["image"],
//         referralUrl: json["referral_url"],
//         fullName: json["full_name"],
//         profilePicture: json["profile_picture"],
//         coverPhoto: json["cover_photo"],
//         currentBadge: json["current_badge"],
//         friendStatus: json["friend_status"],
//         followStatus: json["follow_status"],
//         familyRelationStatus: json["family_relation_status"],
//         mutualFriend: json["mutual_friend"],
//         yearsOld: json["years_old"],
//         pendent: json["pendent"],
//         chatRoomId: json["chat_room_id"],
//       );
// }

// class Kid {
//   int? id;
//   String? pageType;
//   String? pageId;
//   int? userId;
//   String? name;
//   dynamic bio;
//   int? age;
//   dynamic dob;
//   int? relationId;
//   List<String>? categories;
//   String? image;
//   String? cover;
//   dynamic bin;
//   dynamic country;
//   int? rating;
//   List<String>? hobbies;
//   List<String>? languages;
//   String? gender;
//   List<PrivacyLink>? privacyLink;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   dynamic qr;
//   dynamic legalFiles;
//   dynamic introVideo;
//   dynamic email;
//   dynamic phone;
//   dynamic address;
//   dynamic profilePicture;
//   dynamic coverPhoto;
//   dynamic profileImageId;
//   dynamic coverImageId;
//   dynamic qrCode;
//   dynamic legalPapers;
//   dynamic introVideoFile;
//   int? countFollowers;
//   int? countPageRating;
//   int? countPageReviews;
//   String? relation;
//   dynamic chatRoomId;
//   dynamic proImage;
//   dynamic coverImage;

//   Kid({
//     this.id,
//     this.pageType,
//     this.pageId,
//     this.userId,
//     this.name,
//     this.bio,
//     this.age,
//     this.dob,
//     this.relationId,
//     this.categories,
//     this.image,
//     this.cover,
//     this.bin,
//     this.country,
//     this.rating,
//     this.hobbies,
//     this.languages,
//     this.gender,
//     this.privacyLink,
//     this.createdAt,
//     this.updatedAt,
//     this.qr,
//     this.legalFiles,
//     this.introVideo,
//     this.email,
//     this.phone,
//     this.address,
//     this.profilePicture,
//     this.coverPhoto,
//     this.profileImageId,
//     this.coverImageId,
//     this.qrCode,
//     this.legalPapers,
//     this.introVideoFile,
//     this.countFollowers,
//     this.countPageRating,
//     this.countPageReviews,
//     this.relation,
//     this.chatRoomId,
//     this.proImage,
//     this.coverImage,
//   });

//   factory Kid.fromJson(Map<String, dynamic> json) => Kid(
//         id: json["id"],
//         pageType: json["page_type"],
//         pageId: json["page_id"],
//         userId: json["user_id"],
//         name: json["name"],
//         bio: json["bio"],
//         age: json["age"],
//         dob: json["dob"],
//         relationId: json["relation_id"],
//         categories: json["categories"] == null ? [] : List<String>.from(json["categories"]!.map((x) => x)),
//         image: json["image"],
//         cover: json["cover"],
//         bin: json["bin"],
//         country: json["country"],
//         rating: json["rating"],
//         hobbies: json["hobbies"] == null ? [] : List<String>.from(json["hobbies"]!.map((x) => x)),
//         languages: json["languages"] == null ? [] : List<String>.from(json["languages"]!.map((x) => languageValues.map[x]!)),
//         gender: genderValues.map[json["gender"]]!,
//         privacyLink: json["privacy_link"] == null ? [] : List<PrivacyLink>.from(json["privacy_link"]!.map((x) => PrivacyLink.fromJson(x))),
//         createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
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
//         relation: relationValues.map[json["relation"]]!,
//         chatRoomId: json["chat_room_id"],
//         proImage: json["pro_image"],
//         coverImage: json["cover_image"],
//       );
// }

// class PrivacyLink {
//   String? facebook;
//   String? twitter;

//   PrivacyLink({
//     this.facebook,
//     this.twitter,
//   });

//   factory PrivacyLink.fromJson(Map<String, dynamic> json) => PrivacyLink(
//         facebook: json["Facebook"],
//         twitter: json["Twitter"],
//       );
// }

// class PostCategory {
//   int? id;
//   String? name;
//   int? isActive;
//   dynamic createdAt;
//   dynamic updatedAt;
//   int? postCategoryId;

//   PostCategory({
//     this.id,
//     this.name,
//     this.isActive,
//     this.createdAt,
//     this.updatedAt,
//     this.postCategoryId,
//   });

//   factory PostCategory.fromJson(Map<String, dynamic> json) => PostCategory(
//         id: json["id"],
//         name: json["name"],
//         isActive: json["is_active"],
//         createdAt: json["created_at"],
//         updatedAt: json["updated_at"],
//         postCategoryId: json["post_category_id"],
//       );
// }

// class User {
//   int? id;
//   String? image;
//   String? userName;
//   String? referralCode;
//   String? firstName;
//   String? lastName;
//   String? email;
//   DateTime? emailVerifiedAt;
//   String? phone;
//   DateTime? phoneVerifiedAt;
//   Gender? gender;
//   DateTime? dob;
//   List<String>? profession;
//   List<String>? interest;
//   String? bio;
//   List<String>? languages;
//   String? status;
//   dynamic blockTill;
//   dynamic otp;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   int? refId;
//   String? relation;
//   String? relationWithName;
//   int? relationWithId;
//   DateTime? relationSince;
//   String? cover;
//   dynamic badge;
//   int? starBalance;
//   dynamic socialProvider;
//   String? referralUrl;
//   String? fullName;
//   String? profilePicture;
//   String? coverPhoto;
//   String? currentBadge;
//   int? friendStatus;
//   int? followStatus;
//   dynamic familyRelationStatus;
//   int? mutualFriend;
//   int? yearsOld;
//   dynamic pendent;
//   dynamic chatRoomId;

//   User({
//     this.id,
//     this.image,
//     this.userName,
//     this.referralCode,
//     this.firstName,
//     this.lastName,
//     this.email,
//     this.emailVerifiedAt,
//     this.phone,
//     this.phoneVerifiedAt,
//     this.gender,
//     this.dob,
//     this.profession,
//     this.interest,
//     this.bio,
//     this.languages,
//     this.status,
//     this.blockTill,
//     this.otp,
//     this.createdAt,
//     this.updatedAt,
//     this.refId,
//     this.relation,
//     this.relationWithName,
//     this.relationWithId,
//     this.relationSince,
//     this.cover,
//     this.badge,
//     this.starBalance,
//     this.socialProvider,
//     this.referralUrl,
//     this.fullName,
//     this.profilePicture,
//     this.coverPhoto,
//     this.currentBadge,
//     this.friendStatus,
//     this.followStatus,
//     this.familyRelationStatus,
//     this.mutualFriend,
//     this.yearsOld,
//     this.pendent,
//     this.chatRoomId,
//   });

//   factory User.fromJson(Map<String, dynamic> json) => User(
//         id: json["id"],
//         image: json["image"],
//         userName: json["user_name"],
//         referralCode: json["referral_code"],
//         firstName: json["first_name"],
//         lastName: json["last_name"],
//         email: json["email"],
//         emailVerifiedAt: json["email_verified_at"] == null ? null : DateTime.parse(json["email_verified_at"]),
//         phone: json["phone"],
//         phoneVerifiedAt: json["phone_verified_at"] == null ? null : DateTime.parse(json["phone_verified_at"]),
//         gender: genderValues.map[json["gender"]]!,
//         dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
//         profession: json["profession"] == null ? [] : List<String>.from(json["profession"]!.map((x) => x)),
//         interest: json["interest"] == null ? [] : List<String>.from(json["interest"]!.map((x) => x)),
//         bio: json["bio"],
//         languages: json["languages"] == null ? [] : List<String>.from(json["languages"]!.map((x) => x)),
//         status: json["status"],
//         blockTill: json["block_till"],
//         otp: json["otp"],
//         createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
//         refId: json["ref_id"],
//         relation: json["relation"],
//         relationWithName: json["relation_with_name"],
//         relationWithId: json["relation_with_id"],
//         relationSince: json["relation_since"] == null ? null : DateTime.parse(json["relation_since"]),
//         cover: json["cover"],
//         badge: json["badge"],
//         starBalance: json["star_balance"],
//         socialProvider: json["social_provider"],
//         referralUrl: json["referral_url"],
//         fullName: json["full_name"],
//         profilePicture: json["profile_picture"],
//         coverPhoto: json["cover_photo"],
//         currentBadge: json["current_badge"],
//         friendStatus: json["friend_status"],
//         followStatus: json["follow_status"],
//         familyRelationStatus: json["family_relation_status"],
//         mutualFriend: json["mutual_friend"],
//         yearsOld: json["years_old"],
//         pendent: json["pendent"],
//         chatRoomId: json["chat_room_id"],
//       );
// }

// class Link {
//   String? url;
//   String? label;
//   bool? active;

//   Link({
//     this.url,
//     this.label,
//     this.active,
//   });

//   factory Link.fromJson(Map<String, dynamic> json) => Link(
//         url: json["url"],
//         label: json["label"],
//         active: json["active"],
//       );
// }

// // class EnumValues<T> {
// //     Map<String, T> map;
// //     late Map<T, String> reverseMap;

// //     EnumValues(this.map);

// //     Map<T, String> get reverse {
// //             reverseMap = map.map((k, v) => MapEntry(v, k));
// //             return reverseMap;
// //     }
// // }
