
abstract class SubcategoryEntity {
  final int? subCategoryId;
  final int? parentCategoryId;
  final String? subcategoryName;
  final String? subcategoryColor;
  final String? subcategoryIcon;
  final double? subcategorySpentAmount;



  SubcategoryEntity({
    this.parentCategoryId,
    this.subCategoryId,
    this.subcategorySpentAmount,
    this.subcategoryIcon,
    this.subcategoryColor,
    required this.subcategoryName,
  });
}
