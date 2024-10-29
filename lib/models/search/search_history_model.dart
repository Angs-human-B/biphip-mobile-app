import 'package:bip_hip/models/common/common_link_model.dart';

class SearchHistoryModel {
  SearchHistories? searchHistories;

  SearchHistoryModel({
    required this.searchHistories,
  });

  factory SearchHistoryModel.fromJson(Map<String, dynamic> json) => SearchHistoryModel(
        searchHistories: json["searchHistories"] == null ? null : SearchHistories.fromJson(json["searchHistories"]),
      );
}

class SearchHistories {
  int? currentPage;
  List<SearchHistoryListData> data;
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

  SearchHistories({
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

  factory SearchHistories.fromJson(Map<String, dynamic> json) => SearchHistories(
        currentPage: json["current_page"],
        data: List<SearchHistoryListData>.from(json["data"].map((x) => SearchHistoryListData.fromJson(x))),
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

class SearchHistoryListData {
  int? id;
  int? userId;
  String? keywords;

  SearchHistoryListData({
    required this.id,
    required this.userId,
    required this.keywords,
  });

  factory SearchHistoryListData.fromJson(Map<String, dynamic> json) => SearchHistoryListData(
        id: json["id"],
        userId: json["user_id"],
        keywords: json["keywords"],
      );
}