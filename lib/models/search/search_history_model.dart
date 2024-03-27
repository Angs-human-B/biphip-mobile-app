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
  List<Link> links;
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
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
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
