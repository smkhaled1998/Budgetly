abstract class CategoryEntity{
  final int? categoryId;
  final String name;
  final String? color;
  final String? icon;
  final String total;
  final String? leftToSpend;
  final String spent;

  CategoryEntity({
     this.categoryId,
    required this.total,
     this.leftToSpend="",
     this.spent="",
     this.icon,
     this.color,
    required this.name});

}