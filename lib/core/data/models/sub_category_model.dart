import '../../domain/entities/category_entity.dart';
import '../../domain/entities/sub_category-entity.dart';

class SubCategoryModel extends SubCategoryEntity {
  SubCategoryModel({
    super.subCategoryId,
    super.subCategoryIcon,
    super.subCategoryColor,
    required super.subCategoryName,
  });

  // Factory method to create CategoryModel from JSON
  factory SubCategoryModel.fromJson(Map<String, dynamic> json) {
    return SubCategoryModel(
      subCategoryId: json["subCategoryId"],
      subCategoryIcon: json["subCategoryIcon"],
      subCategoryColor: json["subCategoryColor"],
      subCategoryName: json["subCategoryName"],
    );
  }

  // Method to convert CategoryModel instance to JSON
  Map<String, dynamic> toJson() {
    return {
      "subCategoryName": subCategoryName,
      "subCategoryIcon": subCategoryIcon,
      "subCategoryColor": subCategoryColor ,
      "subCategoryId": subCategoryId,
    };
  }
}
