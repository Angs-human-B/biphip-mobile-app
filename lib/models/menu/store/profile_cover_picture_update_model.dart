class ProfileCoverPictureUpdateModel {
    int ?id;
    String? pageType;
    String? pageId;
    int ?userId;
    String? name;
    String? bio;
    dynamic age;
    dynamic dob;
    dynamic relationId;
    List<String> categories;
    String ?image;
    String ?cover;
    String ?bin;
    dynamic country;
    int ?rating;
    List<dynamic> hobbies;
    List<dynamic> languages;
    dynamic gender;
    dynamic privacyLink;
    String? qr;
    String? legalFiles;
    dynamic introVideo;
    String ?email;
    String ?phone;
    String ?address;
    String ?profilePicture;
    String ?coverPhoto;
    int ?profileImageId;
    int ?coverImageId;
    String ?qrCode;
    List<String> legalPapers;
    dynamic introVideoFile;
    int ?countFollowers;
    int ?countPageRating;
    int ?countPageReviews;
    dynamic relation;

    ProfileCoverPictureUpdateModel({
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
    });

    factory ProfileCoverPictureUpdateModel.fromJson(Map<String, dynamic> json) => ProfileCoverPictureUpdateModel(
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
        hobbies: List<dynamic>.from(json["hobbies"].map((x) => x)),
        languages: List<dynamic>.from(json["languages"].map((x) => x)),
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
        legalPapers: List<String>.from(json["legal_papers"].map((x) => x)),
        introVideoFile: json["intro_video_file"],
        countFollowers: json["count_followers"],
        countPageRating: json["count_page_rating"],
        countPageReviews: json["count_page_reviews"],
        relation: json["relation"],
    );
}