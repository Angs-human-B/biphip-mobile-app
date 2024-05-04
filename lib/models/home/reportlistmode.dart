class ReportListModel {
    List<Report> reports;

    ReportListModel({
        required this.reports,
    });

    factory ReportListModel.fromJson(Map<String, dynamic> json) => ReportListModel(
        reports: List<Report>.from(json["reports"].map((x) => Report.fromJson(x))),
    );
}

class Report {
    int? id;
    String? title;
    String? description;
    int? isEditable;
    int? displayOrder;
    // DateTime createdAt;
    // DateTime updatedAt;

    Report({
        required this.id,
        required this.title,
        required this.description,
        required this.isEditable,
        required this.displayOrder,
        // required this.createdAt,
        // required this.updatedAt,
    });

    factory Report.fromJson(Map<String, dynamic> json) => Report(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        isEditable: json["is_editable"],
        displayOrder: json["display_order"],
        // createdAt: DateTime.parse(json["created_at"]),
        // updatedAt: DateTime.parse(json["updated_at"]),
    );
}