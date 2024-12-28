
abstract class CategoryEntity {
  final int? categoryId;
  final String? name;
  final String? color;
  final String? icon;
  final double? allocatedAmount;
  final double spentAmount;


  CategoryEntity({
    this.categoryId,
    required this.allocatedAmount,
    this.spentAmount=0,
    this.icon,
    this.color,
    required this.name,
  });
}
