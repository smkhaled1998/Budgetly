abstract class CategoryEntity{
  final int? categoryId;
  final String name;
  final String color;
  final String icon;
  final String total;
  final String leftToSpend;
  final String spent;

  CategoryEntity({
     this.categoryId,
    required this.total,
    required this.leftToSpend,
    required this.spent,
    required this.icon,
    required this.color,
    required this.name});

}