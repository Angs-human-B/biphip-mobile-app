import 'package:bip_hip/models/common/Common_link_model.dart';
import 'package:bip_hip/models/common/common_friend_family_user_model.dart';

class CommonFamilySendReceiveModel {
  CommonFamilies? users;

  CommonFamilySendReceiveModel({
    required this.users,
  });

  factory CommonFamilySendReceiveModel.fromJson(Map<String, dynamic> json) => CommonFamilySendReceiveModel(
        users: CommonFamilies.fromJson(json["users"]),
      );
}

class CommonFamilyModel {
  CommonFamilies? families;

  CommonFamilyModel({
    required this.families,
  });

  factory CommonFamilyModel.fromJson(Map<String, dynamic> json) => CommonFamilyModel(
        families: CommonFamilies.fromJson(json["families"]),
      );
}

class CommonFamilies {
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

  CommonFamilies({
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

  factory CommonFamilies.fromJson(Map<String, dynamic> json) => CommonFamilies(
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



