class SearchFilterDataModel {
    All ?all;
    Posts? posts;
    People? people;
    People? photo;
    People? video;
    SellPost? sellPost;
    Kids ?kids;
    Kids ?news;

    SearchFilterDataModel({
        required this.all,
        required this.posts,
        required this.people,
        required this.photo,
        required this.video,
        required this.sellPost,
        required this.kids,
        required this.news,
    });

    factory SearchFilterDataModel.fromJson(Map<String, dynamic> json) => SearchFilterDataModel(
        all: json["all"]==null ? null : All.fromJson(json["all"]),
        posts: json["posts"]==null ? null : Posts.fromJson(json["posts"]),
        people: json["people"]==null ? null : People.fromJson(json["people"]),
        photo: json["photo"]==null?null:People.fromJson(json["photo"]),
        video: json["video"]==null ? null : People.fromJson(json["video"]),
        sellPost: json["sell_post"]==null?null: SellPost.fromJson(json["sell_post"]),
        kids: json["kids"]==null ? null : Kids.fromJson(json["kids"]),
        news: json["news"]==null ? null : Kids.fromJson(json["news"]),
    );
}

class All {
    String? key;
    String? value;

    All({
        required this.key,
        required this.value,
    });

    factory All.fromJson(Map<String, dynamic> json) => All(
        key: json["key"],
        value: json["value"],
    );
}

// enum Key {
//     ALL,
//     FAMILY,
//     FRIEND_N_FAMILY
// }

// final keyValues = EnumValues({
//     "all": Key.ALL,
//     "family": Key.FAMILY,
//     "Friend_n_family": Key.FRIEND_N_FAMILY
// });

// enum Value {
//     ALL,
//     FAMILY,
//     FRIEND,
//     FRIEND_FAMILY
// }

// final valueValues = EnumValues({
//     "All": Value.ALL,
//     "Family": Value.FAMILY,
//     "Friend": Value.FRIEND,
//     "Friend & family": Value.FRIEND_FAMILY
// });

class Kids {
    String key;
    String value;
    List<SubCategory> subCategory;
    List<PostedDate> postedDate;
    List<All> postedBy;

    Kids({
        required this.key,
        required this.value,
        required this.subCategory,
        required this.postedDate,
        required this.postedBy,
    });

    factory Kids.fromJson(Map<String, dynamic> json) => Kids(
        key: json["key"],
        value: json["value"],
        subCategory: List<SubCategory>.from(json["sub_category"].map((x) => SubCategory.fromJson(x))),
        postedDate: List<PostedDate>.from(json["posted_date"].map((x) => PostedDate.fromJson(x))),
        postedBy: List<All>.from(json["posted_by"].map((x) => All.fromJson(x))),
    );
}

class PostedDate {
    int key;
    int value;

    PostedDate({
        required this.key,
        required this.value,
    });

    factory PostedDate.fromJson(Map<String, dynamic> json) => PostedDate(
        key: json["key"],
        value: json["value"],
    );

}

class SubCategory {
    int key;
    String value;

    SubCategory({
        required this.key,
        required this.value,
    });

    factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
        key: json["key"],
        value: json["value"],
    );
}

class People {
    String key;
    String value;
    List<All> postedBy;
    List<PostedDate>? postedDate;

    People({
        required this.key,
        required this.value,
        required this.postedBy,
        this.postedDate,
    });

    factory People.fromJson(Map<String, dynamic> json) => People(
        key: json["key"],
        value: json["value"],
        postedBy: List<All>.from(json["posted_by"].map((x) => All.fromJson(x))),
        postedDate: json["posted_date"] == null ? [] : List<PostedDate>.from(json["posted_date"]!.map((x) => PostedDate.fromJson(x))),
    );
}

class Posts {
    String key;
    String value;
    List<RecentPost> recentPost;
    List<All> postedBy;
    List<PostedDate> postedDate;
    List<SubCategory> postCategory;

    Posts({
        required this.key,
        required this.value,
        required this.recentPost,
        required this.postedBy,
        required this.postedDate,
        required this.postCategory,
    });

    factory Posts.fromJson(Map<String, dynamic> json) => Posts(
        key: json["key"],
        value: json["value"],
        recentPost: List<RecentPost>.from(json["recent_post"].map((x) => RecentPost.fromJson(x))),
        postedBy: List<All>.from(json["posted_by"].map((x) => All.fromJson(x))),
        postedDate: List<PostedDate>.from(json["posted_date"].map((x) => PostedDate.fromJson(x))),
        postCategory: List<SubCategory>.from(json["post_category"].map((x) => SubCategory.fromJson(x))),
    );
}

class RecentPost {
    String key;
    bool value;

    RecentPost({
        required this.key,
        required this.value,
    });

    factory RecentPost.fromJson(Map<String, dynamic> json) => RecentPost(
        key: json["key"],
        value: json["value"],
    );
}

class SellPost {
    String key;
    String value;
    List<SubCategory> postType;
    List<SubCategory> condition;
    List<SubCategory> category;
    List<All> postedBy;

    SellPost({
        required this.key,
        required this.value,
        required this.postType,
        required this.condition,
        required this.category,
        required this.postedBy,
    });

    factory SellPost.fromJson(Map<String, dynamic> json) => SellPost(
        key: json["key"],
        value: json["value"],
        postType: List<SubCategory>.from(json["post_type"].map((x) => SubCategory.fromJson(x))),
        condition: List<SubCategory>.from(json["condition"].map((x) => SubCategory.fromJson(x))),
        category: List<SubCategory>.from(json["category"].map((x) => SubCategory.fromJson(x))),
        postedBy: List<All>.from(json["posted_by"].map((x) => All.fromJson(x))),
    );
}
