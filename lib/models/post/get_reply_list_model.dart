

import 'package:bip_hip/models/common/common_link_model.dart';
import 'package:bip_hip/models/post/new_post_comment.dart';

class ReplyListModel {
  CommentReplies? commentReplies;

  ReplyListModel({
    required this.commentReplies,
  });

  factory ReplyListModel.fromJson(Map<String, dynamic> json) => ReplyListModel(
        commentReplies: json["commentReplies"] == null ? null : CommentReplies.fromJson(json["commentReplies"]),
      );
}

class CommentReplies {
  int? currentPage;
  List<CommentReply> data;
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

  CommentReplies({
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

  factory CommentReplies.fromJson(Map<String, dynamic> json) => CommentReplies(
        currentPage: json["current_page"],
        data: List<CommentReply>.from(json["data"].map((x) => CommentReply.fromJson(x))),
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