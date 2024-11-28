import '../../domain/entities/category_entity.dart';

class CategoryModel extends CategoryEntity {
  CategoryModel({
    super.categoryId,
    required super.allocatedAmount,
    super.icon,
    super.color,
    required super.name,
    super.spentAmount
  });

  // Factory method to create CategoryModel from JSON
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      categoryId: json["categoryId"],
      allocatedAmount: json["allocatedAmount"] != null ? (json["allocatedAmount"] as num).toDouble() : 0.0,
      icon: json["icon"],
      color: json["color"],
      name: json["name"],
      spentAmount: json["spentAmount"],
    );
  }

  // Method to convert CategoryModel instance to JSON
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "icon": icon,
      "color": color,
      "allocatedAmount": allocatedAmount,
      "categoryId": categoryId,
      "spentAmount": spentAmount,
    };
  }
}
