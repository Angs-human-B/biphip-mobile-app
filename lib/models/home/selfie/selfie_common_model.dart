
class SelfieCommonModel {
    List<Selfy> mySelfies;
    FriendSelfies? friendSelfies;

    SelfieCommonModel({
        required this.mySelfies,
        required this.friendSelfies,
    });

    factory SelfieCommonModel.fromJson(Map<String, dynamic> json) => SelfieCommonModel(
        mySelfies: List<Selfy>.from(json["my_selfies"].map((x) => Selfy.fromJson(x))),
        friendSelfies: json["friend_selfies"]==null ? null : FriendSelfies.fromJson(json["friend_selfies"]),
    );
}

class FriendSelfies {
    int? currentPage;
    List<FriendSelfieData> data;
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

    FriendSelfies({
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

    factory FriendSelfies.fromJson(Map<String, dynamic> json) => FriendSelfies(
        currentPage: json["current_page"],
        data: List<FriendSelfieData>.from(json["data"].map((x) => FriendSelfieData.fromJson(x))),
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

class FriendSelfieData {
    int? id;
    String? image;
    String? userName;
    String? firstName;
    String? lastName;
    String? email;
    dynamic phone;
    String ?gender;
    DateTime? dob;
    List<String> profession;
    List<String> interest;
    String ?bio;
    List<String> languages;
    String ?status;
    int? refId;
    String? relation;
    dynamic relationWithName;
    dynamic relationWithId;
    dynamic relationSince;
    String? cover;
    dynamic badge;
    int? starBalance;
    dynamic socialProvider;
    String? referralUrl;
    String? fullName;
    String? profilePicture;
    String? coverPhoto;
    String? currentBadge;
    int? friendStatus;
    int? followStatus;
    int? mutualFriend;
    int? yearsOld;
    dynamic pendent;
    dynamic chatRoomId;
    List<Selfy> currentSelfies;

    FriendSelfieData({
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
        required this.refId,
        required this.relation,
        required this.relationWithName,
        required this.relationWithId,
        required this.relationSince,
        required this.cover,
        required this.badge,
        required this.starBalance,
        required this.socialProvider,
        required this.referralUrl,
        required this.fullName,
        required this.profilePicture,
        required this.coverPhoto,
        required this.currentBadge,
        required this.friendStatus,
        required this.followStatus,
        required this.mutualFriend,
        required this.yearsOld,
        required this.pendent,
        required this.chatRoomId,
        required this.currentSelfies,
    });

    factory FriendSelfieData.fromJson(Map<String, dynamic> json) => FriendSelfieData(
        id: json["id"],
        image: json["image"],
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
        languages: List<String>.from(json["languages"].map((x) => x)),
        status: json["status"],
        refId: json["ref_id"],
        relation: json["relation"],
        relationWithName: json["relation_with_name"],
        relationWithId: json["relation_with_id"],
        relationSince: json["relation_since"],
        cover: json["cover"],
        badge: json["badge"],
        starBalance: json["star_balance"],
        socialProvider: json["social_provider"],
        referralUrl: json["referral_url"],
        fullName: json["full_name"],
        profilePicture: json["profile_picture"],
        coverPhoto: json["cover_photo"],
        currentBadge: json["current_badge"],
        friendStatus: json["friend_status"],
        followStatus: json["follow_status"],
        mutualFriend: json["mutual_friend"],
        yearsOld: json["years_old"],
        pendent: json["pendent"],
        chatRoomId: json["chat_room_id"],
        currentSelfies: List<Selfy>.from(json["current_selfies"].map((x) => Selfy.fromJson(x))),
    );}

class Selfy {
    int? id;
    int? userId;
    int? fileType;
    int? storageType;
    String? title;
    String? storagePath;
    String? path;
    int? privacy;
    dynamic visibleUserIds;
    String? fullPath;
    int? countViews;
    List<dynamic> viewerImages;
    List<dynamic> myReactions;
    int? countStars;
    int? countMyStars;
    List<SelfieText> selfieTexts;

    Selfy({
        required this.id,
        required this.userId,
        required this.fileType,
        required this.storageType,
        required this.title,
        required this.storagePath,
        required this.path,
        required this.privacy,
        required this.visibleUserIds,
        required this.fullPath,
        required this.countViews,
        required this.viewerImages,
        required this.myReactions,
        required this.countStars,
        required this.countMyStars,
        required this.selfieTexts,
    });

    factory Selfy.fromJson(Map<String, dynamic> json) => Selfy(
        id: json["id"],
        userId: json["user_id"],
        fileType: json["file_type"],
        storageType: json["storage_type"],
        title: json["title"],
        storagePath: json["storage_path"],
        path: json["path"],
        privacy: json["privacy"],
        visibleUserIds: json["visible_user_ids"],
        fullPath: json["full_path"],
        countViews: json["count_views"],
        viewerImages: List<dynamic>.from(json["viewer_images"].map((x) => x)),
        myReactions: List<dynamic>.from(json["my_reactions"].map((x) => x)),
        countStars: json["count_stars"],
        countMyStars: json["count_my_stars"],
        selfieTexts: List<SelfieText>.from(json["selfie_texts"].map((x) => SelfieText.fromJson(x))),
    );
}

class SelfieText {
    int? id;
    int? selfieId;
    String? text;
    String? style;
    String? color;
    String? positionX;
    String? positionY;

    SelfieText({
        required this.id,
        required this.selfieId,
        required this.text,
        required this.style,
        required this.color,
        required this.positionX,
        required this.positionY,
    });

    factory SelfieText.fromJson(Map<String, dynamic> json) => SelfieText(
        id: json["id"],
        selfieId: json["selfie_id"],
        text: json["text"],
        style: json["style"],
        color: json["color"],
        positionX: json["position_x"],
        positionY: json["position_y"],
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
