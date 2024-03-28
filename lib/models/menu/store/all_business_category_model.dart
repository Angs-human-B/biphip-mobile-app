class AllBusinessCategoryModel {
    BusinessCategories? businessCategories;

    AllBusinessCategoryModel({
        required this.businessCategories,
    });

    factory AllBusinessCategoryModel.fromJson(Map<String, dynamic> json) => AllBusinessCategoryModel(
        businessCategories: BusinessCategories.fromJson(json["business_categories"]),
    );
}

class BusinessCategories {
    List<BusinessCategory> data;

    BusinessCategories({
        required this.data,
    });

    factory BusinessCategories.fromJson(Map<String, dynamic> json) => BusinessCategories(
        data: List<BusinessCategory>.from(json["data"].map((x) => BusinessCategory.fromJson(x))),
    );

}

class BusinessCategory {
    String value;

    BusinessCategory({
        required this.value,
    });

    factory BusinessCategory.fromJson(Map<String, dynamic> json) => BusinessCategory(
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "value": value,
    };
}


