
import '../../domain/entities/category_entity.dart';

class BudgetModel extends CategoryEntity {
  BudgetModel(
      { super.categoryId,
      required super.total,
      required super.leftToSpend,
      required super.spent,
      required super.icon,
      required super.color,
      required super.name});

  factory BudgetModel.fromJson(Map<String, dynamic> json) {
    return BudgetModel(
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
