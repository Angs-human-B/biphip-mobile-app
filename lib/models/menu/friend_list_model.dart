class FriendListModel {
    Friends friends;

    FriendListModel({
        required this.friends,
    });

    factory FriendListModel.fromJson(Map<String, dynamic> json) => FriendListModel(
        friends: Friends.fromJson(json["friends"]),
    );
}

class Friends {
    int currentPage;
    List<FriendListData> data;
    String firstPageUrl;
    int from;
    int lastPage;
    String lastPageUrl;
    List<Link> links;
    dynamic nextPageUrl;
    String path;
    int perPage;
    dynamic prevPageUrl;
    int to;
    int total;

    Friends({
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

    factory Friends.fromJson(Map<String, dynamic> json) => Friends(
        currentPage: json["current_page"],
        data: List<FriendListData>.from(json["data"].map((x) => FriendListData.fromJson(x))),
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

class FriendListData {
    int id;
    String userName;
    String email;
    dynamic phone;
    String gender;
    DateTime dob;
    String? profession;
    String? interest;
    String? bio;
    String? languages;
    String status;
    dynamic blockTill;
    String? otp;
    int? refId;
    String? relation;
    dynamic relationWithName;
    dynamic relationWithId;
    String fullName;
    dynamic profilePicture;
    String? coverPhoto;
    int friendStatus;
    int followStatus;
    String familyRelationStatus;

    FriendListData({
        required this.id,
        required this.userName,
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

    factory FriendListData.fromJson(Map<String, dynamic> json) => FriendListData(
        id: json["id"],
        userName: json["user_name"],
        email: json["email"],
        phone: json["phone"],
        gender: json["gender"],
        dob: DateTime.parse(json["dob"]),
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

class Link {
    String? url;
    String label;
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