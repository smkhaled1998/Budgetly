
import '../../domain/entities/category_entity.dart';

class CategoryModel extends CategoryEntity {
  CategoryModel(
      { super.categoryId,
      required super.total,
       super.leftToSpend,
       super.spent,
       super.icon,
       super.color,
      required super.name});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
        categoryId: json["categoryId"],
        total: json["total"],
        leftToSpend: json["leftToSpend"],
        spent: json["spent"],
        icon: json["icon"],
        color: json["color"],
        name: json["name"]);
  }

  Map<String, dynamic> toJson(){
    return {
      "name":name,
      "icon":icon,
      "color":color,
      "total":total,
      "spent":spent,
      "leftToSpend":leftToSpend,
      "categoryId":categoryId,

    };
  }
}
