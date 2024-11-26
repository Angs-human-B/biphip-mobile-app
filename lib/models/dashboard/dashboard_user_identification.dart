class UserIdentificationModel {
  final int id;
  final int? userId;
  final String? type;
  final String? country;
  final String? firstName;
  final String? lastName;
  final String? idNumber;
  final DateTime? issueDate;
  final DateTime? endDate;
  final String? schoolCollege;
  final String? status;
  final String? documentFront;
  final String? documentBack;
  final String? passportInfoPage;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserIdentificationModel({
    required this.id,
    this.userId,
    this.type,
    this.country,
    this.firstName,
    this.lastName,
    this.idNumber,
    this.issueDate,
    this.endDate,
    this.schoolCollege,
    this.status,
    this.documentFront,
    this.documentBack,
    this.passportInfoPage,
    this.createdAt,
    this.updatedAt,
  });

  factory UserIdentificationModel.fromJson(Map<String, dynamic> json) {
    print ("print id: ${json['id']}");
    return UserIdentificationModel(
      id: json['id'],
      userId: json['user_id'] as int?,
      type: json['type'] as String?,
      country: json['country'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      idNumber: json['id_number'] as String?,
      issueDate: json['issue_date'] != null
          ? DateTime.tryParse(json['issue_date'])
          : null,
      endDate: json['end_date'] != null
          ? DateTime.tryParse(json['end_date'])
          : null,
      schoolCollege: json['school_college'] as String?,
      status: json['status'] as String?,
      documentFront: json['document_front'] as String?,
      documentBack: json['document_back'] as String?,
      passportInfoPage: json['passport_info_page'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
    );
  }

  // Method to convert an instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'type': type,
      'country': country,
      'first_name': firstName,
      'last_name': lastName,
      'id_number': idNumber,
      'issue_date': issueDate?.toIso8601String(),
      'end_date': endDate?.toIso8601String(),
      'school_college': schoolCollege,
      'status': status,
      'document_front': documentFront,
      'document_back': documentBack,
      'passport_info_page': passportInfoPage,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
