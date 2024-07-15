import 'package:bip_hip/models/home/new_post_list_model.dart';

class ProfileViewPostModel {
    Posts? posts;

    ProfileViewPostModel({
        this.posts,
    });

    factory ProfileViewPostModel.fromJson(Map<String, dynamic> json) => ProfileViewPostModel(
        posts: json["posts"] == null ? null : Posts.fromJson(json["posts"]),
    );
}

// class Posts {
//     int? currentPage;
//     List<Datum>? data;
//     String? firstPageUrl;
//     int? from;
//     int? lastPage;
//     String? lastPageUrl;
//     List<Link>? links;
//     String? nextPageUrl;
//     String? path;
//     int? perPage;
//     dynamic prevPageUrl;
//     int? to;
//     int? total;

//     Posts({
//         this.currentPage,
//         this.data,
//         this.firstPageUrl,
//         this.from,
//         this.lastPage,
//         this.lastPageUrl,
//         this.links,
//         this.nextPageUrl,
//         this.path,
//         this.perPage,
//         this.prevPageUrl,
//         this.to,
//         this.total,
//     });

//     factory Posts.fromJson(Map<String, dynamic> json) => Posts(
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
//     );

//     Map<String, dynamic> toJson() => {
//         "current_page": currentPage,
//         "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
//         "first_page_url": firstPageUrl,
//         "from": from,
//         "last_page": lastPage,
//         "last_page_url": lastPageUrl,
//         "links": links == null ? [] : List<dynamic>.from(links!.map((x) => x.toJson())),
//         "next_page_url": nextPageUrl,
//         "path": path,
//         "per_page": perPage,
//         "prev_page_url": prevPageUrl,
//         "to": to,
//         "total": total,
//     };
// }

// class Datum {
//     int? id;
//     int? userId;
//     int? isSharePost;
//     dynamic sharePostId;
//     String? content;
//     dynamic location;
//     dynamic sellPostType;
//     dynamic sellPostCategoryId;
//     dynamic sellPostConditionId;
//     dynamic price;
//     dynamic discount;
//     dynamic description;
//     dynamic sellPostAvailabilty;
//     dynamic productTags;
//     dynamic sku;
//     int? isHideFnf;
//     dynamic platform;
//     dynamic action;
//     int? isBidding;
//     dynamic biddingPostType;
//     dynamic desireAmount;
//     dynamic minBiddingAmount;
//     dynamic biddingDuration;
//     dynamic title;
//     DateTime? dateTime;
//     DateTime? createdAt;
//     DateTime? updatedAt;
//     int? postCategoryId;
//     int? isPublic;
//     int? countView;
//     int? countShare;
//     int? countComment;
//     int? countStar;
//     dynamic countReactions;
//     dynamic postSubCategoryId;
//     dynamic timelineId;
//     dynamic type;
//     int? kidId;
//     dynamic storeId;
//     dynamic reviewRating;
//     dynamic imageAlbumId;
//     List<dynamic>? taggedFriends;
//     int? countBids;
//     dynamic myReaction;
//     List<dynamic>? reactionUsers;
//     List<dynamic>? viewers;
//     bool? hasReport;
//     bool? myReport;
//     bool? isNotifaction;
//     bool? isVisibleToMe;
//     int? countReaction;
//     User? user;
//     dynamic timeline;
//     PostCategory? postCategory;
//     dynamic postSubCategory;
//     List<dynamic>? postTags;
//     List<dynamic>? images;
//     List<dynamic>? comments;

//     Datum({
//         this.id,
//         this.userId,
//         this.isSharePost,
//         this.sharePostId,
//         this.content,
//         this.location,
//         this.sellPostType,
//         this.sellPostCategoryId,
//         this.sellPostConditionId,
//         this.price,
//         this.discount,
//         this.description,
//         this.sellPostAvailabilty,
//         this.productTags,
//         this.sku,
//         this.isHideFnf,
//         this.platform,
//         this.action,
//         this.isBidding,
//         this.biddingPostType,
//         this.desireAmount,
//         this.minBiddingAmount,
//         this.biddingDuration,
//         this.title,
//         this.dateTime,
//         this.createdAt,
//         this.updatedAt,
//         this.postCategoryId,
//         this.isPublic,
//         this.countView,
//         this.countShare,
//         this.countComment,
//         this.countStar,
//         this.countReactions,
//         this.postSubCategoryId,
//         this.timelineId,
//         this.type,
//         this.kidId,
//         this.storeId,
//         this.reviewRating,
//         this.imageAlbumId,
//         this.taggedFriends,
//         this.countBids,
//         this.myReaction,
//         this.reactionUsers,
//         this.viewers,
//         this.hasReport,
//         this.myReport,
//         this.isNotifaction,
//         this.isVisibleToMe,
//         this.countReaction,
//         this.user,
//         this.timeline,
//         this.postCategory,
//         this.postSubCategory,
//         this.postTags,
//         this.images,
//         this.comments,
//     });

