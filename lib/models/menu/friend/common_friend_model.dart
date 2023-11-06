import 'package:bip_hip/models/common/common_friend_family_user_model.dart';
import 'package:bip_hip/models/common/common_link_model.dart';

class CommonSendReceiveModel {
  CommonFriends? users;

  CommonSendReceiveModel({
    required this.users,
  });

  factory CommonSendReceiveModel.fromJson(Map<String, dynamic> json) => CommonSendReceiveModel(
        users: json["users"] == null ? null : CommonFriends.fromJson(json["users"]),
      );
}

class CommonFriendModel {
  CommonFriends? friends;

  CommonFriendModel({
    required this.friends,
  });

  factory CommonFriendModel.fromJson(Map<String, dynamic> json) => CommonFriendModel(
        friends: json["friends"] == null ? null : CommonFriends.fromJson(json["friends"]),
      );
}

class CommonFriends {
  int? currentPage;
  List<FriendFamilyUserData> data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<CommonLink> links;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  CommonFriends({
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

  factory CommonFriends.fromJson(Map<String, dynamic> json) => CommonFriends(
        currentPage: json["current_page"],
        data: List<FriendFamilyUserData>.from(json["data"].map((x) => FriendFamilyUserData.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: List<CommonLink>.from(json["links"].map((x) => CommonLink.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );
}
