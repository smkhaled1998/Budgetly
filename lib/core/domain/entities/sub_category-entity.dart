
abstract class SubCategoryEntity {
  final int? subCategoryId;
  final int? categoryId;
  final String? subCategoryName;
  final String? subCategoryColor;
  final String? subCategoryIcon;



  SubCategoryEntity({
    this.categoryId,
    this.subCategoryId,
    this.subCategoryIcon,
    this.subCategoryColor,
    required this.subCategoryName,
  });
}
