import '../../../../core/domain/entities/category_entity.dart';
import '../../../transaction/domain/entities/transaction_entity.dart';

abstract class SubcategoryStates{}

class CategoryManagementInitialStates extends SubcategoryStates{}


/// States for handling category insertion
class CategoryInsertionLoadingState extends SubcategoryStates {}
class CategoryInsertedState extends SubcategoryStates {}
class CategoryInsertionErrorState extends SubcategoryStates {
  final String message;
  CategoryInsertionErrorState(this.message);
}

/// States for handling category updates
class CategoryUpdateLoadingState extends SubcategoryStates {}
class CategoryUpdatedState extends SubcategoryStates {}
class CategoryUpdateErrorState extends SubcategoryStates {
  final String message;
  CategoryUpdateErrorState(this.message);
}

/// States for handling category Delete
class CategoryDeleteLoadingState extends SubcategoryStates {}
class CategoryDeletedState extends SubcategoryStates {}
class CategoryDeleteErrorState extends SubcategoryStates {
  final String message;
  CategoryDeleteErrorState(this.message);
}
/// States for handling category retrieval
class GetCategoryDataLoadingState extends SubcategoryStates {}
class GetCategoryDataSuccessState extends SubcategoryStates {
  final List<CategoryEntity> categories;
  GetCategoryDataSuccessState({required this.categories});
}
class GetCategoryDataErrorState extends SubcategoryStates {
  final String errorMessage;
  GetCategoryDataErrorState({required this.errorMessage});
}

/// States for handling UI interactions
// class ChangeAppearanceState extends SubcategoryStates {
//   final List<CategoryEntity> items;
//   ChangeAppearanceState({required this.items});
//
// }


// class UpdateSpentAmountLoadingState extends TransactionStates {}
// class UpdateSpentAmountSuccessState extends TransactionStates {
//   UpdateSpentAmountSuccessState();
// }
// class UpdateSpentAmountErrorState extends TransactionStates {
//   final String errorMessage;
//   UpdateSpentAmountErrorState({required this.errorMessage});
// }

class ToggleCategoryEditModeState extends SubcategoryStates {}
class AddSettingUpCategoryState extends SubcategoryStates {}
class AddSettingUpCategoryLoadingState extends SubcategoryStates {}

