class ReceivedFriendListModel {
    Users? users;

    ReceivedFriendListModel({
        required this.users,
    });

    factory ReceivedFriendListModel.fromJson(Map<String, dynamic> json) => ReceivedFriendListModel(
        users: json["users"] == null ? null : Users.fromJson(json["users"]),
    );
}

class Users {
    int? currentPage;
    List<ReceivedFriendData> data;
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

    Users({
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

    factory Users.fromJson(Map<String, dynamic> json) => Users(
        currentPage: json["current_page"],
        data: List<ReceivedFriendData>.from(json["data"].map((x) => ReceivedFriendData.fromJson(x))),
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

class ReceivedFriendData {
    int? id;
    String? image;
    String? userName;
    String? firstName;
    String? lastName;
    String? email;
    dynamic phone;
    String? gender;
    DateTime? dob;
    List<String> profession;
    List<String> interest;
    String? bio;
    String? languages;
    String? status;
    dynamic blockTill;
    String? otp;
    dynamic refId;
    String? relation;
    dynamic relationWithName;
    dynamic relationWithId;
    String? cover;
    String? fullName;
    String? profilePicture;
    String? coverPhoto;
    int? friendStatus;
    int? followStatus;
    String? familyRelationStatus;

    ReceivedFriendData({
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
        required this.cover,
        required this.fullName,
        required this.profilePicture,
        required this.coverPhoto,
        required this.friendStatus,
        required this.followStatus,
        required this.familyRelationStatus,
    });

    factory ReceivedFriendData.fromJson(Map<String, dynamic> json) => ReceivedFriendData(
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
        languages: json["languages"],
        status: json["status"],
        blockTill: json["block_till"],
        otp: json["otp"],
        refId: json["ref_id"],
        relation: json["relation"],
        relationWithName: json["relation_with_name"],
        relationWithId: json["relation_with_id"],
        cover: json["cover"],
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
    String ? label;
    bool active;

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