//     factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
//         countReactions: json["count_reactions"],
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
//         timeline: json["timeline"],
//         postCategory: json["post_category"] == null ? null : PostCategory.fromJson(json["post_category"]),
//         postSubCategory: json["post_sub_category"],
//         postTags: json["post_tags"] == null ? [] : List<dynamic>.from(json["post_tags"]!.map((x) => x)),
//         images: json["images"] == null ? [] : List<dynamic>.from(json["images"]!.map((x) => x)),
//         comments: json["comments"] == null ? [] : List<dynamic>.from(json["comments"]!.map((x) => x)),
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "user_id": userId,
//         "is_share_post": isSharePost,
//         "share_post_id": sharePostId,
//         "content": content,
//         "location": location,
//         "sell_post_type": sellPostType,
//         "sell_post_category_id": sellPostCategoryId,
//         "sell_post_condition_id": sellPostConditionId,
//         "price": price,
//         "discount": discount,
//         "description": description,
//         "sell_post_availabilty": sellPostAvailabilty,
//         "product_tags": productTags,
//         "sku": sku,
//         "is_hide_fnf": isHideFnf,
//         "platform": platform,
//         "action": action,
//         "is_bidding": isBidding,
//         "bidding_post_type": biddingPostType,
//         "desire_amount": desireAmount,
//         "min_bidding_amount": minBiddingAmount,
//         "bidding_duration": biddingDuration,
//         "title": title,
//         "date_time": dateTime?.toIso8601String(),
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//         "post_category_id": postCategoryId,
//         "is_public": isPublic,
//         "count_view": countView,
//         "count_share": countShare,
//         "count_comment": countComment,
//         "count_star": countStar,
//         "count_reactions": countReactions,
//         "post_sub_category_id": postSubCategoryId,
//         "timeline_id": timelineId,
//         "type": type,
//         "kid_id": kidId,
//         "store_id": storeId,
//         "review_rating": reviewRating,
//         "image_album_id": imageAlbumId,
//         "tagged_friends": taggedFriends == null ? [] : List<dynamic>.from(taggedFriends!.map((x) => x)),
//         "count_bids": countBids,
//         "my_reaction": myReaction,
//         "reaction_users": reactionUsers == null ? [] : List<dynamic>.from(reactionUsers!.map((x) => x)),
//         "viewers": viewers == null ? [] : List<dynamic>.from(viewers!.map((x) => x)),
//         "has_report": hasReport,
//         "my_report": myReport,
//         "is_notifaction": isNotifaction,
//         "is_visible_to_me": isVisibleToMe,
//         "count_reaction": countReaction,
//         "user": user?.toJson(),
//         "timeline": timeline,
//         "post_category": postCategory?.toJson(),
//         "post_sub_category": postSubCategory,
//         "post_tags": postTags == null ? [] : List<dynamic>.from(postTags!.map((x) => x)),
//         "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
//         "comments": comments == null ? [] : List<dynamic>.from(comments!.map((x) => x)),
//     };
// }

// class PostCategory {
//     int? id;
//     String? slug;
//     String? name;
//     int? isActive;
//     dynamic createdAt;
//     dynamic updatedAt;

//     PostCategory({
//         this.id,
//         this.slug,
//         this.name,
//         this.isActive,
//         this.createdAt,
//         this.updatedAt,
//     });

//     factory PostCategory.fromJson(Map<String, dynamic> json) => PostCategory(
//         id: json["id"],
//         slug: json["slug"],
//         name: json["name"],
//         isActive: json["is_active"],
//         createdAt: json["created_at"],
//         updatedAt: json["updated_at"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "slug": slug,
//         "name": name,
//         "is_active": isActive,
//         "created_at": createdAt,
//         "updated_at": updatedAt,
//     };
// }

