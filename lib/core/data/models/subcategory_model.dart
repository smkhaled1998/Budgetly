import '../../domain/entities/sub_category-entity.dart';

class SubcategoryModel extends SubcategoryEntity {
  SubcategoryModel({
    super.subCategoryId,
    super.parentCategoryId,
    required super.subcategoryIcon,
    required super.subcategoryColor,
    super.subcategorySpentAmount,
    required super.subcategoryName,
  });

  // Factory method to create CategoryModel from JSON
  factory SubcategoryModel.fromJson(Map<String, dynamic> json) {
    return SubcategoryModel(
        parentCategoryId:json["parentCategoryId"],
      subCategoryId: json["subCategoryId"],
      subcategoryIcon: json["subCategoryIcon"],
      subcategoryColor: json["subCategoryColor"],
      subcategoryName: json["subCategoryName"],
      subcategorySpentAmount: json["subcategorySpentAmount"]
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "parentCategoryId":parentCategoryId,
      "subcategoryName": subcategoryName,
      "subcategoryIcon": subcategoryIcon,
      "subcategoryColor": subcategoryColor ,
      "subcategoryId": subCategoryId,
      "subcategorySpentAmount": subcategorySpentAmount,
    };
  }
}
