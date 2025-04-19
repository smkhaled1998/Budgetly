
abstract class CategoryManagementEntity {
  final int? categoryId;
  final String? name;
  final String? color;
  final String? icon;
  final double? allocatedAmount;
  final double storedSpentAmount;


  CategoryManagementEntity({
    this.categoryId,
    required this.allocatedAmount,
    this.storedSpentAmount=0,
    this.icon,
    this.color,
    required this.name,
  });
}
