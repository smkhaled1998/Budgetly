
abstract class CategoryEntity {
  final int? categoryId;
  final String? name;
  final String? color;
  final String? icon;
  final double? allocatedAmount;
  final double storedSpentAmount;


  CategoryEntity({
    this.categoryId,
    required this.allocatedAmount,
    this.storedSpentAmount=0,
    this.icon,
    this.color,
    required this.name,
  });
}