// class User {
//     int? id;
//     String? image;
//     String? userName;
//     String? referralCode;
//     String? firstName;
//     String? lastName;
//     String? email;
//     DateTime? emailVerifiedAt;
//     dynamic phone;
//     dynamic phoneVerifiedAt;
//     String? gender;
//     DateTime? dob;
//     List<String>? profession;
//     List<String>? interest;
//     String? bio;
//     List<String>? languages;
//     String? status;
//     dynamic blockTill;
//     String? otp;
//     DateTime? createdAt;
//     DateTime? updatedAt;
//     int? refId;
//     String? relation;
//     dynamic relationWithName;
//     dynamic relationWithId;
//     dynamic relationSince;
//     String? cover;
//     dynamic badge;
//     int? starBalance;
//     dynamic socialProvider;
//     String? referralUrl;
//     String? fullName;
//     String? profilePicture;
//     String? coverPhoto;
//     String? currentBadge;
//     int? friendStatus;
//     int? followStatus;
//     dynamic familyRelationStatus;
//     int? mutualFriend;
//     int? yearsOld;
//     dynamic pendent;
//     dynamic chatRoomId;

//     User({
//         this.id,
//         this.image,
//         this.userName,
//         this.referralCode,
//         this.firstName,
//         this.lastName,
//         this.email,
//         this.emailVerifiedAt,
//         this.phone,
//         this.phoneVerifiedAt,
//         this.gender,
//         this.dob,
//         this.profession,
//         this.interest,
//         this.bio,
//         this.languages,
//         this.status,
//         this.blockTill,
//         this.otp,
//         this.createdAt,
//         this.updatedAt,
//         this.refId,
//         this.relation,
//         this.relationWithName,
//         this.relationWithId,
//         this.relationSince,
//         this.cover,
//         this.badge,
//         this.starBalance,
//         this.socialProvider,
//         this.referralUrl,
//         this.fullName,
//         this.profilePicture,
//         this.coverPhoto,
//         this.currentBadge,
//         this.friendStatus,
//         this.followStatus,
//         this.familyRelationStatus,
//         this.mutualFriend,
//         this.yearsOld,
//         this.pendent,
//         this.chatRoomId,
//     });

//     factory User.fromJson(Map<String, dynamic> json) => User(
//         id: json["id"],
//         image: json["image"],
//         userName: json["user_name"],
//         referralCode: json["referral_code"],
//         firstName: json["first_name"],
//         lastName: json["last_name"],
//         email: json["email"],
//         emailVerifiedAt: json["email_verified_at"] == null ? null : DateTime.parse(json["email_verified_at"]),
//         phone: json["phone"],
//         phoneVerifiedAt: json["phone_verified_at"],
//         gender: json["gender"],
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
//         relationSince: json["relation_since"],
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
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "image": image,
//         "user_name": userName,
//         "referral_code": referralCode,
//         "first_name": firstName,
//         "last_name": lastName,
//         "email": email,
//         "email_verified_at": emailVerifiedAt?.toIso8601String(),
//         "phone": phone,
//         "phone_verified_at": phoneVerifiedAt,
//         "gender": gender,
//         "dob": "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
//         "profession": profession == null ? [] : List<dynamic>.from(profession!.map((x) => x)),
//         "interest": interest == null ? [] : List<dynamic>.from(interest!.map((x) => x)),
//         "bio": bio,
//         "languages": languages == null ? [] : List<dynamic>.from(languages!.map((x) => x)),
//         "status": status,
//         "block_till": blockTill,
//         "otp": otp,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//         "ref_id": refId,
//         "relation": relation,
//         "relation_with_name": relationWithName,
//         "relation_with_id": relationWithId,
//         "relation_since": relationSince,
//         "cover": cover,
//         "badge": badge,
//         "star_balance": starBalance,
//         "social_provider": socialProvider,
//         "referral_url": referralUrl,
//         "full_name": fullName,
//         "profile_picture": profilePicture,
//         "cover_photo": coverPhoto,
//         "current_badge": currentBadge,
//         "friend_status": friendStatus,
//         "follow_status": followStatus,
//         "family_relation_status": familyRelationStatus,
//         "mutual_friend": mutualFriend,
//         "years_old": yearsOld,
//         "pendent": pendent,
//         "chat_room_id": chatRoomId,
//     };
// }

// class Link {
//     String? url;
//     String? label;
//     bool? active;

//     Link({
//         this.url,
//         this.label,
//         this.active,
//     });

//     factory Link.fromJson(Map<String, dynamic> json) => Link(
//         url: json["url"],
//         label: json["label"],
//         active: json["active"],
//     );

//     Map<String, dynamic> toJson() => {
//         "url": url,
//         "label": label,
//         "active": active,
//     };
// }
