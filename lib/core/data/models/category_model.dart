import '../../domain/entities/category_entity.dart';

class CategoryManagementModel extends CategoryEntity {
  CategoryManagementModel({
    super.categoryId,
    required super.allocatedAmount,
    super.icon,
    super.color,
    required super.name,
    super.storedSpentAmount
  });

  // Factory method to create CategoryModel from JSON
  factory CategoryManagementModel.fromJson(Map<String, dynamic> json) {
    return CategoryManagementModel(
      categoryId: json["categoryId"],
      allocatedAmount: json["allocatedAmount"] != null ? (json["allocatedAmount"] as num).toDouble() : 0.0,
      icon: json["icon"],
      color: json["color"],
      name: json["name"],
      storedSpentAmount: json["storedSpentAmount"],
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
      "storedSpentAmount": storedSpentAmount,
    };
  }
}
